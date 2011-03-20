Return-Path: <cyrus@holtmann.org>
From: Iain Hibbert <plunky@netbsd.org>
Date: Sun, 20 Mar 2011 20:24:22 +0000
Subject: [PATCH] use correct size to copy 'direction' value
To: linux-bluetooth@vger.kernel.org
Message-Id: <20110403204828.A56C0260156@galant.ukfsn.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

frm.in is stored as an uint8_t, so we cannot copy an int there
directly.  use an intermediate variable so that it also works
on big-endian systems.
---
 src/hcidump.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/hcidump.c b/src/hcidump.c
index af086c7..844720d 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -299,7 +299,8 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 		while (cmsg) {
 			switch (cmsg->cmsg_type) {
 			case HCI_CMSG_DIR:
-				memcpy(&frm.in, CMSG_DATA(cmsg), sizeof(int));
+				memcpy(&i, CMSG_DATA(cmsg), sizeof(int));
+				frm.in = (uint8_t)i;
 				break;
 			case HCI_CMSG_TSTAMP:
 				memcpy(&frm.ts, CMSG_DATA(cmsg),
-- 
1.7.3.4

