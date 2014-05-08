Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0BB354F3-D0A5-43A5-BF69-C679D68977CF@holtmann.org>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1399555935-702-6-git-send-email-andrzej.kaczmarek@tieto.com> <0BB354F3-D0A5-43A5-BF69-C679D68977CF@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Thu, 8 May 2014 21:57:05 +0200
Message-ID: <CAF3PWx3pYfxrrAh_yxd6xNhg58KJ9DeRkxB6FvBvco5=anf1uw@mail.gmail.com>
Subject: Re: [PATCH 5/8] Bluetooth: Add support to get connection information
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 8 May 2014 17:26, Marcel Holtmann <marcel@holtmann.org> wrote:
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
>> include/net/bluetooth/mgmt.h     |  16 ++++
>> net/bluetooth/mgmt.c             | 176 +++++++++++++++++++++++++++++++++=
++++++
>> 3 files changed, 194 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index 30d245f..8d7d48b 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -378,6 +378,8 @@ struct hci_conn {
>>       __s8            tx_power;
>>       unsigned long   flags;
>>
>> +     unsigned long   last_info_read;
>> +
>
> I will clearly mark this as timestamp. Similar to what we do with the inq=
uiry cache.
>
>>       __u8            remote_cap;
>>       __u8            remote_auth;
>>       __u8            remote_id;
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index d4b571c..c26b7e2 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -409,6 +409,22 @@ struct mgmt_cp_load_irks {
>> } __packed;
>> #define MGMT_LOAD_IRKS_SIZE           2
>>
>> +#define MGMT_CONN_INFO_DATA_TX_POWER 0x00000001
>> +
>> +#define MGMT_OP_GET_CONN_INFORMATION 0x0031
>> +struct mgmt_cp_get_conn_information {
>> +     struct mgmt_addr_info addr;
>> +     __u32   data_type;
>> +} __packed;
>> +#define MGMT_GET_CONN_INFORMATION_SIZE       (MGMT_ADDR_INFO_SIZE + 4)
>> +struct mgmt_rp_get_conn_information {
>> +     struct mgmt_addr_info addr;
>> +     __s8    rssi;
>> +     __u32   flags;
>> +     __le16  eir_len;
>> +     __u8    eir[0];
>> +} __packed;
>
> Short this to GET_CONN_INFO and get_conn_info please. We never use the fu=
ll =E2=80=9Cinformation=E2=80=9D name.
>
>> +
>> #define MGMT_EV_CMD_COMPLETE          0x0001
>> struct mgmt_ev_cmd_complete {
>>       __le16  opcode;
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index bb3188f..58074c8 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -83,6 +83,7 @@ static const u16 mgmt_commands[] =3D {
>>       MGMT_OP_SET_DEBUG_KEYS,
>>       MGMT_OP_SET_PRIVACY,
>>       MGMT_OP_LOAD_IRKS,
>> +     MGMT_OP_GET_CONN_INFORMATION,
>
> Short this to GET_CONN_INFO.
>
>> };
>>
>> static const u16 mgmt_events[] =3D {
>> @@ -113,6 +114,8 @@ static const u16 mgmt_events[] =3D {
>>
>> #define CACHE_TIMEOUT msecs_to_jiffies(2 * 1000)
>>
>> +#define CONN_INFO_INTERVAL   msecs_to_jiffies(2 * 1000)
>> +
>
> With the inquiry cache we are calling this MAX_AGE. So we should follow t=
his here as well. INTERVAL is the wrong name here.
>
>> #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
>>                               !test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
>>
>> @@ -4574,6 +4577,178 @@ static int load_long_term_keys(struct sock *sk, =
struct hci_dev *hdev,
>>       return err;
>> }
>>
>> +struct cmd_conn_lookup {
>> +     struct hci_conn *conn;
>> +     u8 mgmt_status;
>> +};
>> +
>> +static void conn_info_complete(struct pending_cmd *cmd, void *data)
>> +{
>> +     struct cmd_conn_lookup *match =3D data;
>> +     struct mgmt_cp_get_conn_information *cp;
>> +     struct mgmt_rp_get_conn_information *rp;
>> +     char buf[sizeof(*rp) + 3];
>> +     struct hci_conn *conn =3D cmd->user_data;
>> +     __u16 eir_len =3D 0;
>> +
>> +     if (conn !=3D match->conn)
>> +             return;
>> +
>> +     cp =3D (struct mgmt_cp_get_conn_information *) cmd->param;
>> +     rp =3D (struct mgmt_rp_get_conn_information *) buf;
>> +
>> +     memset(buf, 0, sizeof(buf));
>> +     memcpy(&rp->addr, &cp->addr, sizeof(rp->addr));
>> +
>> +     if (match->mgmt_status) {
>> +             cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFORMA=
TION,
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
>> +     cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFORMATION,
>> +                     MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
>> +
>> +done:
>> +     hci_conn_drop(conn);
>> +
>> +     mgmt_pending_remove(cmd);
>> +}
>> +
>> +static void conn_info_query_complete(struct hci_dev *hdev, u8 status,
>> +                                  void *data)
>> +{
>> +     struct hci_conn *conn =3D data;
>> +     struct cmd_conn_lookup match =3D { conn, mgmt_status(status) };
>> +
>> +     BT_DBG("status 0x%02x", status);
>> +
>> +     if (!status)
>> +             conn->last_info_read =3D jiffies;
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     mgmt_pending_foreach(MGMT_OP_GET_CONN_INFORMATION, hdev,
>> +                          conn_info_complete, &match);
>> +
>> +     hci_dev_unlock(hdev);
>> +}
>
> This whole thing is a bit convoluted. Can we get this done simpler or add=
 some extra comments for people follow through on how this works.

I'll see if this can be made any simpler and add some extra comments at lea=
st.

> We do need a mgmt-tester test case for this of course.

Sure, I'll create one once we have final specification for this command.

>> +
>> +static bool check_pending_conn_info(struct hci_dev *hdev, struct hci_co=
nn *conn)
>> +{
>> +     struct pending_cmd *cmd;
>> +
>> +     list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
>> +             if (cmd->opcode =3D=3D MGMT_OP_GET_CONN_INFORMATION &&
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
>> +     struct mgmt_cp_get_conn_information *cp =3D data;
>> +     struct mgmt_rp_get_conn_information rp;
>> +     struct hci_conn *conn;
>> +     struct pending_cmd *cmd;
>> +     struct hci_request req;
>> +     bool is_pending;
>> +     int err =3D 0;
>> +
>> +     BT_DBG("%s", hdev->name);
>> +
>> +     memset(&rp, 0, sizeof(rp));
>> +     memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
>
> Other locations in the code are doing this:
>
>         memset(&rp, 0, sizeof(rp));
>         bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
>         rp.addr.type =3D cp->addr.type;
>
>> +
>> +     if (!bdaddr_type_is_valid(cp->addr.type))
>> +             return cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFORMA=
TION,
>> +                                 MGMT_STATUS_INVALID_PARAMS,
>> +                                 &rp, sizeof(rp));
>
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     if (!hdev_is_powered(hdev)) {
>> +             err =3D cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFORM=
ATION,
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
>> +     if (!conn || conn->state =3D=3D BT_OPEN || conn->state =3D=3D BT_C=
LOSED) {
>
> Lets check for !=3D BT_CONNECTED here.
>
>> +             err =3D cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFORM=
ATION,
>> +                                MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(=
rp));
>> +             goto unlock;
>> +     }
>> +
>> +     is_pending =3D check_pending_conn_info(hdev, conn);
>
> Don=E2=80=99t we have a mgmt_pending_find for this.

We have but there's similar problem as with hci_request in other patch
- we want pending command for given hci_conn. So this actually does
something like mgmt_pending_find_if (with cmp callback). Do you want
to have such generic function instead of dedicated helper?

BR,
Andrzej
