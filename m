Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f1d0214e-813c-b00f-198b-4a24c4a8adb1@felipetonello.com>
References: <20170203213604.2697-1-eu@felipetonello.com> <f1d0214e-813c-b00f-198b-4a24c4a8adb1@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Feb 2017 11:34:30 +0200
Message-ID: <CABBYNZ+3zaBWQa_V9ASdHq7OA5is4HJ=H9Y=ZBRgCom1xMa-Mw@mail.gmail.com>
Subject: Re: [RFC][PATCH BlueZ] Bluetooth: L2CAP: Add BT_LE_CONN_PARAM socket option
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	"Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Wed, Feb 8, 2017 at 1:04 AM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> CC'ed Marcel and Luiz for comments.
>
> I have implemented and tested the functionality in the shared/att.[ch]
> lib too, but I am waiting for your comments on the approach first.
>
> On 03/02/17 21:36, Felipe F. Tonello wrote:
>> There is a need for certain LE profiles (MIDI for example)to change the
>> current connection's parameters. In order to do that, this patch
>> introduces a new BT_LE_CONN_PARAM socket option for SOL_BLUETOOTH
>> protocol which allow user-space l2cap sockets to update the current
>> connection.
>>
>> This option will also send a MGMT_EV_NEW_CONN_PARAM event with the
>> store_hint set so the user-space application can store the connection
>> parameters for persistence reasons.
>>
>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>> ---
>>  include/net/bluetooth/bluetooth.h |  8 ++++
>>  net/bluetooth/l2cap_sock.c        | 98 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 106 insertions(+)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 01487192f628..ce5b3abd3b27 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -122,6 +122,14 @@ struct bt_voice {
>>  #define BT_SNDMTU            12
>>  #define BT_RCVMTU            13
>>
>> +#define BT_LE_CONN_PARAM     14
>> +struct bt_le_conn_param {
>> +     __u16 min_interval;
>> +     __u16 max_interval;
>> +     __u16 latency;
>> +     __u16 supervision_timeout;
>> +};
>> +
>>  __printf(1, 2)
>>  void bt_info(const char *fmt, ...);
>>  __printf(1, 2)
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index a8ba752732c9..9c492730b081 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -498,6 +498,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>>       struct l2cap_chan *chan = l2cap_pi(sk)->chan;
>>       struct bt_security sec;
>>       struct bt_power pwr;
>> +     struct bt_le_conn_param conn_param;
>>       int len, err = 0;
>>
>>       BT_DBG("sk %p", sk);
>> @@ -514,6 +515,47 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>>       lock_sock(sk);
>>
>>       switch (optname) {
>> +     case BT_LE_CONN_PARAM: {
>> +             struct hci_conn_params *params;
>> +             struct hci_conn *hcon;
>> +
>> +             if (!chan->conn) {
>> +                     err = -ENOTCONN;
>> +                     break;
>> +             }
>> +
>> +             hcon = chan->conn->hcon;
>> +             hci_dev_lock(hcon->hdev);
>> +
>> +             params = hci_conn_params_lookup(hcon->hdev,
>> +                     &hcon->dst, hcon->dst_type);
>> +
>> +             memset(&conn_param, 0, sizeof(conn_param));
>> +             if (params) {
>> +                     conn_param.min_interval = params->conn_min_interval;
>> +                     conn_param.max_interval = params->conn_max_interval;
>> +                     conn_param.latency = params->conn_latency;
>> +                     conn_param.supervision_timeout =
>> +                             params->supervision_timeout;
>> +             } else {
>> +                     conn_param.min_interval =
>> +                             chan->conn->hcon->hdev->le_conn_min_interval;
>> +                     conn_param.max_interval =
>> +                             chan->conn->hcon->hdev->le_conn_max_interval;
>> +                     conn_param.latency =
>> +                             chan->conn->hcon->hdev->le_conn_latency;
>> +                     conn_param.supervision_timeout =
>> +                             chan->conn->hcon->hdev->le_supv_timeout;
>> +             }
>> +
>> +             hci_dev_unlock(hcon->hdev);
>> +
>> +             len = min_t(unsigned int, len, sizeof(conn_param));
>> +             if (copy_to_user(optval, (char *) &conn_param, len))
>> +                     err = -EFAULT;
>> +
>> +             break;
>> +     }
>>       case BT_SECURITY:
>>               if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
>>                   chan->chan_type != L2CAP_CHAN_FIXED &&
>> @@ -746,6 +788,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>>       struct l2cap_chan *chan = l2cap_pi(sk)->chan;
>>       struct bt_security sec;
>>       struct bt_power pwr;
>> +     struct bt_le_conn_param conn_param;
>>       struct l2cap_conn *conn;
>>       int len, err = 0;
>>       u32 opt;
>> @@ -761,6 +804,61 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>>       lock_sock(sk);
>>
>>       switch (optname) {
>> +     case BT_LE_CONN_PARAM: {
>> +             struct hci_conn_params *hci_param;
>> +             struct hci_conn *hcon;
>> +
>> +             len = min_t(unsigned int, sizeof(conn_param), optlen);
>> +             if (copy_from_user((char *) &conn_param, optval, len)) {
>> +                     err = -EFAULT;
>> +                     break;
>> +             }
>> +
>> +             if (!chan->conn) {
>> +                     err = -ENOTCONN;
>> +                     break;
>> +             }
>> +
>> +             if (hci_check_conn_params(conn_param.min_interval,
>> +                     conn_param.max_interval, conn_param.latency,
>> +                     conn_param.supervision_timeout) < 0) {
>> +                     err = -EINVAL;
>> +                     BT_ERR("Ignoring invalid connection parameters");
>> +                     break;
>> +             }
>> +
>> +             hcon = chan->conn->hcon;
>> +
>> +             hci_dev_lock(hcon->hdev);
>> +
>> +             hci_conn_params_clear_disabled(hcon->hdev);
>> +
>> +             hci_param = hci_conn_params_add(hcon->hdev,
>> +                     &hcon->dst, hcon->dst_type);
>> +             if (!hci_param) {
>> +                     err = -ENOMEM;
>> +                     BT_ERR("Failed to add connection parameters");
>> +                     hci_dev_unlock(hcon->hdev);
>> +                     break;
>> +             }
>> +
>> +             hci_param->conn_min_interval = conn_param.min_interval;
>> +             hci_param->conn_max_interval = conn_param.max_interval;
>> +             hci_param->conn_latency = conn_param.latency;
>> +             hci_param->supervision_timeout = conn_param.supervision_timeout;
>> +
>> +             hci_dev_unlock(hcon->hdev);
>> +
>> +             hci_le_conn_update(hcon, conn_param.min_interval,
>> +                     conn_param.max_interval, conn_param.latency,
>> +                     conn_param.supervision_timeout);

Does hci_le_conn_update have any logic to mix different intervals,
from the looks of this it seems the last request would always win
instead what we probably want is to have the most aggressive
intervals, latency and timeout (or actually perhaps the most relaxed
timeout). Btw, in Zephyr we are doing something like this:

/*
* If remote does not support LL Connection Parameters Request
* Procedure
*/
if ((conn->role == BT_HCI_ROLE_SLAVE) &&
   !BT_FEAT_LE_CONN_PARAM_REQ_PROC(conn->le.features)) {
return bt_l2cap_update_conn_param(conn, param);

We should have something similar here.

>> +             mgmt_new_conn_param(hcon->hdev,
>> +                     &hcon->dst, hcon->dst_type,
>> +                     true, conn_param.min_interval, conn_param.max_interval,
>> +                     conn_param.latency, conn_param.supervision_timeout);

iirc the parameter can be rejected, also is this a blocking API? Im
afraid if we do end up having to update the parameters using L2CAP
procedure the MGMT command may only be sent once that finishes, in
that case it has to be asynchronous at least from the kernel point of
view.

>> +             break;
>> +     }
>> +
>>       case BT_SECURITY:
>>               if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
>>                   chan->chan_type != L2CAP_CHAN_FIXED &&
>>
>
> --
> Felipe



-- 
Luiz Augusto von Dentz
