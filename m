Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] tools: Fix mpris-player creating busname starting with digit
Date: Thu, 31 Jan 2013 09:33:55 -0600
Message-Id: <1359646436-8113-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
References: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

D-Bus does not allow a bus name starting with digits after . so the code
now prefix with bt_ if the device name starts with a digit.
---
 tools/mpris-player.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index b82b5df..4dbde90 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1381,7 +1381,11 @@ static const GDBusPropertyTable mpris_properties[] = {
 
 static char *mpris_busname(char *name)
 {
-	return g_strconcat(MPRIS_BUS_NAME,
+	if (g_ascii_isdigit(name[0]))
+		return g_strconcat(MPRIS_BUS_NAME, "bt_",
+				g_strcanon(name, A_Z a_z _0_9, '_'), NULL);
+	else
+		return g_strconcat(MPRIS_BUS_NAME,
 				g_strcanon(name, A_Z a_z _0_9, '_'), NULL);
 }
 
-- 
1.8.1

