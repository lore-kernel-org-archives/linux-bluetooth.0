Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100516083122.GA21819@vigoh>
References: <AANLkTilNBHEMhl7rFK7DemxPQu3LN2QGWSsL7b-e9Yl3@mail.gmail.com>
	 <20100516083122.GA21819@vigoh>
Date: Mon, 17 May 2010 12:45:50 +0300
Message-ID: <AANLkTimyNqIdMoZ6J6InYRzD1JNl1Fsv-CdVpd84pjot@mail.gmail.com>
Subject: Re: [PATCH] Kernel crash when krfcomm is preempted by l2cap tasklet
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=00151759080c0c5c330486c7174c
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--00151759080c0c5c330486c7174c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

Thanks for reviewing the patch. Please check new patches attached and
comments below:

On Sun, May 16, 2010 at 11:31 AM, Gustavo F. Padovan
<gustavo@padovan.org> wrote:
> Hi Andrei,
>
> * Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-05-14 18:3=
9:40 +0300]:
>
>> Hi all,
>>
>> We have a bug with race condition between l2cap tasklet and krfcomm proc=
ess.
>>
>> When sending following sequence:
>>
>> ...
>> No. =A0 =A0 Time =A0 =A0 =A0 =A0Source =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0De=
stination =A0 =A0 =A0 =A0 =A0 Protocol Info
>> =A0 =A0 =A089 1.951202 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Rcvd DISC DLCI=
=3D20
>> =A0 =A0 =A090 1.951324 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Sent UA DLCI=3D=
20
>> =A0 =A0 =A091 1.959381 =A0 =A0 =A0 =A0 =A0 =A0HCI_EVT =A0 Number of Comp=
leted Packets
>> =A0 =A0 =A092 1.966461 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Rcvd DISC DLCI=
=3D0
>> =A0 =A0 =A093 1.966492 =A0 =A0 =A0 =A0 =A0 =A0L2CAP =A0 =A0Rcvd Disconne=
ct Request
>> =A0 =A0 =A094 1.972595 =A0 =A0 =A0 =A0 =A0 =A0L2CAP =A0 =A0Sent Disconne=
ct Response
>>
>> ...
>>
>> krfcommd kernel thread is preempted with l2cap tasklet which remove l2ca=
p_conn
>> (L2CAP connection handler structure). Then rfcomm thread tries to send R=
FCOMM
>> UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn cras=
h
>> happens.
>>
>> ...
>> [ =A0694.175933] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000
>> [ =A0694.184936] pgd =3D c0004000
>> [ =A0694.187683] [00000000] *pgd=3D00000000
>> [ =A0694.191711] Internal error: Oops: 5 [#1] PREEMPT
>> [ =A0694.196350] last sysfs file:
>> /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
>> [ =A0694.260375] CPU: 0 =A0 =A0Not tainted =A0(2.6.32.10 #1)
>> [ =A0694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
>> [ =A0694.270721] LR is at 0xd7017303
>> ...
>> [ =A0694.525085] Backtrace:
>> [ =A0694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap])
>> from [<c02f2cc8>] (sock_sendmsg+0xb8
>> [ =A0694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>]
>> (kernel_sendmsg+0x48/0x80)
>> ...
>>
>> I have a patch which fixes the issue but not sure that there is no
>> better way. Waiting for comments.
>>
>> Currently I am investigating possibility to:
>> - implement l2cap_conn reference counting
>
> sock_owned_by_user() gives the same effect as a ref count. See comments b=
elow.
>

Yes. For this cases this is enough. But proper refcounting is always
better than this "effects" ;)

>> - use socket backlog queue to process l2cap packets later when socket is=
 not
>> owned by the process.
>
> You actually don't need a backlog queue here. You can process the signal
> packet, skipping the l2cap_chan_del() call;
>
...
>> + =A0 =A0 /* sk is locked in krfcomm process */
>> + =A0 =A0 if (sock_owned_by_user(sk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 BT_DBG("sk %p is owned by user", sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>
> That's wrong. Use the sock_owned_by_user() only to avoid the
> l2cap_chan_del() call, so you can process all the rest of the function
> and send the Disconnect Response.

I have changed the patch so that it only prevents l2cap_chan_del
-		l2cap_chan_del(sk, ECONNREFUSED);
+		/* delete l2cap channel if sk is not owned by user */
+		if (!sock_owned_by_user(sk))
+			l2cap_chan_del(sk, ECONNREFUSED);

Then still l2cap_sock_kill(sk) removes sk but in the second patch sk is
hold with sock_hold(sk) until rfcomm is still processing packet.

> The same check should be added to l2cap_connect_rsp() and
> l2cap_disconnect_rsp(), since they call l2cap_chan_del() under bh
> context as well. ;)

Added.

Regards,
Andrei Emeltchenko

--00151759080c0c5c330486c7174c
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Check-sk-is-not-owned-before-freeing-l2cap.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Check-sk-is-not-owned-before-freeing-l2cap.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9b3xc490

RnJvbSA4NTMxYzhhZGQ4YTM3OGZjMjRiOTJmMmMyMzExYjAxYTdiMWY2M2ZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IE1vbiwgMTcgTWF5IDIwMTAgMTI6MTA6NDYgKzAzMDAKU3ViamVj
dDogW1BBVENIIDEvMl0gQmx1ZXRvb3RoOiBDaGVjayBzayBpcyBub3Qgb3duZWQgYmVmb3JlIGZy
ZWVpbmcgbDJjYXBfY29ubgoKQ2hlY2sgdGhhdCBzb2NrZXQgc2sgaXMgbm90IGxvY2tlZCBpbiB1
c2VyIHByb2Nlc3MgYmVmb3JlIHJlbW92aW5nCmwyY2FwIGNvbm5lY3Rpb24gaGFuZGxlci4KCmty
ZmNvbW1kIGtlcm5lbCB0aHJlYWQgbWF5IGJlIHByZWVtcHRlZCB3aXRoIGwyY2FwIHRhc2tsZXQg
d2hpY2ggcmVtb3ZlCmwyY2FwX2Nvbm4gc3RydWN0dXJlLiBJZiBrcmZjb21tZCBpcyBpbiBwcm9j
ZXNzIG9mIHNlbmRpbmcgb2YgUkZDT01NIHJlcGx5CihsaWtlICJSRkNPTU0gVUEiIHJlcGx5IHRv
ICJSRkNPTU0gRElTQyIpIHRoZW4ga2VybmVsIGNyYXNoIGhhcHBlbnMuCgouLi4KWyAgNjk0LjE3
NTkzM10gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0
IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMApbICA2OTQuMTg0OTM2XSBwZ2QgPSBjMDAwNDAwMApb
ICA2OTQuMTg3NjgzXSBbMDAwMDAwMDBdICpwZ2Q9MDAwMDAwMDAKWyAgNjk0LjE5MTcxMV0gSW50
ZXJuYWwgZXJyb3I6IE9vcHM6IDUgWyMxXSBQUkVFTVBUClsgIDY5NC4xOTYzNTBdIGxhc3Qgc3lz
ZnMgZmlsZTogL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2hjaV9oNHAvZmlybXdhcmUvaGNpX2g0cC9s
b2FkaW5nClsgIDY5NC4yNjAzNzVdIENQVTogMCAgICBOb3QgdGFpbnRlZCAgKDIuNi4zMi4xMCAj
MSkKWyAgNjk0LjI2NTEwNl0gUEMgaXMgYXQgbDJjYXBfc29ja19zZW5kbXNnKzB4NDNjLzB4NzNj
IFtsMmNhcF0KWyAgNjk0LjI3MDcyMV0gTFIgaXMgYXQgMHhkNzAxNzMwMwouLi4KWyAgNjk0LjUy
NTA4NV0gQmFja3RyYWNlOgpbICA2OTQuNTI3NTg3XSBbPGJmMjY2YmUwPl0gKGwyY2FwX3NvY2tf
c2VuZG1zZysweDAvMHg3M2MgW2wyY2FwXSkgZnJvbSBbPGMwMmYyY2M4Pl0gKHNvY2tfc2VuZG1z
ZysweGI4LzB4ZDgpClsgIDY5NC41MzcyOTJdIFs8YzAyZjJjMTA+XSAoc29ja19zZW5kbXNnKzB4
MC8weGQ4KSBmcm9tIFs8YzAyZjMwNDQ+XSAoa2VybmVsX3NlbmRtc2crMHg0OC8weDgwKQouLi4K
Ck1vZGlmaWVkIHZlcnNpb24gYWZ0ZXIgY29tbWVudHMgb2YgR3VzdGF2byBGLiBQYWRvdmFuIDxn
dXN0YXZvQHBhZG92YW4ub3JnPgoKU2lnbmVkLW9mZi1ieTogQW5kcmVpIEVtZWx0Y2hlbmtvIDxh
bmRyZWkuZW1lbHRjaGVua29Abm9raWEuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvbDJjYXAuYyB8
ICAgMTQgKysrKysrKysrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmMgYi9uZXQv
Ymx1ZXRvb3RoL2wyY2FwLmMKaW5kZXggYmIwMDAxNS4uNzk0ZjJiNyAxMDA2NDQKLS0tIGEvbmV0
L2JsdWV0b290aC9sMmNhcC5jCisrKyBiL25ldC9ibHVldG9vdGgvbDJjYXAuYwpAQCAtMjkyNyw3
ICsyOTI3LDkgQEAgc3RhdGljIGlubGluZSBpbnQgbDJjYXBfY29ubmVjdF9yc3Aoc3RydWN0IGwy
Y2FwX2Nvbm4gKmNvbm4sIHN0cnVjdCBsMmNhcF9jbWRfaGQKIAkJYnJlYWs7CiAKIAlkZWZhdWx0
OgotCQlsMmNhcF9jaGFuX2RlbChzaywgRUNPTk5SRUZVU0VEKTsKKwkJLyogZGVsZXRlIGwyY2Fw
IGNoYW5uZWwgaWYgc2sgaXMgbm90IG93bmVkIGJ5IHVzZXIgKi8KKwkJaWYgKCFzb2NrX293bmVk
X2J5X3VzZXIoc2spKQorCQkJbDJjYXBfY2hhbl9kZWwoc2ssIEVDT05OUkVGVVNFRCk7CiAJCWJy
ZWFrOwogCX0KIApAQCAtMzEzNSw3ICszMTM3LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGwyY2Fw
X2Rpc2Nvbm5lY3RfcmVxKHN0cnVjdCBsMmNhcF9jb25uICpjb25uLCBzdHJ1Y3QgbDJjYXBfY21k
CiAJCWRlbF90aW1lcigmbDJjYXBfcGkoc2spLT5hY2tfdGltZXIpOwogCX0KIAotCWwyY2FwX2No
YW5fZGVsKHNrLCBFQ09OTlJFU0VUKTsKKwkvKiBkZWxldGUgbDJjYXAgY2hhbm5lbCBpZiBzayBp
cyBub3Qgb3duZWQgYnkgdXNlciAqLworCWlmICghc29ja19vd25lZF9ieV91c2VyKHNrKSkKKwkJ
bDJjYXBfY2hhbl9kZWwoc2ssIEVDT05OUkVTRVQpOworCiAJYmhfdW5sb2NrX3NvY2soc2spOwog
CiAJbDJjYXBfc29ja19raWxsKHNrKTsKQEAgLTMxNjcsNyArMzE3MiwxMCBAQCBzdGF0aWMgaW5s
aW5lIGludCBsMmNhcF9kaXNjb25uZWN0X3JzcChzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwgc3Ry
dWN0IGwyY2FwX2NtZAogCQlkZWxfdGltZXIoJmwyY2FwX3BpKHNrKS0+YWNrX3RpbWVyKTsKIAl9
CiAKLQlsMmNhcF9jaGFuX2RlbChzaywgMCk7CisJLyogZGVsZXRlIGwyY2FwIGNoYW5uZWwgaWYg
c2sgaXMgbm90IG93bmVkIGJ5IHVzZXIgKi8KKwlpZiAoIXNvY2tfb3duZWRfYnlfdXNlcihzaykp
CisJCWwyY2FwX2NoYW5fZGVsKHNrLCAwKTsKKwogCWJoX3VubG9ja19zb2NrKHNrKTsKIAogCWwy
Y2FwX3NvY2tfa2lsbChzayk7Ci0tIAoxLjcuMC40Cgo=
--00151759080c0c5c330486c7174c
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-Bluetooth-Prevent-sk-freeing-in-tasklet-using-refcou.patch"
Content-Disposition: attachment;
	filename="0002-Bluetooth-Prevent-sk-freeing-in-tasklet-using-refcou.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9b3y2qy1

RnJvbSA5OWZmYjRlNDFmZjQ2MDIyY2JjNTJmM2M5NDc0MjU3OTFkZTdmYTM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IE1vbiwgMTcgTWF5IDIwMTAgMTI6Mjg6MDYgKzAzMDAKU3ViamVj
dDogW1BBVENIIDIvMl0gQmx1ZXRvb3RoOiBQcmV2ZW50IHNrIGZyZWVpbmcgaW4gdGFza2xldCB1
c2luZyByZWZjb3VudAoKU29ja2V0IHNrIG1heSBiZSBmcmVlZCBpbiB0YXNrbGV0IHdoaWxlIHN0
aWxsIGJlIGluIHVzZSBpbiBrcmZjb21tZApwcm9jZXNzLiBVc2UgcmVmY291bnQgdG8gbWFyayBz
ayBhcyB1c2VkLgoKU2lnbmVkLW9mZi1ieTogQW5kcmVpIEVtZWx0Y2hlbmtvIDxhbmRyZWkuZW1l
bHRjaGVua29Abm9raWEuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvbDJjYXAuYyB8ICAgIDIgKysK
IDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25ldC9ibHVldG9vdGgvbDJjYXAuYyBiL25ldC9ibHVldG9vdGgvbDJjYXAuYwppbmRl
eCA3OTRmMmI3Li5iZjc2MmQ2IDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmMKKysr
IGIvbmV0L2JsdWV0b290aC9sMmNhcC5jCkBAIC0xNzI0LDYgKzE3MjQsNyBAQCBzdGF0aWMgaW50
IGwyY2FwX3NvY2tfc2VuZG1zZyhzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBzb2NrZXQgKnNv
Y2ssIHN0cnVjdCBtcwogCWlmIChtc2ctPm1zZ19mbGFncyAmIE1TR19PT0IpCiAJCXJldHVybiAt
RU9QTk9UU1VQUDsKIAorCXNvY2tfaG9sZChzayk7CiAJbG9ja19zb2NrKHNrKTsKIAogCWlmIChz
ay0+c2tfc3RhdGUgIT0gQlRfQ09OTkVDVEVEKSB7CkBAIC0xODA4LDYgKzE4MDksNyBAQCBzdGF0
aWMgaW50IGwyY2FwX3NvY2tfc2VuZG1zZyhzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBzb2Nr
ZXQgKnNvY2ssIHN0cnVjdCBtcwogCiBkb25lOgogCXJlbGVhc2Vfc29jayhzayk7CisJc29ja19w
dXQoc2spOwogCXJldHVybiBlcnI7CiB9CiAKLS0gCjEuNy4wLjQKCg==
--00151759080c0c5c330486c7174c--
