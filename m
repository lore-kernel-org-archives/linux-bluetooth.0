Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 19/25] Enable support to get information about mdls
Date: Mon, 10 May 2010 12:15:21 +0200
Message-Id: <1273486527-7855-19-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-18-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
 <1273486527-7855-6-git-send-email-sancane@gmail.com>
 <1273486527-7855-7-git-send-email-sancane@gmail.com>
 <1273486527-7855-8-git-send-email-sancane@gmail.com>
 <1273486527-7855-9-git-send-email-sancane@gmail.com>
 <1273486527-7855-10-git-send-email-sancane@gmail.com>
 <1273486527-7855-11-git-send-email-sancane@gmail.com>
 <1273486527-7855-12-git-send-email-sancane@gmail.com>
 <1273486527-7855-13-git-send-email-sancane@gmail.com>
 <1273486527-7855-14-git-send-email-sancane@gmail.com>
 <1273486527-7855-15-git-send-email-sancane@gmail.com>
 <1273486527-7855-16-git-send-email-sancane@gmail.com>
 <1273486527-7855-17-git-send-email-sancane@gmail.com>
 <1273486527-7855-18-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 34243df..2554cd9 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -584,6 +584,22 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 	return NULL;
 }
 
+int mcap_mdl_get_fd(struct mcap_mdl *mdl)
+{
+	if ((!mdl) || (mdl->state != MDL_CONNECTED))
+		return -1;
+
+	return g_io_channel_unix_get_fd(mdl->dc);
+}
+
+uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl)
+{
+	if (!mdl)
+		return MCAP_MDLID_RESERVED;
+
+	return mdl->mdlid;
+}
+
 static void shutdown_mdl(struct mcap_mdl *mdl)
 {
 	mdl->state = MDL_CLOSED;
-- 
1.6.3.3

