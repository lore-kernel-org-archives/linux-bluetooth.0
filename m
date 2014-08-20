Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/health: Fix NULL dereference
Date: Wed, 20 Aug 2014 10:02:03 +0300
Message-Id: <1408518123-30621-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In a case get_app(), get_device(), get_channel() fail prevent
dereference of NULL pointer. Fixes clang warnings:
...
android/health.c:1980:15: warning: Access to field 'dev' results in a
dereference of a null pointer (loaded from variable 'channel')
        queue_remove(channel->dev->channels, channel);
                     ^~~~~~~~~~~~
1 warning generated.
...
---
 android/health.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/android/health.c b/android/health.c
index c8af90e..665482e 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1931,15 +1931,15 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 
 	app = get_app(cmd->app_id);
 	if (!app)
-		goto fail;
+		goto send_rsp;
 
 	dev = get_device(app, cmd->bdaddr);
 	if (!dev)
-		goto fail;
+		goto send_rsp;
 
 	channel = get_channel(app, cmd->mdep_index, dev);
 	if (!channel)
-		goto fail;
+		goto send_rsp;
 
 	if (!queue_length(dev->channels)) {
 		if (channel->type != CHANNEL_TYPE_RELIABLE) {
@@ -1979,6 +1979,8 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 fail:
 	queue_remove(channel->dev->channels, channel);
 	free_health_channel(channel);
+
+send_rsp:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
 			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_FAILED);
 }
-- 
1.9.1

