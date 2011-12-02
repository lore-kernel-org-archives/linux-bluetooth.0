Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/5] hdp_manager: Fix coding style issues
Date: Fri,  2 Dec 2011 11:56:35 +0100
Message-Id: <1322823396-5941-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1322823396-5941-4-git-send-email-sancane@gmail.com>
References: <1322823396-5941-1-git-send-email-sancane@gmail.com>
 <1322823396-5941-2-git-send-email-sancane@gmail.com>
 <1322823396-5941-3-git-send-email-sancane@gmail.com>
 <1322823396-5941-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp_manager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/health/hdp_manager.c b/health/hdp_manager.c
index 60ccf55..b3c10a9 100644
--- a/health/hdp_manager.c
+++ b/health/hdp_manager.c
@@ -76,7 +76,7 @@ static struct btd_device_driver hdp_device_driver = {
 
 int hdp_manager_init(DBusConnection *conn)
 {
-	if (hdp_manager_start(conn))
+	if (hdp_manager_start(conn) < 0)
 		return -1;
 
 	connection = dbus_connection_ref(conn);
-- 
1.7.7.4

