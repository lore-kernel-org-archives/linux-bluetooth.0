Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1281612715.12579.257.camel@localhost.localdomain>
References: <1281448112-2944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1281612715.12579.257.camel@localhost.localdomain>
Date: Thu, 12 Aug 2010 15:25:18 +0300
Message-ID: <AANLkTinp-wXzgUU3dSNteSGdBmgtcB8S+sWZZ-9b0BnD@mail.gmail.com>
Subject: Re: [PATCHv2] Bluetooth: new sockopt to enter active state when
 sending data
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 12, 2010 at 2:31 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andrei,
>
>> Patch adds new socket option to enter active state when sending
>> data. Modified version of Fabien Chevalier patch (Sep/2008).
>> Discussions:
>> http://www.spinics.net/lists/bluez-devel/msg00567.html
>> http://www.spinics.net/lists/linux-bluetooth/msg03765.html
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>> =A0include/net/bluetooth/hci_core.h | =A0 =A01 +
>> =A0include/net/bluetooth/l2cap.h =A0 =A0| =A0 =A02 ++
>> =A0net/bluetooth/hci_conn.c =A0 =A0 =A0 =A0 | =A0 =A07 ++++++-
>> =A0net/bluetooth/l2cap.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 15 +++++++++++++++
>> =A04 files changed, 24 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index e42f6ed..477a492 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -178,6 +178,7 @@ struct hci_conn {
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 auth_type;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 sec_level;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 power_save;
>> + =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 force_active;
>> =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 =A0disc_timeout;
>> =A0 =A0 =A0 unsigned long =A0 =A0pend;
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap=
.h
>> index 7c695bf..540cca7 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -74,6 +74,8 @@ struct l2cap_conninfo {
>> =A0#define L2CAP_LM_RELIABLE =A0 =A00x0010
>> =A0#define L2CAP_LM_SECURE =A0 =A0 =A0 =A0 =A0 =A0 =A00x0020
>>
>> +#define L2CAP_FORCE_ACTIVE_MODE =A0 =A0 =A00x04
>> +
>> =A0/* L2CAP command codes */
>> =A0#define L2CAP_COMMAND_REJ =A0 =A00x01
>> =A0#define L2CAP_CONN_REQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 800b6b9..11fc44a 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -214,6 +214,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, =
int type, bdaddr_t *dst)
>> =A0 =A0 =A0 conn->auth_type =3D HCI_AT_GENERAL_BONDING;
>>
>> =A0 =A0 =A0 conn->power_save =3D 1;
>> + =A0 =A0 /* Do not enter active state by default */
>> + =A0 =A0 conn->force_active =3D 0;
>> =A0 =A0 =A0 conn->disc_timeout =3D HCI_DISCONN_TIMEOUT;
>>
>> =A0 =A0 =A0 switch (type) {
>> @@ -505,7 +507,10 @@ void hci_conn_enter_active_mode(struct hci_conn *co=
nn)
>> =A0 =A0 =A0 if (test_bit(HCI_RAW, &hdev->flags))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 if (conn->mode !=3D HCI_CM_SNIFF || !conn->power_save)
>> + =A0 =A0 if (conn->mode !=3D HCI_CM_SNIFF)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto timer;
>> +
>> + =A0 =A0 if (!conn->power_save && !conn->force_active)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto timer;
>>
>> =A0 =A0 =A0 if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend=
)) {
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index cf3c407..5328e82 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -1909,6 +1909,15 @@ static int l2cap_sock_setsockopt_old(struct socke=
t *sock, int optname, char __us
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->force_reliable =3D (opt & L2CA=
P_LM_RELIABLE);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> + =A0 =A0 case L2CAP_FORCE_ACTIVE_MODE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (get_user(opt, (u32 __user *) optval)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->conn->hcon->force_active =3D opt=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOPROTOOPT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> @@ -2058,6 +2067,12 @@ static int l2cap_sock_getsockopt_old(struct socke=
t *sock, int optname, char __us
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> + =A0 =A0 case L2CAP_FORCE_ACTIVE_MODE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (put_user(l2cap_pi(sk)->conn->hcon->force_a=
ctive,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (u32 __user *) optval))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EFAULT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOPROTOOPT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> I think that I said this before. Why do you think that adding a new
> socket option to something called _old is a good idea? I made it pretty
> clear in the code that it is an OLD interface.
>
> I want this on the SOL_BLUETOOTH level with a proper new socket option.
> And we might even consider doing it like BT_SECURITY where create the
> struct to potentially add other flags later.

This can be done.

> So why not doing BT_POWER or something like that.
>
> And in addition you need to store these values on a per L2CAP or RFCOMM
> socket. You can not just go ahead and mess inside hci_conn via an L2CAP
> socket option.

I felt that Sniff Mode is a property of ACL link and not L2CAP or RFCOMM so=
cket.

There is already code in the same functions which use the same
technique to access
following hci_conn fields:

l2cap_pi(sk)->conn->hcon->handle
l2cap_pi(sk)->conn->hcon->dev_class

Regards,
Andrei
