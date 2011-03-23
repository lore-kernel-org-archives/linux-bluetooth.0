Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v2] Fix strict aliasing issue
Date: Wed, 23 Mar 2011 13:11:17 +0100
Message-Id: <1300882277-24960-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes type of "pending" flag to uint32_t type.
Pointer to this flag is passed to hci_clear_bit function as void * and
then casted to uint32_t * again. Previously unsigned long type made some
unexpected performance which occured after violating strict aliasing
rule. This patch fixes this problem and this solution is much easier than
solution of changing types of many object (from uint32_t to unsigned long,
including changing type for castng in hci_*_bit function family), which
is overcomplicated. Also, not all objects can be changed, like
hci_dev_info struct, since it is violating compatibility rules between
kernel and user spaces.
---
 plugins/hciops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 4225cd8..69627eb 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -111,7 +111,7 @@ static struct dev_info {
 	uint16_t did_version;
 
 	gboolean up;
-	unsigned long pending;
+	uint32_t pending;
 
 	GIOChannel *io;
 	guint watch_id;
-- 
1.6.3.3

