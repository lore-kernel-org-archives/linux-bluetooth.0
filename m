Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF0DEE4996
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 17:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjHUR2W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjHUR2V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 13:28:21 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238CAF7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 10:28:20 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5635233876bso3788562a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692638899; x=1693243699;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lBgb1UZc6tdHg8UgBtETSh7cVcNkNjFJ6xl1xJECihM=;
        b=3UQJ/rKx5zvVCZkqBqfL11ftqwuANShQpJa4sK4vh2z96BPk8lBUW65mZbCdqAc92c
         l7wUO8czC020EgDspN8/K38gz942YXYxCaeuAUVibjZj9G9mn/9JsApLK4898goAaDI0
         ZRuDW5vHdCiwUMHBM/UEW4SPlsVkkoXvVapY1K3CgpClv0lE8sTOlAj/rT9yuwZxzAcD
         DqfFHk0fR3A/BM0wr/SLpJMGLRzwC3vanaNP8FOyl3qkQMKCDUcyIws3RdzIfwd/zr+B
         DIxoI1iJyk1Uw0azwLFCYZU6XVnE6ZtsfWgyZ47MdsUWS4ifnX0gisWnvQmmQbrkckvD
         WtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692638899; x=1693243699;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBgb1UZc6tdHg8UgBtETSh7cVcNkNjFJ6xl1xJECihM=;
        b=mAGrlAo+1WVeyUxeyPbWYz/SQT/eJKat8KA1e+/vDYJfPgEbivR06eVsUR+0vvssKW
         J7D6V3rduiIGIazZnIGMQf3W1fksME/Y8UOyFqRY2V5rbWlNI1TtseNb1PEsl/fkG1EF
         AzuEi5MHD6mpWQfAi+zZeqapMM60Fwjcfp4D8Sn7qD7PRKHQOA0MEei8einH82CnETN2
         mh5jvk1k1xJ3bCODZ9GBwLTUpmEuYT4IRQlvR+VWxnBl75UJMyGaAbOYVQ2lUfcJs4J/
         +5WReJqlO5pS2k60nOImnzGcdPz5U2EzSW/7FIBDf+YQ6lYI5GVNN7LFUGHM+ApR7lcV
         nOcw==
X-Gm-Message-State: AOJu0YyO+zOdaSdIMSMjCYF+l/BrWjEaMOvxeoDGK1Bbf2oETrh9H8ty
        qnTzohw/Q5aMcASyUg1qZ6WlhNpyv+neO9BOl4Dey+oLYF1gPPB6cCu/XD3OB7dUjA6JJHukhpp
        vXnnCp78wJmFCH9lWaBMoq9v2iswoFN1hSUqvYtdqOpitaWbJkwKYeXbmDLwBmyRNLzai8/Y33b
        IV
X-Google-Smtp-Source: AGHT+IEHvF6rLwKQ2a9jOK9OUnVQfu49ENmLh7OYFBSDL5W/Yk5T+fRM1ZB2MTmaRduR4ZOJX4nDWnZPjWjO
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a63:79c2:0:b0:563:84fc:f4dd with SMTP id
 u185-20020a6379c2000000b0056384fcf4ddmr1257523pgc.6.1692638899525; Mon, 21
 Aug 2023 10:28:19 -0700 (PDT)
Date:   Mon, 21 Aug 2023 10:28:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821102810.Bluez.v1.1.Ib819b0964a5b8339305d94611acab85774a6c8ce@changeid>
Subject: [Bluez PATCH v1] adapter: check wake_override when setting device privacy
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For the device using a RPA, hog_probe sets wake_override to true, but
the command to set remote wakeup fails because the device has not been
added to the kernel and the connection with the public address cannot be
found.

When setting the device privacy flag, the wakeup flag should be set
according to the wake_override, instead of the current flags.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Add function to fetch wake_override value
- Set the remote wakeup bit if privacy mode is used when setting flags

 src/adapter.c | 2 ++
 src/device.c  | 5 +++++
 src/device.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 004062e7c..f63018495 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5520,6 +5520,8 @@ static void add_device_complete(uint8_t status, uint16_t length,
 	if (btd_opts.device_privacy) {
 		uint32_t flags = btd_device_get_current_flags(dev);
 
+		if (device_get_wake_override(dev))
+			flags |= DEVICE_FLAG_REMOTE_WAKEUP;
 		/* Set Device Privacy Mode has not set the flag yet. */
 		if (!(flags & DEVICE_FLAG_DEVICE_PRIVACY)) {
 			adapter_set_device_flags(adapter, dev, flags |
diff --git a/src/device.c b/src/device.c
index 9b58e0c4e..ae75f2fd1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1545,6 +1545,11 @@ void device_set_wake_override(struct btd_device *device, bool wake_override)
 	}
 }
 
+bool device_get_wake_override(struct btd_device *device)
+{
+	return device->wake_override;
+}
+
 static void device_set_wake_allowed_complete(struct btd_device *device)
 {
 	if (device->wake_id != -1U) {
diff --git a/src/device.h b/src/device.h
index 3252e14ef..79377a13a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -141,6 +141,7 @@ void device_set_wake_support(struct btd_device *device, bool wake_support);
 void device_set_wake_override(struct btd_device *device, bool wake_override);
 void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 			     guint32 id);
+bool device_get_wake_override(struct btd_device *device);
 void device_set_refresh_discovery(struct btd_device *dev, bool refresh);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
-- 
2.42.0.rc1.204.g551eb34607-goog

