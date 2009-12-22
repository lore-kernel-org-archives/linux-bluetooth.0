Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Dec 2009 16:56:17 +0200
Message-ID: <508e92ca0912220656j6913ef64w4bd6c1557079d0b5@mail.gmail.com>
Subject: [PATCH] Bluetooth: Remove double free of skb pointer
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0015175cda1280252e047b526898
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0015175cda1280252e047b526898
Content-Type: text/plain; charset=ISO-8859-1

Trivial fix for double free of skb pointer with kfree_skb to
make code simplier and cleaner. Remove unused variable err.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 1120cf1..8acc19e 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3518,7 +3518,6 @@ static inline int l2cap_data_channel(struct
l2cap_conn *conn, u16 cid, struct sk
 	struct l2cap_pinfo *pi;
 	u16 control, len;
 	u8 tx_seq;
-	int err;

 	sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
 	if (!sk) {
@@ -3570,13 +3569,11 @@ static inline int l2cap_data_channel(struct
l2cap_conn *conn, u16 cid, struct sk
 			goto drop;

 		if (__is_iframe(control))
-			err = l2cap_data_channel_iframe(sk, control, skb);
+			l2cap_data_channel_iframe(sk, control, skb);
 		else
-			err = l2cap_data_channel_sframe(sk, control, skb);
+			l2cap_data_channel_sframe(sk, control, skb);

-		if (!err)
-			goto done;
-		break;
+		goto done;

 	case L2CAP_MODE_STREAMING:
 		control = get_unaligned_le16(skb->data);
@@ -3602,7 +3599,7 @@ static inline int l2cap_data_channel(struct
l2cap_conn *conn, u16 cid, struct sk
 		else
 			pi->expected_tx_seq = tx_seq + 1;

-		err = l2cap_sar_reassembly_sdu(sk, skb, control);
+		l2cap_sar_reassembly_sdu(sk, skb, control);

 		goto done;

-- 
1.6.0.4

--0015175cda1280252e047b526898
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Remove-double-free-of-skb-pointer.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Remove-double-free-of-skb-pointer.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3ispbc70

RnJvbSBiMWE3YTAzYWU1NjY0MTY2MzZmNDQzZjNkMjAxZGM3NDVkZmViMGI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IFR1ZSwgMjIgRGVjIDIwMDkgMTU6NTg6MDggKzAyMDAKU3ViamVj
dDogW1BBVENIXSBCbHVldG9vdGg6IFJlbW92ZSBkb3VibGUgZnJlZSBvZiBza2IgcG9pbnRlcgoK
VHJpdmlhbCBmaXggZm9yIGRvdWJsZSBmcmVlIG9mIHNrYiBwb2ludGVyIHdpdGgga2ZyZWVfc2ti
IHRvCm1ha2UgY29kZSBzaW1wbGllciBhbmQgY2xlYW5lci4gUmVtb3ZlIHVudXNlZCB2YXJpYWJs
ZSBlcnIuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNo
ZW5rb0Bub2tpYS5jb20+Ci0tLQogbmV0L2JsdWV0b290aC9sMmNhcC5jIHwgICAxMSArKysrLS0t
LS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9sMmNhcC5jIGIvbmV0L2JsdWV0b290aC9sMmNhcC5j
CmluZGV4IDExMjBjZjEuLjhhY2MxOWUgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvbDJjYXAu
YworKysgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwLmMKQEAgLTM1MTgsNyArMzUxOCw2IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGwyY2FwX2RhdGFfY2hhbm5lbChzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwg
dTE2IGNpZCwgc3RydWN0IHNrCiAJc3RydWN0IGwyY2FwX3BpbmZvICpwaTsKIAl1MTYgY29udHJv
bCwgbGVuOwogCXU4IHR4X3NlcTsKLQlpbnQgZXJyOwogCiAJc2sgPSBsMmNhcF9nZXRfY2hhbl9i
eV9zY2lkKCZjb25uLT5jaGFuX2xpc3QsIGNpZCk7CiAJaWYgKCFzaykgewpAQCAtMzU3MCwxMyAr
MzU2OSwxMSBAQCBzdGF0aWMgaW5saW5lIGludCBsMmNhcF9kYXRhX2NoYW5uZWwoc3RydWN0IGwy
Y2FwX2Nvbm4gKmNvbm4sIHUxNiBjaWQsIHN0cnVjdCBzawogCQkJZ290byBkcm9wOwogCiAJCWlm
IChfX2lzX2lmcmFtZShjb250cm9sKSkKLQkJCWVyciA9IGwyY2FwX2RhdGFfY2hhbm5lbF9pZnJh
bWUoc2ssIGNvbnRyb2wsIHNrYik7CisJCQlsMmNhcF9kYXRhX2NoYW5uZWxfaWZyYW1lKHNrLCBj
b250cm9sLCBza2IpOwogCQllbHNlCi0JCQllcnIgPSBsMmNhcF9kYXRhX2NoYW5uZWxfc2ZyYW1l
KHNrLCBjb250cm9sLCBza2IpOworCQkJbDJjYXBfZGF0YV9jaGFubmVsX3NmcmFtZShzaywgY29u
dHJvbCwgc2tiKTsKIAotCQlpZiAoIWVycikKLQkJCWdvdG8gZG9uZTsKLQkJYnJlYWs7CisJCWdv
dG8gZG9uZTsKIAogCWNhc2UgTDJDQVBfTU9ERV9TVFJFQU1JTkc6CiAJCWNvbnRyb2wgPSBnZXRf
dW5hbGlnbmVkX2xlMTYoc2tiLT5kYXRhKTsKQEAgLTM2MDIsNyArMzU5OSw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGwyY2FwX2RhdGFfY2hhbm5lbChzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwgdTE2
IGNpZCwgc3RydWN0IHNrCiAJCWVsc2UKIAkJCXBpLT5leHBlY3RlZF90eF9zZXEgPSB0eF9zZXEg
KyAxOwogCi0JCWVyciA9IGwyY2FwX3Nhcl9yZWFzc2VtYmx5X3NkdShzaywgc2tiLCBjb250cm9s
KTsKKwkJbDJjYXBfc2FyX3JlYXNzZW1ibHlfc2R1KHNrLCBza2IsIGNvbnRyb2wpOwogCiAJCWdv
dG8gZG9uZTsKIAotLSAKMS42LjAuNAoK
--0015175cda1280252e047b526898--
