Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 14 May 2010 18:39:40 +0300
Message-ID: <AANLkTilNBHEMhl7rFK7DemxPQu3LN2QGWSsL7b-e9Yl3@mail.gmail.com>
Subject: [PATCH] Kernel crash when krfcomm is preempted by l2cap tasklet
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=0015175d020af7e09404868fae5c
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0015175d020af7e09404868fae5c
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

We have a bug with race condition between l2cap tasklet and krfcomm process.

When sending following sequence:

...
No.     Time        Source                Destination           Protocol Info
     89 1.951202            RFCOMM   Rcvd DISC DLCI=20
     90 1.951324            RFCOMM   Sent UA DLCI=20
     91 1.959381            HCI_EVT   Number of Completed Packets
     92 1.966461            RFCOMM   Rcvd DISC DLCI=0
     93 1.966492            L2CAP    Rcvd Disconnect Request
     94 1.972595            L2CAP    Sent Disconnect Response

...

krfcommd kernel thread is preempted with l2cap tasklet which remove l2cap_conn
(L2CAP connection handler structure). Then rfcomm thread tries to send RFCOMM
UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn crash
happens.

...
[  694.175933] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[  694.184936] pgd = c0004000
[  694.187683] [00000000] *pgd=00000000
[  694.191711] Internal error: Oops: 5 [#1] PREEMPT
[  694.196350] last sysfs file:
/sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
[  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
[  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
[  694.270721] LR is at 0xd7017303
...
[  694.525085] Backtrace:
[  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap])
from [<c02f2cc8>] (sock_sendmsg+0xb8
[  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>]
(kernel_sendmsg+0x48/0x80)
...

I have a patch which fixes the issue but not sure that there is no
better way. Waiting for comments.

Currently I am investigating possibility to:
- implement l2cap_conn reference counting
- use socket backlog queue to process l2cap packets later when socket is not
owned by the process.

--0015175d020af7e09404868fae5c
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Check-sk-is-not-used-before-freeing.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Check-sk-is-not-used-before-freeing.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g97697z90

RnJvbSA5NTVhODIxZTFlZTY2Y2Q2Zjk3MTdlYTRhMmU5YjNkZmRhZmRjMjJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IEZyaSwgMTQgTWF5IDIwMTAgMTc6NTY6MzkgKzAzMDAKU3ViamVj
dDogW1BBVENIXSBCbHVldG9vdGg6IENoZWNrIHNrIGlzIG5vdCB1c2VkIGJlZm9yZSBmcmVlaW5n
CgpDaGVjayB0aGF0IHNvY2tldCBzayBpcyBub3QgbG9ja2VkIGluIHVzZXIgcHJvY2VzcyBiZWZv
cmUgcmVtb3ZpbmcKbDJjYXAgY29ubmVjdGlvbiBoYW5kbGVyIGFuZCBzay4KCnJmY29tbSBrZXJu
ZWwgdGhyZWFkIG1heSBiZSBwcmVlbXB0ZWQgd2l0aCBsMmNhcCB0YXNrbGV0IHdoaWNoIHJlbW92
ZSBsMmNhcF9jb25uCihMMkNBUCBjb25uZWN0aW9uIGhhbmRsZXIgc3RydWN0dXJlKS4gVGhlbiBy
ZmNvbW0gdGhyZWFkIHRyaWVzIHRvIHNlbmQgUkZDT01NClVBIHdoaWNoIGlzIHJlcGx5IHRvIFJG
Q09NTSBESVNDIGFuZCB3aGVuIGRlLXJlZmVyZW5jaW5nIGwyY2FwX2Nvbm4gY3Jhc2gKY2FuIGhh
cHBlbi4KCi4uLgpbICA2OTQuMTc1OTMzXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwClsgIDY5NC4xODQ5
MzZdIHBnZCA9IGMwMDA0MDAwClsgIDY5NC4xODc2ODNdIFswMDAwMDAwMF0gKnBnZD0wMDAwMDAw
MApbICA2OTQuMTkxNzExXSBJbnRlcm5hbCBlcnJvcjogT29wczogNSBbIzFdIFBSRUVNUFQKWyAg
Njk0LjE5NjM1MF0gbGFzdCBzeXNmcyBmaWxlOiAvc3lzL2RldmljZXMvcGxhdGZvcm0vaGNpX2g0
cC9maXJtd2FyZS9oY2lfaDRwL2xvYWRpbmcKWyAgNjk0LjI2MDM3NV0gQ1BVOiAwICAgIE5vdCB0
YWludGVkICAoMi42LjMyLjEwICMxKQpbICA2OTQuMjY1MTA2XSBQQyBpcyBhdCBsMmNhcF9zb2Nr
X3NlbmRtc2crMHg0M2MvMHg3M2MgW2wyY2FwXQpbICA2OTQuMjcwNzIxXSBMUiBpcyBhdCAweGQ3
MDE3MzAzCgouLi4KClsgIDY5NC41MjUwODVdIEJhY2t0cmFjZToKWyAgNjk0LjUyNzU4N10gWzxi
ZjI2NmJlMD5dIChsMmNhcF9zb2NrX3NlbmRtc2crMHgwLzB4NzNjIFtsMmNhcF0pIGZyb20gWzxj
MDJmMmNjOD5dIChzb2NrX3NlbmRtc2crMHhiOC8weGQ4KQpbICA2OTQuNTM3MjkyXSBbPGMwMmYy
YzEwPl0gKHNvY2tfc2VuZG1zZysweDAvMHhkOCkgZnJvbSBbPGMwMmYzMDQ0Pl0gKGtlcm5lbF9z
ZW5kbXNnKzB4NDgvMHg4MCkKLi4uCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWkgRW1lbHRjaGVua28g
PGFuZHJlaS5lbWVsdGNoZW5rb0Bub2tpYS5jb20+Ci0tLQogbmV0L2JsdWV0b290aC9sMmNhcC5j
IHwgICAgNyArKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmMgYi9uZXQvYmx1ZXRv
b3RoL2wyY2FwLmMKaW5kZXggYmIwMDAxNS4uN2ViOWE1OCAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0
b290aC9sMmNhcC5jCisrKyBiL25ldC9ibHVldG9vdGgvbDJjYXAuYwpAQCAtMzExOSw2ICszMTE5
LDEzIEBAIHN0YXRpYyBpbmxpbmUgaW50IGwyY2FwX2Rpc2Nvbm5lY3RfcmVxKHN0cnVjdCBsMmNh
cF9jb25uICpjb25uLCBzdHJ1Y3QgbDJjYXBfY21kCiAJaWYgKCFzaykKIAkJcmV0dXJuIDA7CiAK
KwkvKiBzayBpcyBsb2NrZWQgaW4ga3JmY29tbSBwcm9jZXNzICovCisJaWYgKHNvY2tfb3duZWRf
YnlfdXNlcihzaykpIHsKKwkJQlRfREJHKCJzayAlcCBpcyBvd25lZCBieSB1c2VyIiwgc2spOwor
CQliaF91bmxvY2tfc29jayhzayk7CisJCXJldHVybiAwOworCX0KKwogCXJzcC5kY2lkID0gY3B1
X3RvX2xlMTYobDJjYXBfcGkoc2spLT5zY2lkKTsKIAlyc3Auc2NpZCA9IGNwdV90b19sZTE2KGwy
Y2FwX3BpKHNrKS0+ZGNpZCk7CiAJbDJjYXBfc2VuZF9jbWQoY29ubiwgY21kLT5pZGVudCwgTDJD
QVBfRElTQ09OTl9SU1AsIHNpemVvZihyc3ApLCAmcnNwKTsKLS0gCjEuNy4wLjQKCg==
--0015175d020af7e09404868fae5c--
