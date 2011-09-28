Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 9/9] Set Intermediate property if intermediate temp. characteristic is supported
Date: Wed, 28 Sep 2011 19:48:46 +0200
Message-Id: <1317232126-12640-10-git-send-email-sancane@gmail.com>
In-Reply-To: <1317232126-12640-9-git-send-email-sancane@gmail.com>
References: <1317232126-12640-1-git-send-email-sancane@gmail.com>
 <1317232126-12640-2-git-send-email-sancane@gmail.com>
 <1317232126-12640-3-git-send-email-sancane@gmail.com>
 <1317232126-12640-4-git-send-email-sancane@gmail.com>
 <1317232126-12640-5-git-send-email-sancane@gmail.com>
 <1317232126-12640-6-git-send-email-sancane@gmail.com>
 <1317232126-12640-7-git-send-email-sancane@gmail.com>
 <1317232126-12640-8-git-send-email-sancane@gmail.com>
 <1317232126-12640-9-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index f9371c2..5f306bf 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -242,7 +242,8 @@ static void process_thermometer_char(struct characteristic *ch)
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

