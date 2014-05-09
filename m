Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1B850722-AB40-4125-9066-4B8778926541@holtmann.org>
References: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1399664133-2892-4-git-send-email-andrzej.kaczmarek@tieto.com> <1B850722-AB40-4125-9066-4B8778926541@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Sat, 10 May 2014 00:39:02 +0200
Message-ID: <CAF3PWx2UBK67VCudPL61tM_6_iCiBvkZL=ZG+7m9zDo3oTA+5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] Bluetooth: Add support to get connection information
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 9 May 2014 23:26, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> This patch adds support for Get Connection Information mgmt command
>> which can be used to query for information about connection, i.e. RSSI
>> or local TX power level.
>>
>> RSSI is returned as response parameter while any other information is
>> returned in standard EIR format.
>>
>> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
>> ---
>> include/net/bluetooth/hci_core.h |   2 +
>> include/net/bluetooth/mgmt.h     |  16 +++
>> net/bluetooth/mgmt.c             | 216 +++++++++++++++++++++++++++++++++=
++++++
>> 3 files changed, 234 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index 211bad6..9be523a 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -378,6 +378,8 @@ struct hci_conn {
>>       __s8            tx_power;
>>       unsigned long   flags;
>>
>> +     unsigned long   conn_info_timestamp;
>> +
>>       __u8            remote_cap;
>>       __u8            remote_auth;
>>       __u8            remote_id;
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index d4b571c..34faa2e 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -409,6 +409,22 @@ struct mgmt_cp_load_irks {
>> } __packed;
>> #define MGMT_LOAD_IRKS_SIZE           2
>>
>> +#define MGMT_CONN_INFO_DATA_TX_POWER 0x00000001
>> +
>> +#define MGMT_OP_GET_CONN_INFO                0x0031
>> +struct mgmt_cp_get_conn_info {
>> +     struct mgmt_addr_info addr;
>> +     __u32   data_type;
>
> the current idea is to remove the data_type and just provide the address =
information in the command.
>
>> +} __packed;
>> +#define MGMT_GET_CONN_INFO_SIZE              (MGMT_ADDR_INFO_SIZE + 4)
>> +struct mgmt_rp_get_conn_info {
>> +     struct mgmt_addr_info addr;
>> +     __s8    rssi;
>
> lets just add __s8 tx_power and __s8 max_tx_power here and that is it. No=
 extra flags or any other details.
>> +     __u32   flags;
>> +     __le16  eir_len;
>> +     __u8    eir[0];
>> +} __packed;
>
> The EIR looked like a good idea in the beginning, but it seems not so muc=
h of a good idea anymore.
>
>> +
>> #define MGMT_EV_CMD_COMPLETE          0x0001
>> struct mgmt_ev_cmd_complete {
>>       __le16  opcode;
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 5e88ac9..2d86ce1 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -83,6 +83,7 @@ static const u16 mgmt_commands[] =3D {
>>       MGMT_OP_SET_DEBUG_KEYS,
>>       MGMT_OP_SET_PRIVACY,
>>       MGMT_OP_LOAD_IRKS,
>> +     MGMT_OP_GET_CONN_INFO,
>> };
>>
>> static const u16 mgmt_events[] =3D {
>> @@ -113,6 +114,8 @@ static const u16 mgmt_events[] =3D {
>>
>> #define CACHE_TIMEOUT msecs_to_jiffies(2 * 1000)
>>
>> +#define CONN_INFO_MAX_AGE    msecs_to_jiffies(2 * 1000)
>> +
>> #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
>>                               !test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
>>
>> @@ -4568,6 +4571,218 @@ static int load_long_term_keys(struct sock *sk, =
struct hci_dev *hdev,
>>       return err;
>> }
>>
>> +struct cmd_conn_lookup {
>> +     struct hci_conn *conn;
>> +     u8 mgmt_status;
>> +};
>> +
>> +static void get_conn_info_complete(struct pending_cmd *cmd, void *data)
>> +{
>> +     struct cmd_conn_lookup *match =3D data;
>> +     struct mgmt_cp_get_conn_info *cp;
>> +     struct mgmt_rp_get_conn_info *rp;
>> +     char buf[sizeof(*rp) + 3];
>> +     struct hci_conn *conn =3D cmd->user_data;
>> +     __u16 eir_len =3D 0;
>> +
>> +     if (conn !=3D match->conn)
>> +             return;
>> +
>> +     cp =3D (struct mgmt_cp_get_conn_info *) cmd->param;
>> +     rp =3D (struct mgmt_rp_get_conn_info *) buf;
>> +
>> +     memset(buf, 0, sizeof(buf));
>> +     bacpy(&rp->addr.bdaddr, &cp->addr.bdaddr);
>> +     rp->addr.type =3D cp->addr.type;
>
> actually I would prefer if we use HCI_TX_POWER_INVALID here and also set =
the RSSI to a default value. I think it is 0 for BR/EDR and some magic valu=
e for LE.
>
>> +
>> +     if (match->mgmt_status) {
>> +             cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
>> +                          match->mgmt_status, rp, sizeof(*rp));
>> +             goto done;
>> +     }
>> +
>> +     rp->rssi =3D conn->rssi;
>> +
>> +     if (cp->data_type & MGMT_CONN_INFO_DATA_TX_POWER) {
>> +             eir_len =3D eir_append_data(rp->eir, 0, EIR_TX_POWER,
>> +                                       &conn->tx_power,
>> +                                       sizeof(conn->tx_power));
>> +
>> +             rp->eir_len =3D cpu_to_le16(eir_len);
>> +     }
>> +
>> +     cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
>> +                     MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
>> +
>> +done:
>> +     hci_conn_drop(conn);
>> +
>> +     mgmt_pending_remove(cmd);
>> +}
>> +
>> +static void conn_info_refresh_complete(struct hci_dev *hdev, u8 status)
>> +{
>> +     struct hci_cp_read_rssi *cp;
>> +     struct hci_conn *conn;
>> +     struct cmd_conn_lookup match;
>> +     u16 handle;
>> +
>> +     BT_DBG("status 0x%02x", status);
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     /* Last command sent in request should be Read RSSI, but if it isn=
't
>> +      * then we look for Read Transmit Power Level which is other comma=
nd
>> +      * sent in request and probably failed.
>> +      *
>> +      * Both commands have handle as first parameter so it's safe to ca=
st
>> +      * data on the same command struct.
>> +      */
>
> I do not like this order. I like it RSSI, TX Power and then TX Max Power.=
 Only if RSSI fails we should return an error. The others should still succ=
eed.
>
>> +     cp =3D hci_sent_cmd_data(hdev, HCI_OP_READ_RSSI);
>> +     if (!cp)
>> +             cp =3D hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER_LEVEL)=
;
>> +
>> +     if (!cp) {
>> +             BT_ERR("invalid sent_cmd in response");
>> +             goto unlock;
>> +     }
>> +
>> +     handle =3D __le16_to_cpu(cp->handle);
>> +     conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>> +     if (!conn) {
>> +             BT_ERR("unknown handle (%d) in response", handle);
>> +             goto unlock;
>> +     }
>> +
>> +     if (!status)
>> +             conn->conn_info_timestamp =3D jiffies;
>> +
>> +     match.conn =3D conn;
>> +     match.mgmt_status =3D mgmt_status(status);
>> +
>> +     /* Cache refresh is complete, now reply for each pending request f=
or
>> +      * given connection.
>> +      */
>> +     mgmt_pending_foreach(MGMT_OP_GET_CONN_INFO, hdev,
>> +                          get_conn_info_complete, &match);
>> +
>> +unlock:
>> +     hci_dev_unlock(hdev);
>> +}
>> +
>> +static bool check_pending_conn_info(struct hci_dev *hdev, struct hci_co=
nn *conn)
>> +{
>> +     struct pending_cmd *cmd;
>> +
>> +     list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
>> +             if (cmd->opcode =3D=3D MGMT_OP_GET_CONN_INFO &&
>> +                 cmd->user_data =3D=3D conn)
>> +                     return true;
>> +     }
>> +
>> +     return false;
>> +}
>> +
>> +static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *d=
ata,
>> +                      u16 len)
>> +{
>> +     struct mgmt_cp_get_conn_info *cp =3D data;
>> +     struct mgmt_rp_get_conn_info rp;
>> +     struct hci_conn *conn;
>> +     struct pending_cmd *cmd;
>> +     struct hci_request req;
>> +     bool is_pending;
>> +     int err =3D 0;
>> +
>> +     BT_DBG("%s", hdev->name);
>> +
>> +     memset(&rp, 0, sizeof(rp));
>> +     bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
>> +     rp.addr.type =3D cp->addr.type;
>
> We need to fill in proper defaults that indicate that the values are inva=
lid. See above comment.
>
>> +
>> +     if (!bdaddr_type_is_valid(cp->addr.type))
>> +             return cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
>> +                                 MGMT_STATUS_INVALID_PARAMS,
>> +                                 &rp, sizeof(rp));
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     if (!hdev_is_powered(hdev)) {
>> +             err =3D cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
>> +                                MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp=
));
>> +             goto unlock;
>> +     }
>> +
>> +     if (cp->addr.type =3D=3D BDADDR_BREDR)
>> +             conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>> +                                            &cp->addr.bdaddr);
>> +     else
>> +             conn =3D hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.=
bdaddr);
>> +
>> +     if (!conn || conn->state !=3D BT_CONNECTED) {
>> +             err =3D cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
>> +                                MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(=
rp));
>> +             goto unlock;
>> +     }
>> +
>> +     /* We need to check if there's another pending request for this co=
nn
>> +      * so we don't query controller again - just add another pending a=
nd
>> +      * return.
>> +      */
>> +     is_pending =3D check_pending_conn_info(hdev, conn);
>
> I wonder if we should be really naive here and not try too outsmart ourse=
lves. Maybe we should just do this timestamp based. If you happen to call t=
he same mgmt command while we are executing one to get new values, you are =
just out of luck and get the old caches values.

Removing this won't really simplify code, it's just few lines of code
which will be removed. And you can imagine (unlikely to happen, but
still...) scenario in which two clients are pooling for conn info on
different devices at the same time and somehow 2nd is always out of
luck - it won't never get up-to-date values because only 1st device is
refreshed. I'd keep this.

BR,
Andrzej
