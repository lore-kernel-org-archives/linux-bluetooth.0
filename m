Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110530221141.GI2556@joana>
References: <1306199164-28310-1-git-send-email-jaikumar@google.com> <20110530221141.GI2556@joana>
From: Jaikumar Ganesh <jaikumarg@gmail.com>
Date: Tue, 31 May 2011 18:53:51 -0700
Message-ID: <BANLkTi=VyYixDBp33mANPwjiOtCwitTM_A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add BT_POWER L2CAP socket option.
To: padovan@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=bcaec51dd161291b7d04a49cccb7
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--bcaec51dd161291b7d04a49cccb7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gustavo,

On Mon, May 30, 2011 at 3:11 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Jaikumar,
>
> * Jaikumar Ganesh <jaikumar@google.com> [2011-05-23 18:06:04 -0700]:
>
>> Add BT_POWER socket option used to control the power
>> characteristics of the underlying ACL link. When the remote end
>> has put the link in sniff mode and the host stack wants to send
>> data we need need to explicitly exit sniff mode to work well with
>> certain devices (For example, A2DP on Plantronics Voyager 855).
>> However, this causes problems with HID devices.
>>
>> Hence, moving into active mode when sending data, irrespective
>> of who set the sniff mode has been made as a socket option. By
>> default, we will move into active mode. HID devices can set the
>> L2CAP socket option to prevent this from happening.
>>
>> Currently, this has been implemented for L2CAP sockets. This has been
>> tested with incoming and outgoing L2CAP sockets for HID and A2DP.
>>
>> Based on discussions on linux-bluetooth and patches submitted by
>> Andrei Emeltchenko.
>>
>> Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
>> ---
>> =A0include/net/bluetooth/bluetooth.h | =A0 =A08 ++++++++
>> =A0include/net/bluetooth/hci_core.h =A0| =A0 =A02 +-
>> =A0include/net/bluetooth/l2cap.h =A0 =A0 | =A0 =A01 +
>> =A0net/bluetooth/hci_conn.c =A0 =A0 =A0 =A0 =A0| =A0 =A09 ++++++---
>> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
>> =A0net/bluetooth/l2cap_core.c =A0 =A0 =A0 =A0| =A0 =A05 +++++
>> =A0net/bluetooth/l2cap_sock.c =A0 =A0 =A0 =A0| =A0 36 ++++++++++++++++++=
++++++++++++++++++
>> =A07 files changed, 59 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/b=
luetooth.h
>> index 4375043..af930a3 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -69,6 +69,13 @@ struct bt_security {
>> =A0#define BT_FLUSHABLE_OFF =A0 =A0 0
>> =A0#define BT_FLUSHABLE_ON =A0 =A0 =A0 =A0 =A0 =A0 =A01
>>
>> +#define BT_POWER =A0 =A0 9
>> +struct bt_power {
>> + =A0 =A0 __u8 force_active;
>> +};
>> +#define BT_POWER_FORCE_ACTIVE_OFF 0
>> +#define BT_POWER_FORCE_ACTIVE_ON =A01
>> +
>> =A0#define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" =
, ## arg)
>> =A0#define BT_ERR(fmt, arg...) =A0printk(KERN_ERR "%s: " fmt "\n" , __fu=
nc__ , ## arg)
>> =A0#define BT_DBG(fmt, arg...) =A0pr_debug("%s: " fmt "\n" , __func__ , =
## arg)
>> @@ -150,6 +157,7 @@ struct bt_skb_cb {
>> =A0 =A0 =A0 __u8 retries;
>> =A0 =A0 =A0 __u8 sar;
>> =A0 =A0 =A0 unsigned short channel;
>> + =A0 =A0 __u8 force_active;
>> =A0};
>> =A0#define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index 6c994c0..0747841 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -427,7 +427,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 se=
c_level, __u8 auth_type);
>> =A0int hci_conn_change_link_key(struct hci_conn *conn);
>> =A0int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
>>
>> -void hci_conn_enter_active_mode(struct hci_conn *conn);
>> +void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_activ=
e);
>> =A0void hci_conn_enter_sniff_mode(struct hci_conn *conn);
>>
>> =A0void hci_conn_hold_device(struct hci_conn *conn);
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap=
.h
>> index d09c9b1..942970d 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -302,6 +302,7 @@ struct l2cap_chan {
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0role_switch;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0force_reliable;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0flushable;
>> + =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0force_active;
>>
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0ident;
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 3163330..5195715 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -497,7 +497,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, i=
nt type, bdaddr_t *dst, __u8
>> =A0 =A0 =A0 if (acl->state =3D=3D BT_CONNECTED &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sco->state =3D=3D BT_OPEN |=
| sco->state =3D=3D BT_CLOSED)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 acl->power_save =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(acl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(acl, BT_POWER_FORCE=
_ACTIVE_ON);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl=
->pend)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* defer SCO setup until mod=
e change completed */
>> @@ -676,7 +676,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8=
 role)
