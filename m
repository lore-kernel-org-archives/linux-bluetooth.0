Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 9/9] Set Intermediate property if intermediate temp. characteristic is supported
Date: Thu, 29 Sep 2011 15:46:28 +0200
Message-Id: <1317303988-26310-10-git-send-email-sancane@gmail.com>
In-Reply-To: <1317303988-26310-9-git-send-email-sancane@gmail.com>
References: <1317303988-26310-1-git-send-email-sancane@gmail.com>
 <1317303988-26310-2-git-send-email-sancane@gmail.com>
 <1317303988-26310-3-git-send-email-sancane@gmail.com>
 <1317303988-26310-4-git-send-email-sancane@gmail.com>
 <1317303988-26310-5-git-send-email-sancane@gmail.com>
 <1317303988-26310-6-git-send-email-sancane@gmail.com>
 <1317303988-26310-7-git-send-email-sancane@gmail.com>
 <1317303988-26310-8-git-send-email-sancane@gmail.com>
 <1317303988-26310-9-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 8cfc0e4..e9e93cf 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -224,7 +224,8 @@ static void process_thermometer_char(struct characteristic *ch)
 	GAttribResultFunc func;
 
 	if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
-		/* TODO: Change intermediate property and emit signal */
+		gboolean intermediate = TRUE;
+		change_property(ch->t, "Intermediate", &intermediate);
 		return;
 	} else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0)
 		func = read_temp_type_cb;
-- 
1.7.6.1

