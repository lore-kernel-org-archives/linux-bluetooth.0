Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH 2/3] mgmtops: Add debug print to update_settings
Date: Mon,  5 Mar 2012 20:05:24 +0100
Message-Id: <1330974325-4071-2-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1330974325-4071-1-git-send-email-szymon@janc.net.pl>
References: <1330974325-4071-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Print settings for easier tracking what has changed.
---
 plugins/mgmtops.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index afed165..4970b7c 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -310,6 +310,8 @@ static void update_settings(struct btd_adapter *adapter, uint32_t settings)
 	uint8_t on_mode;
 	uint16_t index, discoverable_timeout;
 
+	DBG("new settings %x", settings);
+
 	btd_adapter_get_mode(adapter, NULL, &on_mode, &discoverable_timeout,
 								&pairable);
 
-- 
1.7.9.1


