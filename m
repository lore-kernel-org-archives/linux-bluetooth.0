Return-Path: <SRS0=MaJy=CS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7985DC433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F56921D7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 19:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ISt9R3Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIITkQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Sep 2020 15:40:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61EC061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 12:40:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c78so3258042ybf.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mVmjxlDiU2KnidTRFEq6fyxwn9W4wZsX/zi+fKeDAo8=;
        b=ISt9R3Curlc/gQu89vI860EnN4xzu+m2uBESotHk5xyvH7H+7x8cnVdhp2znSG4HCw
         Ah0Nz9McfvkGVU8Y9l4mqNLTsb68x/NNpY+FRn3HCBN+otXnYDfZtmQl8R7dzyqhs8MR
         88axNp/W39Wisa+zywVJHmlY+PYOLk4mnTB39yh4ZpjAR+2BvXbRmVzg7nTDpHzbx4Ts
         GCJf6Zij6I+9jiw8h23y+iIpwagI21TKxmS17AHh26uICxmioCxzw/9+cIuuMlfE59db
         XvgXv4MMmRveXIDocc4VvvuGd3CBOkn5xq67m4sqJGDY5jlgODD7NzSTBzQQZ34c2YyR
         NiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mVmjxlDiU2KnidTRFEq6fyxwn9W4wZsX/zi+fKeDAo8=;
        b=RdHpJXmrgav2qRu2+9bLNjODYu4GYYFqQeZMWWMPLSz4KWC40gA+UooUB4McA1lPun
         TxD8pzO5Li+D4MbCThzERBx99hgZkUIIsVcdBUTsJdddWTSdtoD/lIB67tGdCIO6+AG1
         0oj1OCr1lXNKVW38CXR0RntrYl0MjgOdoJ+AxqzGAiA8wJ9AWOcI+0k75qxUkHomV6yd
         DgQKRv7SuXfunJSWKOwaaNLRjsOCMUzBct+WtUFJvBqScYg8ePi0iK722i19ScSRykVI
         tpupI5l+aMlzWziDTH8/EQW8CfVswu+N7QiYlsZTuOJO9lgPv2Bbk8XE1JXzzhbRgNk3
         kq4g==
X-Gm-Message-State: AOAM5301MuAQBFBZHXYxYyYsI/pgS/FH0IwGmFCzMGJ5oTumNEf8pEME
        LDqDWqKuS7vRpzia4M8rUEu5zzlzxvVJVg==
X-Google-Smtp-Source: ABdhPJyPoC7UuA9JaWb6Vi5OyCFRUFwLjDUyqI0lV/SpeUarTC8wzOaVoWN9WRFa2KqSb4tq4Aqg32Ow1l3pgQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:e50e])
 (user=mmandlik job=sendgmr) by 2002:a25:e655:: with SMTP id
 d82mr8569827ybh.347.1599680414871; Wed, 09 Sep 2020 12:40:14 -0700 (PDT)
Date:   Wed,  9 Sep 2020 12:40:01 -0700
Message-Id: <20200909123943.BlueZ.v2.1.I588558f1e38231193d6e955a4008ce54712d5c89@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [BlueZ PATCH v2] Disable auto-connect on device remove
From:   Manish Mandlik <mmandlik@google.com>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        sonnysasaka@chromium.org, linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Auto-connect is not disabled when a device is removed. So in case the
pairing is cancelled, the device is removed, but it stays in the kernel
auto-connect list. This causes future advertisement from that device to
trigger a pairing even if the user has already cancelled the pairing.

This patch disables auto-connect on device remove.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v2:
- Disable auto-connect on device remove instead of pairing cancel as this
  is the main culprit of the issue.
- Updated the title from "Disable auto-connect on cancel pair" to "Disable
  auto-connect on device remove"

 src/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index df440ce09..8f73ce4d3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4447,6 +4447,11 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 {
 	DBG("Removing device %s", device->path);
 
+	if (device->auto_connect) {
+		device->disable_auto_connect = TRUE;
+		device_set_auto_connect(device, FALSE);
+	}
+
 	if (device->bonding) {
 		uint8_t status;
 
-- 
2.28.0.526.ge36021eeef-goog

