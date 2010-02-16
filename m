Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 16 Feb 2010 12:36:47 +0200
Message-ID: <508e92ca1002160236k34c18949jc7d7187645ef4aa0@mail.gmail.com>
Subject: [PATCH] Bluetooth: Fix kernel crash on BT stress tests.
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0015174c179e913b21047fb54f5f
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0015174c179e913b21047fb54f5f
Content-Type: text/plain; charset=ISO-8859-1

>From 0135f732cb45e5e91062aca84a61a40b172200a4 Mon Sep 17 00:00:00 2001
From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
Date: Tue, 16 Feb 2010 10:52:33 +0200
Subject: [PATCH] Bluetooth: Fix kernel crash on BT stress tests.

Added very simple check that req buffer has enough space to
fit configuration parameters. Shall be enough to reject packets
with configuration size more than req buffer.

Crash trace below

[ 6069.659393] Unable to handle kernel paging request at virtual
address 02000205
[ 6069.673034] Internal error: Oops: 805 [#1] PREEMPT
...
[ 6069.727172] PC is at l2cap_add_conf_opt+0x70/0xf0 [l2cap]
[ 6069.732604] LR is at l2cap_recv_frame+0x1350/0x2e78 [l2cap]
...
[ 6070.030303] Backtrace:
[ 6070.032806] [<bf1c2880>] (l2cap_add_conf_opt+0x0/0xf0 [l2cap]) from
[<bf1c6624>] (l2cap_recv_frame+0x1350/0x2e78 [l2cap])
[ 6070.043823]  r8:dc5d3100 r7:df2a91d6 r6:00000001 r5:df2a8000 r4:00000200
[ 6070.050659] [<bf1c52d4>] (l2cap_recv_frame+0x0/0x2e78 [l2cap]) from
[<bf1c8408>] (l2cap_recv_acldata+0x2bc/0x350 [l2cap])
[ 6070.061798] [<bf1c814c>] (l2cap_recv_acldata+0x0/0x350 [l2cap]) from
[<bf0037a4>] (hci_rx_task+0x244/0x478 [bluetooth])
[ 6070.072631]  r6:dc647700 r5:00000001 r4:df2ab740
[ 6070.077362] [<bf003560>] (hci_rx_task+0x0/0x478 [bluetooth]) from
[<c006b9fc>] (tasklet_action+0x78/0xd8)
[ 6070.087005] [<c006b984>] (tasklet_action+0x0/0xd8) from [<c006c160>]

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 400efa2..69b7280 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2830,6 +2830,12 @@ static inline int l2cap_config_rsp(struct
l2cap_conn *conn, struct l2cap_cmd_hdr
 			int len = cmd->len - sizeof(*rsp);
 			char req[64];

+			if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
+				BT_ERR("Config response is too big");
+				l2cap_send_disconn_req(conn, sk);
+				goto done;
+			}
+
 			/* throw out any old stored conf requests */
 			result = L2CAP_CONF_SUCCESS;
 			len = l2cap_parse_conf_rsp(sk, rsp->data,
-- 
1.6.0.4

--0015174c179e913b21047fb54f5f
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Fix-kernel-crash-on-BT-stress-tests.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Fix-kernel-crash-on-BT-stress-tests.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5qk5qpn0

RnJvbSAwMTM1ZjczMmNiNDVlNWU5MTA2MmFjYTg0YTYxYTQwYjE3MjIwMGE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IFR1ZSwgMTYgRmViIDIwMTAgMTA6NTI6MzMgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBCbHVldG9vdGg6IEZpeCBrZXJuZWwgY3Jhc2ggb24gQlQgc3RyZXNzIHRlc3Rz
LgoKQWRkZWQgdmVyeSBzaW1wbGUgY2hlY2sgdGhhdCByZXEgYnVmZmVyIGhhcyBlbm91Z2ggc3Bh
Y2UgdG8KZml0IGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVycy4gU2hhbGwgYmUgZW5vdWdoIHRvIHJl
amVjdCBwYWNrZXRzCndpdGggY29uZmlndXJhdGlvbiBzaXplIG1vcmUgdGhhbiByZXEgYnVmZmVy
LgoKQ3Jhc2ggdHJhY2UgYmVsb3cKClsgNjA2OS42NTkzOTNdIFVuYWJsZSB0byBoYW5kbGUga2Vy
bmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyAwMjAwMDIwNQpbIDYwNjkuNjcz
MDM0XSBJbnRlcm5hbCBlcnJvcjogT29wczogODA1IFsjMV0gUFJFRU1QVAouLi4KWyA2MDY5Ljcy
NzE3Ml0gUEMgaXMgYXQgbDJjYXBfYWRkX2NvbmZfb3B0KzB4NzAvMHhmMCBbbDJjYXBdClsgNjA2
OS43MzI2MDRdIExSIGlzIGF0IGwyY2FwX3JlY3ZfZnJhbWUrMHgxMzUwLzB4MmU3OCBbbDJjYXBd
Ci4uLgpbIDYwNzAuMDMwMzAzXSBCYWNrdHJhY2U6ClsgNjA3MC4wMzI4MDZdIFs8YmYxYzI4ODA+
XSAobDJjYXBfYWRkX2NvbmZfb3B0KzB4MC8weGYwIFtsMmNhcF0pIGZyb20KWzxiZjFjNjYyND5d
IChsMmNhcF9yZWN2X2ZyYW1lKzB4MTM1MC8weDJlNzggW2wyY2FwXSkKWyA2MDcwLjA0MzgyM10g
IHI4OmRjNWQzMTAwIHI3OmRmMmE5MWQ2IHI2OjAwMDAwMDAxIHI1OmRmMmE4MDAwIHI0OjAwMDAw
MjAwClsgNjA3MC4wNTA2NTldIFs8YmYxYzUyZDQ+XSAobDJjYXBfcmVjdl9mcmFtZSsweDAvMHgy
ZTc4IFtsMmNhcF0pIGZyb20KWzxiZjFjODQwOD5dIChsMmNhcF9yZWN2X2FjbGRhdGErMHgyYmMv
MHgzNTAgW2wyY2FwXSkKWyA2MDcwLjA2MTc5OF0gWzxiZjFjODE0Yz5dIChsMmNhcF9yZWN2X2Fj
bGRhdGErMHgwLzB4MzUwIFtsMmNhcF0pIGZyb20KWzxiZjAwMzdhND5dIChoY2lfcnhfdGFzaysw
eDI0NC8weDQ3OCBbYmx1ZXRvb3RoXSkKWyA2MDcwLjA3MjYzMV0gIHI2OmRjNjQ3NzAwIHI1OjAw
MDAwMDAxIHI0OmRmMmFiNzQwClsgNjA3MC4wNzczNjJdIFs8YmYwMDM1NjA+XSAoaGNpX3J4X3Rh
c2srMHgwLzB4NDc4IFtibHVldG9vdGhdKSBmcm9tCls8YzAwNmI5ZmM+XSAodGFza2xldF9hY3Rp
b24rMHg3OC8weGQ4KQpbIDYwNzAuMDg3MDA1XSBbPGMwMDZiOTg0Pl0gKHRhc2tsZXRfYWN0aW9u
KzB4MC8weGQ4KSBmcm9tIFs8YzAwNmMxNjA+XQoKU2lnbmVkLW9mZi1ieTogQW5kcmVpIEVtZWx0
Y2hlbmtvIDxhbmRyZWkuZW1lbHRjaGVua29Abm9raWEuY29tPgotLS0KIG5ldC9ibHVldG9vdGgv
bDJjYXAuYyB8ICAgIDYgKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmMgYi9uZXQv
Ymx1ZXRvb3RoL2wyY2FwLmMKaW5kZXggNDAwZWZhMi4uNjliNzI4MCAxMDA2NDQKLS0tIGEvbmV0
L2JsdWV0b290aC9sMmNhcC5jCisrKyBiL25ldC9ibHVldG9vdGgvbDJjYXAuYwpAQCAtMjgzMCw2
ICsyODMwLDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IGwyY2FwX2NvbmZpZ19yc3Aoc3RydWN0IGwy
Y2FwX2Nvbm4gKmNvbm4sIHN0cnVjdCBsMmNhcF9jbWRfaGRyCiAJCQlpbnQgbGVuID0gY21kLT5s
ZW4gLSBzaXplb2YoKnJzcCk7CiAJCQljaGFyIHJlcVs2NF07CiAKKwkJCWlmIChsZW4gPiBzaXpl
b2YocmVxKSAtIHNpemVvZihzdHJ1Y3QgbDJjYXBfY29uZl9yZXEpKSB7CisJCQkJQlRfRVJSKCJD
b25maWcgcmVzcG9uc2UgaXMgdG9vIGJpZyIpOworCQkJCWwyY2FwX3NlbmRfZGlzY29ubl9yZXEo
Y29ubiwgc2spOworCQkJCWdvdG8gZG9uZTsKKwkJCX0KKwogCQkJLyogdGhyb3cgb3V0IGFueSBv
bGQgc3RvcmVkIGNvbmYgcmVxdWVzdHMgKi8KIAkJCXJlc3VsdCA9IEwyQ0FQX0NPTkZfU1VDQ0VT
UzsKIAkJCWxlbiA9IGwyY2FwX3BhcnNlX2NvbmZfcnNwKHNrLCByc3AtPmRhdGEsCi0tIAoxLjYu
MC40Cgo=
--0015174c179e913b21047fb54f5f--
