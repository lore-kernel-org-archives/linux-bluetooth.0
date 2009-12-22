Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Dec 2009 15:29:12 +0200
Message-ID: <508e92ca0912220529q56d0ca1clef1cd5916edf4aac@mail.gmail.com>
Subject: [PATCH] Bluetooth: Remove double free of skb pointer
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0015175ce1ec13ea48047b5131fc
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0015175ce1ec13ea48047b5131fc
Content-Type: text/plain; charset=ISO-8859-1

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Trivial fix for double free of skb pointer with kfree_skb to
make code simplier and cleaner.

skb is already freed within l2cap_data_channel_iframe function.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 1120cf1..9584b97 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3574,9 +3574,7 @@ static inline int l2cap_data_channel(struct
l2cap_conn *conn, u16 cid, struct sk
                else
                        err = l2cap_data_channel_sframe(sk, control, skb);

-               if (!err)
-                       goto done;
-               break;
+               goto done;

        case L2CAP_MODE_STREAMING:
                control = get_unaligned_le16(skb->data);
--
1.6.0.4

--0015175ce1ec13ea48047b5131fc
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Remove-double-free-of-skb-pointer.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Remove-double-free-of-skb-pointer.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3ipnhef0

RnJvbSBmYjViZmM2MTU3MDI4YzYwNDdhOGY5ZWY2MGFiY2VmODlhYTI0M2Q0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgRW1lbHRjaGVua28gPGFuZHJlaS5lbWVsdGNoZW5r
b0Bub2tpYS5jb20+CkRhdGU6IFR1ZSwgMjIgRGVjIDIwMDkgMTU6MDU6MDYgKzAyMDAKU3ViamVj
dDogW1BBVENIXSBCbHVldG9vdGg6IFJlbW92ZSBkb3VibGUgZnJlZSBvZiBza2IgcG9pbnRlcgoK
VHJpdmlhbCBmaXggZm9yIGRvdWJsZSBmcmVlIG9mIHNrYiBwb2ludGVyIHdpdGgga2ZyZWVfc2ti
IHRvCm1ha2UgY29kZSBzaW1wbGllciBhbmQgY2xlYW5lci4KCnNrYiBpcyBhbHJlYWR5IGZyZWVk
IHdpdGhpbiBsMmNhcF9kYXRhX2NoYW5uZWxfaWZyYW1lIGZ1bmN0aW9uLgoKU2lnbmVkLW9mZi1i
eTogQW5kcmVpIEVtZWx0Y2hlbmtvIDxhbmRyZWkuZW1lbHRjaGVua29Abm9raWEuY29tPgotLS0K
IG5ldC9ibHVldG9vdGgvbDJjYXAuYyB8ICAgIDQgKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9s
MmNhcC5jIGIvbmV0L2JsdWV0b290aC9sMmNhcC5jCmluZGV4IDExMjBjZjEuLjk1ODRiOTcgMTAw
NjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvbDJjYXAuYworKysgYi9uZXQvYmx1ZXRvb3RoL2wyY2Fw
LmMKQEAgLTM1NzQsOSArMzU3NCw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGwyY2FwX2RhdGFfY2hh
bm5lbChzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwgdTE2IGNpZCwgc3RydWN0IHNrCiAJCWVsc2UK
IAkJCWVyciA9IGwyY2FwX2RhdGFfY2hhbm5lbF9zZnJhbWUoc2ssIGNvbnRyb2wsIHNrYik7CiAK
LQkJaWYgKCFlcnIpCi0JCQlnb3RvIGRvbmU7Ci0JCWJyZWFrOworCQlnb3RvIGRvbmU7CiAKIAlj
YXNlIEwyQ0FQX01PREVfU1RSRUFNSU5HOgogCQljb250cm9sID0gZ2V0X3VuYWxpZ25lZF9sZTE2
KHNrYi0+ZGF0YSk7Ci0tIAoxLjYuMC40Cgo=
--0015175ce1ec13ea48047b5131fc--
