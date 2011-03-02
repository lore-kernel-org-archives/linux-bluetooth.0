Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 2/3] Add missing const to interactive() parameter in gatttool
Date: Wed,  2 Mar 2011 19:36:57 -0300
Message-Id: <1299105418-15795-2-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1299105418-15795-1-git-send-email-sheldon.demario@openbossa.org>
References: <1299105418-15795-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.h    |    2 +-
 attrib/interactive.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 2fd4a46..e652a81 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,7 +21,7 @@
  *
  */
 
-int interactive(gchar *dst, gboolean le);
+int interactive(const gchar *dst, gboolean le);
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 			const gchar *sec_level, int psm, int mtu,
 			BtIOConnect connect_cb);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 8429a47..e39b43c 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -691,7 +691,7 @@ static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 }
 
-int interactive(gchar *dst, int psm)
+int interactive(const gchar *dst, int psm)
 {
 	GIOChannel *pchan;
 	gint events;
-- 
1.7.1

