Return-Path: <cyrus@holtmann.org>
From: Iain Hibbert <plunky@rya-online.net>
Date: Thu, 14 Apr 2011 10:08:36 +0100
Subject: [PATCH] hcidump: use correct size to copy 'direction' value
To: linux-bluetooth@vger.kernel.org
Message-Id: <20110414091124.D0AB826008F@galant.ukfsn.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

frm.in is stored as an uint8_t, so we cannot copy an int there
directly.  use an intermediate variable so that it also works
on big-endian systems.
---
 src/hcidump.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/hcidump.c b/src/hcidump.c
index 2023130..f865ad6 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -281,9 +281,11 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 
 		cmsg = CMSG_FIRSTHDR(&msg);
 		while (cmsg) {
+			int dir;
 			switch (cmsg->cmsg_type) {
 			case HCI_CMSG_DIR:
-				memcpy(&frm.in, CMSG_DATA(cmsg), sizeof(int));
+				memcpy(&dir, CMSG_DATA(cmsg), sizeof(int));
+				frm.in = (uint8_t) dir;
 				break;
 			case HCI_CMSG_TSTAMP:
 				memcpy(&frm.ts, CMSG_DATA(cmsg),
-- 
1.7.4.1

