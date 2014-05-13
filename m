Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3 2/5] Bluetooth: Add support to get connection information
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAF3PWx1GfvfPm5TN9OuDi9jPCWNtjsELyRR-eG3rmDHi6sHPRQ@mail.gmail.com>
Date: Tue, 13 May 2014 11:59:23 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <52A402F5-1159-4BE3-9F2A-8B5713E52B52@holtmann.org>
References: <1399974751-7226-1-git-send-email-andrzej.kaczmarek@tieto.com> <1399974751-7226-3-git-send-email-andrzej.kaczmarek@tieto.com> <2978AA04-546F-4BE3-868E-DD03F243BEE9@holtmann.org> <CAF3PWx1GfvfPm5TN9OuDi9jPCWNtjsELyRR-eG3rmDHi6sHPRQ@mail.gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

>>> This patch adds support for Get Connection Information mgmt command
>>> which can be used to query for information about connection, i.e. RSSI
>>> and local TX power level.
>>> 
>>> In general values cached in hci_conn are returned as long as they are
>>> considered valid, i.e. do not exceed age limit set in hdev. This limit
>>> is calculated as random value between min/max values to avoid client
>>> trying to guess when to poll for updated information.
>>> 
>>> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
>>> ---
>>> include/net/bluetooth/hci_core.h |   2 +
>>> include/net/bluetooth/mgmt.h     |  13 +++
>>> net/bluetooth/mgmt.c             | 194 +++++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 209 insertions(+)
>>> 
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 4623f45..cbbab63 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -384,6 +384,8 @@ struct hci_conn {
>>>      __s8            tx_power;
>>>      unsigned long   flags;
>>> 
>>> +     unsigned long   conn_info_timestamp;
>>> +
>>>      __u8            remote_cap;
>>>      __u8            remote_auth;
>>>      __u8            remote_id;
>>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>>> index d4b571c..9b60367 100644
>>> --- a/include/net/bluetooth/mgmt.h
>>> +++ b/include/net/bluetooth/mgmt.h
>>> @@ -409,6 +409,19 @@ struct mgmt_cp_load_irks {
>>> } __packed;
>>> #define MGMT_LOAD_IRKS_SIZE           2
>>> 
>>> +#define MGMT_CONN_INFO_DATA_TX_POWER 0x00000001
>>> +
>>> +#define MGMT_OP_GET_CONN_INFO                0x0031
>>> +struct mgmt_cp_get_conn_info {
>>> +     struct mgmt_addr_info addr;
>>> +} __packed;
>>> +#define MGMT_GET_CONN_INFO_SIZE              MGMT_ADDR_INFO_SIZE
>>> +struct mgmt_rp_get_conn_info {
>>> +     struct mgmt_addr_info addr;
>>> +     __s8    rssi;
>>> +     __s8    tx_power;
>>> +} __packed;
>> 
>> add the max_tx_power here right from the start and initialize it to invalid. When we ever have to bisect it, we do not want an API change in between.
>> 
>>> +
>>> #define MGMT_EV_CMD_COMPLETE          0x0001
>>> struct mgmt_ev_cmd_complete {
>>>      __le16  opcode;
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index f2a9422..c3e4382 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -83,6 +83,7 @@ static const u16 mgmt_commands[] = {
>>>      MGMT_OP_SET_DEBUG_KEYS,
>>>      MGMT_OP_SET_PRIVACY,
>>>      MGMT_OP_LOAD_IRKS,
>>> +     MGMT_OP_GET_CONN_INFO,
>>> };
>>> 
>>> static const u16 mgmt_events[] = {
>>> @@ -4557,6 +4558,198 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
>>>      return err;
>>> }
>>> 
>>> +struct cmd_conn_lookup {
>>> +     struct hci_conn *conn;
>>> +     bool valid_tx_power;
>>> +     u8 mgmt_status;
>>> +};
>>> +
>>> +static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
>>> +{
>>> +     struct cmd_conn_lookup *match = data;
>>> +     struct mgmt_cp_get_conn_info *cp;
>>> +     struct mgmt_rp_get_conn_info rp;
>>> +     struct hci_conn *conn = cmd->user_data;
>>> +
>>> +     if (conn != match->conn)
>>> +             return;
>>> +
>>> +     cp = (struct mgmt_cp_get_conn_info *) cmd->param;
>>> +
>>> +     memset(&rp, 0, sizeof(rp));
>>> +     bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
>>> +     rp.addr.type = cp->addr.type;
>>> +
>>> +     if (!match->mgmt_status) {
>>> +             rp.rssi = conn->rssi;
>>> +
>>> +             if (match->valid_tx_power)
>>> +                     rp.tx_power = conn->tx_power;
>>> +             else
>>> +                     rp.tx_power = HCI_TX_POWER_INVALID;
>>> +     }
>>> +
>>> +     cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
>>> +                  match->mgmt_status, &rp, sizeof(rp));
>>> +
>>> +     hci_conn_drop(conn);
>>> +
>>> +     mgmt_pending_remove(cmd);
>>> +}
>>> +
>>> +static void conn_info_refresh_complete(struct hci_dev *hdev, u8 status)
>>> +{
>>> +     struct hci_cp_read_rssi *cp;
>>> +     struct hci_conn *conn;
>>> +     struct cmd_conn_lookup match;
>>> +     u16 handle;
>>> +
>>> +     BT_DBG("status 0x%02x", status);
>>> +
>>> +     hci_dev_lock(hdev);
>>> +
>>> +     /* TX power data is valid in case request completed successfully,
>>> +      * otherwise we assume it's not valid.
>>> +      */
>>> +     match.valid_tx_power = !status;
>>> +
>>> +     /* Commands sent in request are either Read RSSI or Read Transmit Power
>>> +      * Level so we check which one was last sent to retrieve connection
>>> +      * handle.  Both commands have handle as first parameter so it's safe to
>>> +      * cast data on the same command struct.
>>> +      *
>>> +      * First command sent is always Read RSSI and we fail only if it fails.
>>> +      * In other case we simply override error to indicate success as we
>>> +      * already remembered if TX power value is actually valid.
>>> +      */
>>> +     cp = hci_sent_cmd_data(hdev, HCI_OP_READ_RSSI);
>>> +     if (!cp) {
>>> +             cp = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER);
>>> +             status = 0;
>>> +     }
>>> +
>>> +     if (!cp) {
>>> +             BT_ERR("invalid sent_cmd in response");
>>> +             goto unlock;
>>> +     }
>>> +
>>> +     handle = __le16_to_cpu(cp->handle);
>>> +     conn = hci_conn_hash_lookup_handle(hdev, handle);
>>> +     if (!conn) {
>>> +             BT_ERR("unknown handle (%d) in response", handle);
>>> +             goto unlock;
>>> +     }
>>> +
>>> +     match.conn = conn;
>>> +     match.mgmt_status = mgmt_status(status);
>>> +
>>> +     /* Cache refresh is complete, now reply for mgmt request for given
>>> +      * connection only.
>>> +      */
>>> +     mgmt_pending_foreach(MGMT_OP_GET_CONN_INFO, hdev,
>>> +                          get_conn_info_complete, &match);
>>> +
>>> +unlock:
>>> +     hci_dev_unlock(hdev);
>>> +}
>>> +
>>> +static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
>>> +                      u16 len)
>>> +{
>>> +     struct mgmt_cp_get_conn_info *cp = data;
>>> +     struct mgmt_rp_get_conn_info rp;
>>> +     struct hci_conn *conn;
>>> +     unsigned long conn_info_age;
>>> +     int err = 0;
>>> +
>>> +     BT_DBG("%s", hdev->name);
>>> +
>>> +     memset(&rp, 0, sizeof(rp));
>>> +     bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
>>> +     rp.addr.type = cp->addr.type;
>> 
>> Do we really want to just keep zeroed out values and not set the values to invalid. What are we doing for other commands that require the same return parameters set to match up with the remote address.
> 
> Actually there's no other command which returns address *and* some
> parameters so this will be first one. So in case of failure should we
> put proper 'invalid' values into response parameter and not just
> leaving them set to zero? There is always error code which means
> request failed and returned parameters are invalid anyway. And in case
> of success response we overwrite zeroes with proper values of course.

good question. Johan, what do you think?

Regards

Marcel

