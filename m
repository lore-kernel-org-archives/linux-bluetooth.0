Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E01BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E475E610FB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhJMMpL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhJMMpH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 08:45:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2FC061746
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:43:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v203-20020a25c5d4000000b005bb21580411so2876100ybe.19
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cSVE9/r0djkXzQTDMYaFKUO18EGrjuvx2ljj44H0Ioc=;
        b=JDYh/uc+lMPJ5GOW89LDdVydP8QebAa68jF+oHuZpHpuHCGxTohQ5ldlAhXQRO/aLQ
         7KKDRXrm7eQnOgJ5KsDLCVshpaYxIMRL5X1rLCtkNHo7gCpoKJQSP+zzilpDbMRYRwqv
         k3NOzwgbTvk3MrIIL6CTlIx2s24V/NmqKr95I6H4UewIFl9WMqrwSC8WTu8ZVZAR+owQ
         8hOOUHHrQCf5Bc4cPH0XyDUxh8BjEPA5HwuFCXPXtvVItT5Z0ZAlBFWg1k0aY5L5GbQf
         s4DV2V+Tm24NtwIHnQCpLN/Nz9qdGzQTrT2EasJZodl5X2eYUR1eVXkwRUhg72Rvi1VY
         ZAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cSVE9/r0djkXzQTDMYaFKUO18EGrjuvx2ljj44H0Ioc=;
        b=Vyyz2UjOvyMdDTXkRgT8u8NGiqGE3PtqqHHVtx9xWHAwisweR7EWdWTV2j18xCPems
         f0T1upO2uhA8vSUs77EtPyNiNKfLDXvQEpsBRWQL9CNzU204py4NqJo94lUSbIuaUAA5
         EqiywjCQju6OfQEzOXqT6qgQIWzYySVx7taSOunW6FQbZheZrg85Z76bE4V50ZhGwXXy
         SPeW6UiWZjPVaKgpRN3OZBMr/cpn56clDsdsch7ZvWfhlp2B7pL/nkqVEcTufUBSTymP
         mpH8rh8RtfehdsNa+uBX3JzapcICzGPaWt6CGFFrl3G3BQuguJ4nudDE8P7sZFDAwpcw
         nELA==
X-Gm-Message-State: AOAM5322sKkbIiN9lYcT1ISHIPhLBzsnGmV1luDcppf7XOCMBEetLvqE
        QjsTGuPCvsUyBYOh1WT5r8UhPNLO6hZ4cw==
X-Google-Smtp-Source: ABdhPJwtN9CVQW0VAxd4qmdNig8X8SxmQPgA8hpTLcXYK3ZI/py3Fs2nw0q0iyvwh9/ORFQVropIuMrrt42FbQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:f8a0:57c1:fc2b:3837])
 (user=mmandlik job=sendgmr) by 2002:a25:56:: with SMTP id 83mr36477743yba.262.1634128983504;
 Wed, 13 Oct 2021 05:43:03 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:42:09 -0700
In-Reply-To: <20211013124210.1454876-1-mmandlik@google.com>
Message-Id: <20211013053935.BlueZ.v2.2.Ied4afb8c4c882e573f4a23670fc060cbc3e319c9@changeid>
Mime-Version: 1.0
References: <20211013124210.1454876-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v2 2/3] lib: Add definition of the Adv Monitor Device
 Lost event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a flag to the Device Found event to indicate that the
controller is tracking a device and adds definition of the new Device
Lost event to indicate that the controller has stopped tracking that
device.

---

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.

 lib/mgmt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321..70e3d31f9 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -856,12 +856,14 @@ struct mgmt_ev_auth_failed {
 #define MGMT_DEV_FOUND_CONFIRM_NAME	0x01
 #define MGMT_DEV_FOUND_LEGACY_PAIRING	0x02
 #define MGMT_DEV_FOUND_NOT_CONNECTABLE	0x04
+#define MGMT_DEV_FOUND_MONITORING	0x10
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
 	struct mgmt_addr_info addr;
 	int8_t rssi;
 	uint32_t flags;
+	uint16_t monitor_handle;
 	uint16_t eir_len;
 	uint8_t eir[0];
 } __packed;
@@ -1014,6 +1016,12 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_ADV_MONITOR_DEVICE_LOST		0x002f
+struct mgmt_ev_adv_monitor_device_lost {
+	uint16_t monitor_handle;
+	struct mgmt_addr_info addr;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1152,6 +1160,7 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Removed",
 	"Controller Suspend",
 	"Controller Resume",
+	"Advertisement Monitor Device Lost",		/* 0x002f */
 };
 
 static const char *mgmt_status[] = {
-- 
2.33.0.882.g93a45727a2-goog

