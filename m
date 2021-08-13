Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BDC4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DA260F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhHMMXj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbhHMMXi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC6C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id gw9-20020a0562140f0900b0035decb1dfecso2023272qvb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XSrWSIDyb9jq1QQR+ndexAVNSLPayx0AtnDxqXP4kdU=;
        b=iOWPPcPCSf2HyTiiULacf2KbXnGmWqIDw79rSW7CYWqBxk1BXuwxhU4CNWUhcbWfAG
         frd5gM95Nhis3b5999n9yV/+6Evn9sNIXQaQ8WuCSTn57pNxrPjLFU+oNdBJcOt5Xrnl
         XVQW0Pont9tLDHK3mJoUke/FQqmhi9L58/v8dyYncMjo2IPAsu68a9b0vtsvAa5lFTPT
         WMR0/TxicLfkbK0l0ZQIMy64dY2WqAuN4fbHCKmrNnDv0IsMZoLGSTtZXAMlRJIwt5E+
         diGPckUu26qgGZadAOkRVs24+dBZLhkSXuwQc6QHlw396Ex9PPJibH1fP+iS1VXleO86
         abTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XSrWSIDyb9jq1QQR+ndexAVNSLPayx0AtnDxqXP4kdU=;
        b=icfvniLk9vBm3C+2L5b0Q4LYgasQ+74u/DA2MVGDqHp+ChNZq+xxBbrXrF+sSqfUpg
         jsu51MHdMUS3XPIWyLQvS88EsQ9jSe93nUeFJH+G/kWLfz0rvGuS0y+YfnfLxDnY7Abm
         BQk5enIsVE5SwFr/R8PI4xtDQ/NityV2tA/ldxCn1Ln/DzroIP2WSWan9mbxxG6O0rpb
         2qaDhL7ezHvQRsDAhP02gjipb5swfVsH8cVnGT7mnG9LDS7fI6oexQ04YWWHItxIg+SV
         MBB6sMtOxBa0mznyJAsFT80/vP00LUCTXqTvnY09OMtA2ZdJF8zfGJ3c0dimHym0B7A8
         HsgA==
X-Gm-Message-State: AOAM533jDHyOIony++jAOKEdgXXAlX4PtnQWINC/OXagPM1PXnSILqj4
        RKF5QwqnBN9EEuPlqljNOt9M4217kfUUQ0CD8CYcXwm9vyQGHh3cLIFnL7qRTfEIimLECF9/W+6
        kc0R2//N+Huc+Rb/7Pc/Wu6gvVLHxG/12QelW+SN2p+XPx0dHI3tuhQXTAmbnDou6JOQIRvIxCy
        D4
X-Google-Smtp-Source: ABdhPJzpL2mOdqnwPKhbIQ5mwOETDJzDuuqW+jcsr0EJEI+z9gRrXSBJLVuAMiSP69yfwUt/3xRvxObTrdkp
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a0c:aacd:: with SMTP id
 g13mr2232223qvb.20.1628857390952; Fri, 13 Aug 2021 05:23:10 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:44 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.59.I2d62a6daa8e9beecfe9e6ef9d9e99ee76b47f406@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 59/62] android: Inclusive language for volume control
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "main volume" and "main mute".
---

 android/hal-audio.c      | 12 ++++++------
 android/hal-sco.c        | 12 ++++++------
 android/hardware/audio.h | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index d37d6098c0..bd19b7299b 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1237,7 +1237,7 @@ static int audio_set_voice_volume(struct audio_hw_device *dev, float volume)
 	return -ENOSYS;
 }
 
-static int audio_set_master_volume(struct audio_hw_device *dev, float volume)
+static int audio_set_main_volume(struct audio_hw_device *dev, float volume)
 {
 	DBG("");
 	return -ENOSYS;
@@ -1346,13 +1346,13 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
 }
 
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-static int set_master_mute(struct audio_hw_device *dev, bool mute)
+static int set_main_mute(struct audio_hw_device *dev, bool mute)
 {
 	DBG("");
 	return -ENOSYS;
 }
 
