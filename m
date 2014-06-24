Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] HDP: Fix NULL check
Date: Tue, 24 Jun 2014 15:07:46 +0300
Message-Id: <1403611666-26060-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Improves readability of the code using similar check for not NULL.
---
 profiles/health/hdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index eaf3e46..54aca9d 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1849,7 +1849,7 @@ static DBusMessage *device_echo(DBusConnection *conn,
 	data->cb = hdp_echo_connect_cb;
 	hdp_create_data_ref(data);
 
-	if (device->mcl_conn && device->mcl != NULL) {
+	if (device->mcl_conn && device->mcl) {
 		if (mcap_create_mdl(device->mcl, data->mdep, data->config,
 						device_create_mdl_cb, data,
 						destroy_create_dc_data, &err))
-- 
1.8.3.2

