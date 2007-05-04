Return-Path: <vitervo@nokia.com>
From: Ville Tervo <ville.tervo@nokia.com>
To: bluez-devel@lists.sourceforge.net
Cc: marcel@holtmann.org, Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 1/2] [BLUETOOTH] Check that device is in rfcomm_dev_list before deleting
Date: Fri,  4 May 2007 19:43:11 +0300
Message-Id: <11782969921523-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <20070504163843.GI5925@null.research.nokia.com>
References: <20070504163843.GI5925@null.research.nokia.com>
List-ID: <bluez-devel.lists.sourceforge.net>

If RFCOMM_RELEASE_ONHUP flag is on and rfcomm_release_dev is called before
connection is closed rfcomm_dev is deleted twice from the rfcomm_dev_list list
and refcount is messed up. This patch add check before deleting device that the
device actually is listed.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/rfcomm/tty.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 9a7a44f..b2b1cce 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -517,9 +517,10 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	if (dlc->state == BT_CLOSED) {
 		if (!dev->tty) {
 			if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-				rfcomm_dev_hold(dev);
-				rfcomm_dev_del(dev);
+				if (rfcomm_dev_get(dev->id) == NULL)
+					return;
 
+				rfcomm_dev_del(dev);
 				/* We have to drop DLC lock here, otherwise
 				   rfcomm_dev_put() will dead lock if it's
 				   the last reference. */
@@ -974,8 +975,12 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 
 	rfcomm_tty_flush_buffer(tty);
 
-	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
+	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
+		if (rfcomm_dev_get(dev->id) == NULL)
+			return;
 		rfcomm_dev_del(dev);
+		rfcomm_dev_put(dev);
+	}
 }
 
 static int rfcomm_tty_read_proc(char *buf, char **start, off_t offset, int len, int *eof, void *unused)
-- 
1.5.1.1