>> =A0EXPORT_SYMBOL(hci_conn_switch_role);
>>
>> =A0/* Enter active mode */
>> -void hci_conn_enter_active_mode(struct hci_conn *conn)
>> +void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_activ=
e)
>> =A0{
>> =A0 =A0 =A0 struct hci_dev *hdev =3D conn->hdev;
>>
>> @@ -685,7 +685,10 @@ void hci_conn_enter_active_mode(struct hci_conn *co=
nn)
>> =A0 =A0 =A0 if (test_bit(HCI_RAW, &hdev->flags))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 if (conn->mode !=3D HCI_CM_SNIFF || !conn->power_save)
>> + =A0 =A0 if (conn->mode !=3D HCI_CM_SNIFF)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto timer;
>> +
>> + =A0 =A0 if (!conn->power_save && !force_active)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto timer;
>>
>> =A0 =A0 =A0 if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend=
)) {
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index b6bda3f..be68e7d 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1893,7 +1893,7 @@ static inline void hci_sched_acl(struct hci_dev *h=
dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (quote-- && (skb =3D skb_dequeue(&conn=
->data_q))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_DBG("skb %p len %d", skb,=
 skb->len);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(con=
n);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(con=
n, bt_cb(skb)->force_active);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_send_frame(skb);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->acl_last_tx =3D jiffie=
s;
>> @@ -2032,7 +2032,7 @@ static inline void hci_acldata_packet(struct hci_d=
ev *hdev, struct sk_buff *skb)
>> =A0 =A0 =A0 if (conn) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 register struct hci_proto *hp;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(conn);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(conn, bt_cb(skb)->f=
orce_active);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Send to upper protocol */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hp =3D hci_proto[HCI_PROTO_L2CAP];
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 7c0e571..2a80a91 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -408,6 +408,8 @@ void l2cap_send_cmd(struct l2cap_conn *conn, u8 iden=
t, u8 code, u16 len, void *d
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D ACL_START;
>>
>> + =A0 =A0 bt_cb(skb)->force_active =3D BT_POWER_FORCE_ACTIVE_ON;
>> +
>> =A0 =A0 =A0 hci_send_acl(conn->hcon, skb, flags);
>> =A0}
>>
>> @@ -461,6 +463,8 @@ static inline void l2cap_send_sframe(struct l2cap_ch=
an *chan, u16 control)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D ACL_START;
>>
>> + =A0 =A0 bt_cb(skb)->force_active =3D chan->force_active;
>> +
>> =A0 =A0 =A0 hci_send_acl(chan->conn->hcon, skb, flags);
>> =A0}
>>
>> @@ -1089,6 +1093,7 @@ void l2cap_do_send(struct l2cap_chan *chan, struct=
 sk_buff *skb)
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D ACL_START;
>>
>> + =A0 =A0 bt_cb(skb)->force_active =3D chan->force_active;
>> =A0 =A0 =A0 hci_send_acl(hcon, skb, flags);
>> =A0}
>>
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index c98360d..9f99e1d 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -436,6 +436,7 @@ static int l2cap_sock_getsockopt(struct socket *sock=
, int level, int optname, ch
>> =A0 =A0 =A0 struct sock *sk =3D sock->sk;
>> =A0 =A0 =A0 struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
>> =A0 =A0 =A0 struct bt_security sec;
>> + =A0 =A0 struct bt_power pwr;
>> =A0 =A0 =A0 int len, err =3D 0;
>>
>> =A0 =A0 =A0 BT_DBG("sk %p", sk);
>> @@ -484,6 +485,21 @@ static int l2cap_sock_getsockopt(struct socket *soc=
k, int level, int optname, ch
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> + =A0 =A0 case BT_POWER:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sk->sk_type !=3D SOCK_SEQPACKET && sk->sk_=
type !=3D SOCK_STREAM
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && sk->sk_type=
 !=3D SOCK_RAW) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwr.force_active =3D chan->force_active;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D min_t(unsigned int, len, sizeof(pwr));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (copy_to_user(optval, (char *) &pwr, len))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EFAULT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOPROTOOPT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> @@ -584,6 +600,7 @@ static int l2cap_sock_setsockopt(struct socket *sock=
, int level, int optname, ch
>> =A0 =A0 =A0 struct sock *sk =3D sock->sk;
>> =A0 =A0 =A0 struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
>> =A0 =A0 =A0 struct bt_security sec;
>> + =A0 =A0 struct bt_power pwr;
>> =A0 =A0 =A0 int len, err =3D 0;
>> =A0 =A0 =A0 u32 opt;
>>
>> @@ -660,6 +677,23 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname, ch
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 chan->flushable =3D opt;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> + =A0 =A0 case BT_POWER:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sk->sk_type !=3D SOCK_SEQPACKET && sk->sk_=
type !=3D SOCK_STREAM
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && sk->sk_type=
 !=3D SOCK_RAW) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>
> This need to be rebased against bluetooth-next. Not sure, but this seems =
to be
> the only place of conflict.

Rebased patch attached.

Thanks

>
> --
> Gustavo F. Padovan
> http://profusion.mobi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

--bcaec51dd161291b7d04a49cccb7
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Add-BT_POWER-L2CAP-socket-option.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Add-BT_POWER-L2CAP-socket-option.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_godmgneu0

RnJvbSA3NGU5YTc1ZWY0OGI2MzNhYTgyZTI4ZWM3NzViYjA0YjYzMGQ1MWFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWlrdW1hciBHYW5lc2ggPGphaWt1bWFyQGdvb2dsZS5jb20+
CkRhdGU6IE1vbiwgMjMgTWF5IDIwMTEgMTg6MDY6MDQgLTA3MDAKU3ViamVjdDogW1BBVENIXSBC
bHVldG9vdGg6IEFkZCBCVF9QT1dFUiBMMkNBUCBzb2NrZXQgb3B0aW9uLgoKQWRkIEJUX1BPV0VS
IHNvY2tldCBvcHRpb24gdXNlZCB0byBjb250cm9sIHRoZSBwb3dlcgpjaGFyYWN0ZXJpc3RpY3Mg
b2YgdGhlIHVuZGVybHlpbmcgQUNMIGxpbmsuIFdoZW4gdGhlIHJlbW90ZSBlbmQKaGFzIHB1dCB0
aGUgbGluayBpbiBzbmlmZiBtb2RlIGFuZCB0aGUgaG9zdCBzdGFjayB3YW50cyB0byBzZW5kCmRh
dGEgd2UgbmVlZCBuZWVkIHRvIGV4cGxpY2l0bHkgZXhpdCBzbmlmZiBtb2RlIHRvIHdvcmsgd2Vs
bCB3aXRoCmNlcnRhaW4gZGV2aWNlcyAoRm9yIGV4YW1wbGUsIEEyRFAgb24gUGxhbnRyb25pY3Mg
Vm95YWdlciA4NTUpLgpIb3dldmVyLCB0aGlzIGNhdXNlcyBwcm9ibGVtcyB3aXRoIEhJRCBkZXZp
Y2VzLgoKSGVuY2UsIG1vdmluZyBpbnRvIGFjdGl2ZSBtb2RlIHdoZW4gc2VuZGluZyBkYXRhLCBp
cnJlc3BlY3RpdmUKb2Ygd2hvIHNldCB0aGUgc25pZmYgbW9kZSBoYXMgYmVlbiBtYWRlIGFzIGEg
c29ja2V0IG9wdGlvbi4gQnkKZGVmYXVsdCwgd2Ugd2lsbCBtb3ZlIGludG8gYWN0aXZlIG1vZGUu
IEhJRCBkZXZpY2VzIGNhbiBzZXQgdGhlCkwyQ0FQIHNvY2tldCBvcHRpb24gdG8gcHJldmVudCB0
aGlzIGZyb20gaGFwcGVuaW5nLgoKQ3VycmVudGx5LCB0aGlzIGhhcyBiZWVuIGltcGxlbWVudGVk
IGZvciBMMkNBUCBzb2NrZXRzLiBUaGlzIGhhcyBiZWVuCnRlc3RlZCB3aXRoIGluY29taW5nIGFu
ZCBvdXRnb2luZyBMMkNBUCBzb2NrZXRzIGZvciBISUQgYW5kIEEyRFAuCgpCYXNlZCBvbiBkaXNj
dXNzaW9ucyBvbiBsaW51eC1ibHVldG9vdGggYW5kIHBhdGNoZXMgc3VibWl0dGVkIGJ5CkFuZHJl
aSBFbWVsdGNoZW5rby4KClNpZ25lZC1vZmYtYnk6IEphaWt1bWFyIEdhbmVzaCA8amFpa3VtYXJA
Z29vZ2xlLmNvbT4KLS0tCiBpbmNsdWRlL25ldC9ibHVldG9vdGgvYmx1ZXRvb3RoLmggfCAgICA4
ICsrKysrKysrCiBpbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCAgfCAgICAyICstCiBp
bmNsdWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaCAgICAgfCAgICAxICsKIG5ldC9ibHVldG9vdGgv
aGNpX2Nvbm4uYyAgICAgICAgICB8ICAgIDkgKysrKysrLS0tCiBuZXQvYmx1ZXRvb3RoL2hjaV9j
b3JlLmMgICAgICAgICAgfCAgICA0ICsrLS0KIG5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jICAg
ICAgICB8ICAgIDUgKysrKysKIG5ldC9ibHVldG9vdGgvbDJjYXBfc29jay5jICAgICAgICB8ICAg
MzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiA3IGZpbGVzIGNoYW5nZWQs
IDU5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9u
ZXQvYmx1ZXRvb3RoL2JsdWV0b290aC5oIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2JsdWV0b290
aC5oCmluZGV4IDQzNzUwNDMuLmFmOTMwYTMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbmV0L2JsdWV0
b290aC9ibHVldG9vdGguaAorKysgYi9pbmNsdWRlL25ldC9ibHVldG9vdGgvYmx1ZXRvb3RoLmgK
QEAgLTY5LDYgKzY5LDEzIEBAIHN0cnVjdCBidF9zZWN1cml0eSB7CiAjZGVmaW5lIEJUX0ZMVVNI
QUJMRV9PRkYJMAogI2RlZmluZSBCVF9GTFVTSEFCTEVfT04JCTEKIAorI2RlZmluZSBCVF9QT1dF
Ugk5CitzdHJ1Y3QgYnRfcG93ZXIgeworCV9fdTggZm9yY2VfYWN0aXZlOworfTsKKyNkZWZpbmUg
QlRfUE9XRVJfRk9SQ0VfQUNUSVZFX09GRiAwCisjZGVmaW5lIEJUX1BPV0VSX0ZPUkNFX0FDVElW
RV9PTiAgMQorCiAjZGVmaW5lIEJUX0lORk8oZm10LCBhcmcuLi4pIHByaW50ayhLRVJOX0lORk8g
IkJsdWV0b290aDogIiBmbXQgIlxuIiAsICMjIGFyZykKICNkZWZpbmUgQlRfRVJSKGZtdCwgYXJn
Li4uKSAgcHJpbnRrKEtFUk5fRVJSICIlczogIiBmbXQgIlxuIiAsIF9fZnVuY19fICwgIyMgYXJn
KQogI2RlZmluZSBCVF9EQkcoZm10LCBhcmcuLi4pICBwcl9kZWJ1ZygiJXM6ICIgZm10ICJcbiIg
LCBfX2Z1bmNfXyAsICMjIGFyZykKQEAgLTE1MCw2ICsxNTcsNyBAQCBzdHJ1Y3QgYnRfc2tiX2Ni
IHsKIAlfX3U4IHJldHJpZXM7CiAJX191OCBzYXI7CiAJdW5zaWduZWQgc2hvcnQgY2hhbm5lbDsK
KwlfX3U4IGZvcmNlX2FjdGl2ZTsKIH07CiAjZGVmaW5lIGJ0X2NiKHNrYikgKChzdHJ1Y3QgYnRf
c2tiX2NiICopKChza2IpLT5jYikpCiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2JsdWV0b290
aC9oY2lfY29yZS5oIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgKaW5kZXggYWY0
YjBlZC4uOTZhZmE0ZCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3Jl
LmgKKysrIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgKQEAgLTQzNiw3ICs0MzYs
NyBAQCBpbnQgaGNpX2Nvbm5fc2VjdXJpdHkoc3RydWN0IGhjaV9jb25uICpjb25uLCBfX3U4IHNl
Y19sZXZlbCwgX191OCBhdXRoX3R5cGUpOwogaW50IGhjaV9jb25uX2NoYW5nZV9saW5rX2tleShz
dHJ1Y3QgaGNpX2Nvbm4gKmNvbm4pOwogaW50IGhjaV9jb25uX3N3aXRjaF9yb2xlKHN0cnVjdCBo
Y2lfY29ubiAqY29ubiwgX191OCByb2xlKTsKIAotdm9pZCBoY2lfY29ubl9lbnRlcl9hY3RpdmVf
bW9kZShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4pOwordm9pZCBoY2lfY29ubl9lbnRlcl9hY3RpdmVf
bW9kZShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTggZm9yY2VfYWN0aXZlKTsKIHZvaWQgaGNp
X2Nvbm5fZW50ZXJfc25pZmZfbW9kZShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4pOwogCiB2b2lkIGhj
aV9jb25uX2hvbGRfZGV2aWNlKHN0cnVjdCBoY2lfY29ubiAqY29ubik7CmRpZmYgLS1naXQgYS9p
bmNsdWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaCBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNh
cC5oCmluZGV4IGEyZGNiZmYuLjA1MjlkMjcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbmV0L2JsdWV0
b290aC9sMmNhcC5oCisrKyBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5oCkBAIC0zMDMs
NiArMzAzLDcgQEAgc3RydWN0IGwyY2FwX2NoYW4gewogCV9fdTgJCXJvbGVfc3dpdGNoOwogCV9f
dTgJCWZvcmNlX3JlbGlhYmxlOwogCV9fdTgJCWZsdXNoYWJsZTsKKwlfX3U4CQlmb3JjZV9hY3Rp
dmU7CiAKIAlfX3U4CQlpZGVudDsKIApkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfY29u
bi5jIGIvbmV0L2JsdWV0b290aC9oY2lfY29ubi5jCmluZGV4IDMxNjMzMzAuLjUxOTU3MTUgMTAw
NjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX2Nvbm4uYworKysgYi9uZXQvYmx1ZXRvb3RoL2hj
aV9jb25uLmMKQEAgLTQ5Nyw3ICs0OTcsNyBAQCBzdHJ1Y3QgaGNpX2Nvbm4gKmhjaV9jb25uZWN0
KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBpbnQgdHlwZSwgYmRhZGRyX3QgKmRzdCwgX191OAogCWlm
IChhY2wtPnN0YXRlID09IEJUX0NPTk5FQ1RFRCAmJgogCQkJKHNjby0+c3RhdGUgPT0gQlRfT1BF
TiB8fCBzY28tPnN0YXRlID09IEJUX0NMT1NFRCkpIHsKIAkJYWNsLT5wb3dlcl9zYXZlID0gMTsK
LQkJaGNpX2Nvbm5fZW50ZXJfYWN0aXZlX21vZGUoYWNsKTsKKwkJaGNpX2Nvbm5fZW50ZXJfYWN0
aXZlX21vZGUoYWNsLCBCVF9QT1dFUl9GT1JDRV9BQ1RJVkVfT04pOwogCiAJCWlmICh0ZXN0X2Jp
dChIQ0lfQ09OTl9NT0RFX0NIQU5HRV9QRU5ELCAmYWNsLT5wZW5kKSkgewogCQkJLyogZGVmZXIg
U0NPIHNldHVwIHVudGlsIG1vZGUgY2hhbmdlIGNvbXBsZXRlZCAqLwpAQCAtNjc2LDcgKzY3Niw3
IEBAIGludCBoY2lfY29ubl9zd2l0Y2hfcm9sZShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTgg
cm9sZSkKIEVYUE9SVF9TWU1CT0woaGNpX2Nvbm5fc3dpdGNoX3JvbGUpOwogCiAvKiBFbnRlciBh
Y3RpdmUgbW9kZSAqLwotdm9pZCBoY2lfY29ubl9lbnRlcl9hY3RpdmVfbW9kZShzdHJ1Y3QgaGNp
X2Nvbm4gKmNvbm4pCit2b2lkIGhjaV9jb25uX2VudGVyX2FjdGl2ZV9tb2RlKHN0cnVjdCBoY2lf
Y29ubiAqY29ubiwgX191OCBmb3JjZV9hY3RpdmUpCiB7CiAJc3RydWN0IGhjaV9kZXYgKmhkZXYg
PSBjb25uLT5oZGV2OwogCkBAIC02ODUsNyArNjg1LDEwIEBAIHZvaWQgaGNpX2Nvbm5fZW50ZXJf
YWN0aXZlX21vZGUoc3RydWN0IGhjaV9jb25uICpjb25uKQogCWlmICh0ZXN0X2JpdChIQ0lfUkFX
LCAmaGRldi0+ZmxhZ3MpKQogCQlyZXR1cm47CiAKLQlpZiAoY29ubi0+bW9kZSAhPSBIQ0lfQ01f
U05JRkYgfHwgIWNvbm4tPnBvd2VyX3NhdmUpCisJaWYgKGNvbm4tPm1vZGUgIT0gSENJX0NNX1NO
SUZGKQorCQlnb3RvIHRpbWVyOworCisJaWYgKCFjb25uLT5wb3dlcl9zYXZlICYmICFmb3JjZV9h
Y3RpdmUpCiAJCWdvdG8gdGltZXI7CiAKIAlpZiAoIXRlc3RfYW5kX3NldF9iaXQoSENJX0NPTk5f
TU9ERV9DSEFOR0VfUEVORCwgJmNvbm4tPnBlbmQpKSB7CmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRv
b3RoL2hjaV9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmMKaW5kZXggZmY2Yjc4NC4u
ZTE0ZThhMSAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfY29yZS5jCisrKyBiL25ldC9i
bHVldG9vdGgvaGNpX2NvcmUuYwpAQCAtMTk2OSw3ICsxOTY5LDcgQEAgc3RhdGljIGlubGluZSB2
b2lkIGhjaV9zY2hlZF9hY2woc3RydWN0IGhjaV9kZXYgKmhkZXYpCiAJCXdoaWxlIChxdW90ZS0t
ICYmIChza2IgPSBza2JfZGVxdWV1ZSgmY29ubi0+ZGF0YV9xKSkpIHsKIAkJCUJUX0RCRygic2ti
ICVwIGxlbiAlZCIsIHNrYiwgc2tiLT5sZW4pOwogCi0JCQloY2lfY29ubl9lbnRlcl9hY3RpdmVf
bW9kZShjb25uKTsKKwkJCWhjaV9jb25uX2VudGVyX2FjdGl2ZV9tb2RlKGNvbm4sIGJ0X2NiKHNr
YiktPmZvcmNlX2FjdGl2ZSk7CiAKIAkJCWhjaV9zZW5kX2ZyYW1lKHNrYik7CiAJCQloZGV2LT5h
Y2xfbGFzdF90eCA9IGppZmZpZXM7CkBAIC0yMTA4LDcgKzIxMDgsNyBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgaGNpX2FjbGRhdGFfcGFja2V0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiKQogCWlmIChjb25uKSB7CiAJCXJlZ2lzdGVyIHN0cnVjdCBoY2lfcHJvdG8gKmhw
OwogCi0JCWhjaV9jb25uX2VudGVyX2FjdGl2ZV9tb2RlKGNvbm4pOworCQloY2lfY29ubl9lbnRl
cl9hY3RpdmVfbW9kZShjb25uLCBidF9jYihza2IpLT5mb3JjZV9hY3RpdmUpOwogCiAJCS8qIFNl
bmQgdG8gdXBwZXIgcHJvdG9jb2wgKi8KIAkJaHAgPSBoY2lfcHJvdG9bSENJX1BST1RPX0wyQ0FQ
XTsKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jIGIvbmV0L2JsdWV0b290
aC9sMmNhcF9jb3JlLmMKaW5kZXggZTczMGJiNC4uZjQ1OGZjMSAxMDA2NDQKLS0tIGEvbmV0L2Js
dWV0b290aC9sMmNhcF9jb3JlLmMKKysrIGIvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMKQEAg
LTUzNyw2ICs1MzcsOCBAQCBzdGF0aWMgdm9pZCBsMmNhcF9zZW5kX2NtZChzdHJ1Y3QgbDJjYXBf
Y29ubiAqY29ubiwgdTggaWRlbnQsIHU4IGNvZGUsIHUxNiBsZW4sCiAJZWxzZQogCQlmbGFncyA9
IEFDTF9TVEFSVDsKIAorCWJ0X2NiKHNrYiktPmZvcmNlX2FjdGl2ZSA9IEJUX1BPV0VSX0ZPUkNF
X0FDVElWRV9PTjsKKwogCWhjaV9zZW5kX2FjbChjb25uLT5oY29uLCBza2IsIGZsYWdzKTsKIH0K
IApAQCAtNTkwLDYgKzU5Miw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMmNhcF9zZW5kX3NmcmFt
ZShzdHJ1Y3QgbDJjYXBfY2hhbiAqY2hhbiwgdTE2IGNvbnRyb2wpCiAJZWxzZQogCQlmbGFncyA9
IEFDTF9TVEFSVDsKIAorCWJ0X2NiKHNrYiktPmZvcmNlX2FjdGl2ZSA9IGNoYW4tPmZvcmNlX2Fj
dGl2ZTsKKwogCWhjaV9zZW5kX2FjbChjaGFuLT5jb25uLT5oY29uLCBza2IsIGZsYWdzKTsKIH0K
IApAQCAtMTIxNSw2ICsxMjE5LDcgQEAgdm9pZCBsMmNhcF9kb19zZW5kKHN0cnVjdCBsMmNhcF9j
aGFuICpjaGFuLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogCWVsc2UKIAkJZmxhZ3MgPSBBQ0xfU1RB
UlQ7CiAKKwlidF9jYihza2IpLT5mb3JjZV9hY3RpdmUgPSBjaGFuLT5mb3JjZV9hY3RpdmU7CiAJ
aGNpX3NlbmRfYWNsKGhjb24sIHNrYiwgZmxhZ3MpOwogfQogCmRpZmYgLS1naXQgYS9uZXQvYmx1
ZXRvb3RoL2wyY2FwX3NvY2suYyBiL25ldC9ibHVldG9vdGgvbDJjYXBfc29jay5jCmluZGV4IDEz
ZDEwNzYuLjY3MWYxYzQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvbDJjYXBfc29jay5jCisr
KyBiL25ldC9ibHVldG9vdGgvbDJjYXBfc29jay5jCkBAIC0zOTEsNiArMzkxLDcgQEAgc3RhdGlj
IGludCBsMmNhcF9zb2NrX2dldHNvY2tvcHQoc3RydWN0IHNvY2tldCAqc29jaywgaW50IGxldmVs
LCBpbnQgb3B0bmFtZSwgY2gKIAlzdHJ1Y3Qgc29jayAqc2sgPSBzb2NrLT5zazsKIAlzdHJ1Y3Qg
bDJjYXBfY2hhbiAqY2hhbiA9IGwyY2FwX3BpKHNrKS0+Y2hhbjsKIAlzdHJ1Y3QgYnRfc2VjdXJp
dHkgc2VjOworCXN0cnVjdCBidF9wb3dlciBwd3I7CiAJaW50IGxlbiwgZXJyID0gMDsKIAogCUJU
X0RCRygic2sgJXAiLCBzayk7CkBAIC00MzksNiArNDQwLDIxIEBAIHN0YXRpYyBpbnQgbDJjYXBf
c29ja19nZXRzb2Nrb3B0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIGludCBsZXZlbCwgaW50IG9wdG5h
bWUsIGNoCiAKIAkJYnJlYWs7CiAKKwljYXNlIEJUX1BPV0VSOgorCQlpZiAoc2stPnNrX3R5cGUg
IT0gU09DS19TRVFQQUNLRVQgJiYgc2stPnNrX3R5cGUgIT0gU09DS19TVFJFQU0KKwkJCQkmJiBz
ay0+c2tfdHlwZSAhPSBTT0NLX1JBVykgeworCQkJZXJyID0gLUVJTlZBTDsKKwkJCWJyZWFrOwor
CQl9CisKKwkJcHdyLmZvcmNlX2FjdGl2ZSA9IGNoYW4tPmZvcmNlX2FjdGl2ZTsKKworCQlsZW4g
PSBtaW5fdCh1bnNpZ25lZCBpbnQsIGxlbiwgc2l6ZW9mKHB3cikpOworCQlpZiAoY29weV90b191
c2VyKG9wdHZhbCwgKGNoYXIgKikgJnB3ciwgbGVuKSkKKwkJCWVyciA9IC1FRkFVTFQ7CisKKwkJ
YnJlYWs7CisKIAlkZWZhdWx0OgogCQllcnIgPSAtRU5PUFJPVE9PUFQ7CiAJCWJyZWFrOwpAQCAt
NTM5LDYgKzU1NSw3IEBAIHN0YXRpYyBpbnQgbDJjYXBfc29ja19zZXRzb2Nrb3B0KHN0cnVjdCBz
b2NrZXQgKnNvY2ssIGludCBsZXZlbCwgaW50IG9wdG5hbWUsIGNoCiAJc3RydWN0IHNvY2sgKnNr
ID0gc29jay0+c2s7CiAJc3RydWN0IGwyY2FwX2NoYW4gKmNoYW4gPSBsMmNhcF9waShzayktPmNo
YW47CiAJc3RydWN0IGJ0X3NlY3VyaXR5IHNlYzsKKwlzdHJ1Y3QgYnRfcG93ZXIgcHdyOwogCWlu
dCBsZW4sIGVyciA9IDA7CiAJdTMyIG9wdDsKIApAQCAtNjE1LDYgKzYzMiwyMyBAQCBzdGF0aWMg
aW50IGwyY2FwX3NvY2tfc2V0c29ja29wdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBpbnQgbGV2ZWws
IGludCBvcHRuYW1lLCBjaAogCQljaGFuLT5mbHVzaGFibGUgPSBvcHQ7CiAJCWJyZWFrOwogCisJ
Y2FzZSBCVF9QT1dFUjoKKwkJaWYgKHNrLT5za190eXBlICE9IFNPQ0tfU0VRUEFDS0VUICYmIHNr
LT5za190eXBlICE9IFNPQ0tfU1RSRUFNCisJCQkJJiYgc2stPnNrX3R5cGUgIT0gU09DS19SQVcp
IHsKKwkJCWVyciA9IC1FSU5WQUw7CisJCQlicmVhazsKKwkJfQorCisJCXB3ci5mb3JjZV9hY3Rp
dmUgPSBCVF9QT1dFUl9GT1JDRV9BQ1RJVkVfT047CisKKwkJbGVuID0gbWluX3QodW5zaWduZWQg
aW50LCBzaXplb2YocHdyKSwgb3B0bGVuKTsKKwkJaWYgKGNvcHlfZnJvbV91c2VyKChjaGFyICop
ICZwd3IsIG9wdHZhbCwgbGVuKSkgeworCQkJZXJyID0gLUVGQVVMVDsKKwkJCWJyZWFrOworCQl9
CisJCWNoYW4tPmZvcmNlX2FjdGl2ZSA9IHB3ci5mb3JjZV9hY3RpdmU7CisJCWJyZWFrOworCiAJ
ZGVmYXVsdDoKIAkJZXJyID0gLUVOT1BST1RPT1BUOwogCQlicmVhazsKQEAgLTc3Miw2ICs4MDYs
NyBAQCB2b2lkIGwyY2FwX3NvY2tfaW5pdChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBzb2NrICpw
YXJlbnQpCiAJCWNoYW4tPnJvbGVfc3dpdGNoID0gcGNoYW4tPnJvbGVfc3dpdGNoOwogCQljaGFu
LT5mb3JjZV9yZWxpYWJsZSA9IHBjaGFuLT5mb3JjZV9yZWxpYWJsZTsKIAkJY2hhbi0+Zmx1c2hh
YmxlID0gcGNoYW4tPmZsdXNoYWJsZTsKKwkJY2hhbi0+Zm9yY2VfYWN0aXZlID0gcGNoYW4tPmZv
cmNlX2FjdGl2ZTsKIAl9IGVsc2UgewogCiAJCXN3aXRjaCAoc2stPnNrX3R5cGUpIHsKQEAgLTgw
Miw2ICs4MzcsNyBAQCB2b2lkIGwyY2FwX3NvY2tfaW5pdChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVj
dCBzb2NrICpwYXJlbnQpCiAJCWNoYW4tPnJvbGVfc3dpdGNoID0gMDsKIAkJY2hhbi0+Zm9yY2Vf
cmVsaWFibGUgPSAwOwogCQljaGFuLT5mbHVzaGFibGUgPSBCVF9GTFVTSEFCTEVfT0ZGOworCQlj
aGFuLT5mb3JjZV9hY3RpdmUgPSBCVF9QT1dFUl9GT1JDRV9BQ1RJVkVfT047CiAJfQogCiAJLyog
RGVmYXVsdCBjb25maWcgb3B0aW9ucyAqLwotLSAKMS43LjMuMQoK
--bcaec51dd161291b7d04a49cccb7--