-static int get_master_mute(struct audio_hw_device *dev, bool *mute)
+static int get_main_mute(struct audio_hw_device *dev, bool *mute)
 {
 	DBG("");
 	return -ENOSYS;
@@ -1574,7 +1574,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 
 	a2dp_dev->dev.init_check = audio_init_check;
 	a2dp_dev->dev.set_voice_volume = audio_set_voice_volume;
-	a2dp_dev->dev.set_master_volume = audio_set_master_volume;
+	a2dp_dev->dev.set_main_volume = audio_set_main_volume;
 	a2dp_dev->dev.set_mode = audio_set_mode;
 	a2dp_dev->dev.set_mic_mute = audio_set_mic_mute;
 	a2dp_dev->dev.get_mic_mute = audio_get_mic_mute;
@@ -1587,8 +1587,8 @@ static int audio_open(const hw_module_t *module, const char *name,
 	a2dp_dev->dev.close_input_stream = audio_close_input_stream;
 	a2dp_dev->dev.dump = audio_dump;
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-	a2dp_dev->dev.set_master_mute = set_master_mute;
-	a2dp_dev->dev.get_master_mute = get_master_mute;
+	a2dp_dev->dev.set_main_mute = set_main_mute;
+	a2dp_dev->dev.get_main_mute = get_main_mute;
 	a2dp_dev->dev.create_audio_patch = create_audio_patch;
 	a2dp_dev->dev.release_audio_patch = release_audio_patch;
 	a2dp_dev->dev.get_audio_port = get_audio_port;
diff --git a/android/hal-sco.c b/android/hal-sco.c
index d7c08a68b8..15400d5cfe 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -840,7 +840,7 @@ static int sco_set_voice_volume(struct audio_hw_device *dev, float volume)
 	return 0;
 }
 
-static int sco_set_master_volume(struct audio_hw_device *dev, float volume)
+static int sco_set_main_volume(struct audio_hw_device *dev, float volume)
 {
 	DBG("%f", volume);
 
@@ -1292,13 +1292,13 @@ static int sco_dump(const audio_hw_device_t *device, int fd)
 }
 
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-static int set_master_mute(struct audio_hw_device *dev, bool mute)
+static int set_main_mute(struct audio_hw_device *dev, bool mute)
 {
 	DBG("");
 	return -ENOSYS;
 }
 
-static int get_master_mute(struct audio_hw_device *dev, bool *mute)
+static int get_main_mute(struct audio_hw_device *dev, bool *mute)
 {
 	DBG("");
 	return -ENOSYS;
@@ -1477,7 +1477,7 @@ static int sco_open(const hw_module_t *module, const char *name,
 
 	dev->dev.init_check = sco_init_check;
 	dev->dev.set_voice_volume = sco_set_voice_volume;
-	dev->dev.set_master_volume = sco_set_master_volume;
+	dev->dev.set_main_volume = sco_set_main_volume;
 	dev->dev.set_mode = sco_set_mode;
 	dev->dev.set_mic_mute = sco_set_mic_mute;
 	dev->dev.get_mic_mute = sco_get_mic_mute;
@@ -1490,8 +1490,8 @@ static int sco_open(const hw_module_t *module, const char *name,
 	dev->dev.close_input_stream = sco_close_input_stream;
 	dev->dev.dump = sco_dump;
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-	dev->dev.set_master_mute = set_master_mute;
-	dev->dev.get_master_mute = get_master_mute;
+	dev->dev.set_main_mute = set_main_mute;
+	dev->dev.get_main_mute = get_main_mute;
 	dev->dev.create_audio_patch = create_audio_patch;
 	dev->dev.release_audio_patch = release_audio_patch;
 	dev->dev.get_audio_port = get_audio_port;
diff --git a/android/hardware/audio.h b/android/hardware/audio.h
index b612b9d11c..874aec1264 100644
--- a/android/hardware/audio.h
+++ b/android/hardware/audio.h
@@ -514,16 +514,16 @@ struct audio_hw_device {
      * Range between 0.0 and 1.0. If any value other than 0 is returned,
      * the software mixer will emulate this capability.
      */
-    int (*set_master_volume)(struct audio_hw_device *dev, float volume);
+    int (*set_main_volume)(struct audio_hw_device *dev, float volume);
 
     /**
-     * Get the current master volume value for the HAL, if the HAL supports
-     * master volume control.  AudioFlinger will query this value from the
+     * Get the current main volume value for the HAL, if the HAL supports
+     * main volume control.  AudioFlinger will query this value from the
      * primary audio HAL when the service starts and use the value for setting
-     * the initial master volume across all HALs.  HALs which do not support
+     * the initial main volume across all HALs.  HALs which do not support
      * this method may leave it set to NULL.
      */
-    int (*get_master_volume)(struct audio_hw_device *dev, float *volume);
+    int (*get_main_volume)(struct audio_hw_device *dev, float *volume);
 
     /**
      * set_mode is called when the audio mode changes. AUDIO_MODE_NORMAL mode
@@ -592,16 +592,16 @@ struct audio_hw_device {
      * set the audio mute status for all audio activities.  If any value other
      * than 0 is returned, the software mixer will emulate this capability.
      */
-    int (*set_master_mute)(struct audio_hw_device *dev, bool mute);
+    int (*set_main_mute)(struct audio_hw_device *dev, bool mute);
 
     /**
-     * Get the current master mute status for the HAL, if the HAL supports
-     * master mute control.  AudioFlinger will query this value from the primary
+     * Get the current main mute status for the HAL, if the HAL supports
+     * main mute control.  AudioFlinger will query this value from the primary
      * audio HAL when the service starts and use the value for setting the
-     * initial master mute across all HALs.  HALs which do not support this
+     * initial main mute across all HALs.  HALs which do not support this
      * method may leave it set to NULL.
      */
-    int (*get_master_mute)(struct audio_hw_device *dev, bool *mute);
+    int (*get_main_mute)(struct audio_hw_device *dev, bool *mute);
 
     /**
      * Routing control
-- 
2.33.0.rc1.237.g0d66db33f3-goog

