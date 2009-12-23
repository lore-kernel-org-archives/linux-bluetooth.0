Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 23 Dec 2009 13:17:55 +0200
Message-ID: <508e92ca0912230317t3e5ff05ep9f51ef326e5e9de7@mail.gmail.com>
Subject: [PATCH] Bluetooth: Fix memory leak in l2cap
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Content-Type: multipart/mixed; boundary=0015174c1da263ba30047b6379bf
List-ID: <linux-bluetooth.vger.kernel.org>

--0015174c1da263ba30047b6379bf
Content-Type: text/plain; charset=ISO-8859-1

Hi, Please check following patch (also attached)

Move skb_clone after error confition check so it is not going
potentially out of the scope.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 1120cf1..b927045 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1368,7 +1368,6 @@ static int l2cap_ertm_send(struct sock *sk)

 	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk)) &&
 	       !(pi->conn_state & L2CAP_CONN_REMOTE_BUSY)) {
-		tx_skb = skb_clone(skb, GFP_ATOMIC);

 		if (pi->remote_max_tx &&
 				bt_cb(skb)->retries == pi->remote_max_tx) {
@@ -1376,6 +1375,8 @@ static int l2cap_ertm_send(struct sock *sk)
 			break;
 		}

+		tx_skb = skb_clone(skb, GFP_ATOMIC);
+
 		bt_cb(skb)->retries++;

 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-- 
1.6.0.4

--0015174c1da263ba30047b6379bf
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Fix-memory-leak-in-l2cap.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Fix-memory-leak-in-l2cap.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3k0ecwq0

RnJvbSA3ZjAwOTZhN2YwZDBkOGE5NGMwNTUzNzNjYjU2YmRmNjhlOWI5ZmU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IFdlZCwgMjMgRGVjIDIwMDkgMTM6MDc6MTQgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBCbHVldG9vdGg6IEZpeCBtZW1vcnkgbGVhayBpbiBsMmNhcAoKTW92ZSBza2Jf
Y2xvbmUgYWZ0ZXIgZXJyb3IgY29uZml0aW9uIGNoZWNrIHNvIGl0IGlzIG5vdCBnb2luZwpwb3Rl
bnRpYWxseSBvdXQgb2YgdGhlIHNjb3BlLgoKU2lnbmVkLW9mZi1ieTogQW5kcmVpIEVtZWx0Y2hl
bmtvIDxhbmRyZWkuZW1lbHRjaGVua29Abm9raWEuY29tPgotLS0KIG5ldC9ibHVldG9vdGgvbDJj
YXAuYyB8ICAgIDMgKystCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmMgYi9uZXQvYmx1ZXRv
b3RoL2wyY2FwLmMKaW5kZXggMTEyMGNmMS4uYjkyNzA0NSAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0
b290aC9sMmNhcC5jCisrKyBiL25ldC9ibHVldG9vdGgvbDJjYXAuYwpAQCAtMTM2OCw3ICsxMzY4
LDYgQEAgc3RhdGljIGludCBsMmNhcF9lcnRtX3NlbmQoc3RydWN0IHNvY2sgKnNrKQogCiAJd2hp
bGUgKChza2IgPSBzay0+c2tfc2VuZF9oZWFkKSAmJiAoIWwyY2FwX3R4X3dpbmRvd19mdWxsKHNr
KSkgJiYKIAkgICAgICAgIShwaS0+Y29ubl9zdGF0ZSAmIEwyQ0FQX0NPTk5fUkVNT1RFX0JVU1kp
KSB7Ci0JCXR4X3NrYiA9IHNrYl9jbG9uZShza2IsIEdGUF9BVE9NSUMpOwogCiAJCWlmIChwaS0+
cmVtb3RlX21heF90eCAmJgogCQkJCWJ0X2NiKHNrYiktPnJldHJpZXMgPT0gcGktPnJlbW90ZV9t
YXhfdHgpIHsKQEAgLTEzNzYsNiArMTM3NSw4IEBAIHN0YXRpYyBpbnQgbDJjYXBfZXJ0bV9zZW5k
KHN0cnVjdCBzb2NrICpzaykKIAkJCWJyZWFrOwogCQl9CiAKKwkJdHhfc2tiID0gc2tiX2Nsb25l
KHNrYiwgR0ZQX0FUT01JQyk7CisKIAkJYnRfY2Ioc2tiKS0+cmV0cmllcysrOwogCiAJCWNvbnRy
b2wgPSBnZXRfdW5hbGlnbmVkX2xlMTYodHhfc2tiLT5kYXRhICsgTDJDQVBfSERSX1NJWkUpOwot
LSAKMS42LjAuNAoK
--0015174c1da263ba30047b6379bf--
