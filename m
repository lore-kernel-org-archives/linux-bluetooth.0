Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49387C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E0561B6F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhKQTSF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhKQTSF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:18:05 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1EC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:06 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r7-20020a63ce47000000b002a5cadd2f25so1575763pgi.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FWr/lcz6NN501LpemE5CKmCae255JbWooF2tV8RjfYo=;
        b=e6cvfalaKZ/xeZM1JRjbmOMDaPLxlU83+4zsbJNNdAyceEhYBAa4vzq3uNPqngZ1s/
         mp4Ox72RfgL66kQaMoBVY9Q+bPz7mq2xsuujbEQOw5ErdJYL9YcOjGGxq9BXrB34LaYC
         TChvUlUDVwmPk5T5PjvW1FR77RmFy2K0W6aLEF9qDXCsjtriFVsWxK/Rc5tV8e3UZZS9
         MRMo8ACGHr2fapuxjfhaSyl7WsgEIprusYj6w4aYutdhdTJvyP/oeHHlzPv4iHv67FcC
         U94BfMfMWWnxaPBh7/AXb7UY1YuKdez/OftyqnHbJg1PFfaX+Vp+dFGli17NeitufCAQ
         RzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FWr/lcz6NN501LpemE5CKmCae255JbWooF2tV8RjfYo=;
        b=jirDIhcghdUgnCPUs7JKbwQospqDmgYxREAKh02xNvc7LBqb1wVItt/ukuonVcINyP
         2449xSENHGAXvrJezqmcIFBquRUGSfCsxe0Oj3OEY9vAc1XwrqBGTfqf5/M2AF/ap0hq
         /yyY2pC2jZ04/LUdohqqtRcxVRNcb2VLPBkwwm1d/aIOia+tYU0j7SWeqXICYnoga8Hx
         Cfovi+H5BJOsNZaLP+Gfa2fqYQfQOe/iRTafD4ib07ZpohmKaAgs97I+QhWcybcUsjl5
         Rgsxbx5zVSnRrw6QPdI0V57ZU8lC5DPkWy9Hvq73iqEdWPbCbCAN5geV+Th9rAEL7MsY
         Q4UA==
X-Gm-Message-State: AOAM5301r8UJGmv5JbPPe0Zll1GwA5QOOpWR7REtzvibjir9oZUgheBI
        4Voa4QfXwAJt2r8JQChfjI/O4qG6JxMRew==
X-Google-Smtp-Source: ABdhPJzoiIE9hBFHp6xk/1piAT7YhO1a4tiV3gEdrtv70yJcLhfwD9UeHXuGapO32jJXCSeWO+WJ4K4ETZ+GMg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:b1b3:555c:d0fb:8921])
 (user=mmandlik job=sendgmr) by 2002:aa7:9438:0:b0:4a2:c941:9ac4 with SMTP id
 y24-20020aa79438000000b004a2c9419ac4mr23578867pfo.12.1637176505742; Wed, 17
 Nov 2021 11:15:05 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:14:46 -0800
In-Reply-To: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211117110627.BlueZ.v5.2.Ied4afb8c4c882e573f4a23670fc060cbc3e319c9@changeid>
Mime-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [BlueZ PATCH v5 2/6] lib: Add definitions of the Adv Monitor Device
 Found/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds definitions of the new Advertisement Monitor Device
Found and Device Lost events to indicate that the controller has
started/stopped tracking a particular device.

Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

Changes in v5:
- Update the Adv Monitor Device Found event to include fields from the
  existing Device Found event.

Changes in v4:
- Add Advertisement Monitor Device Found event.

Changes in v3:
- Discard changes to the Device Found event and notify bluetoothd only
  when the controller stops monitoring the device via new Device Lost
  event.

Changes in v2:
- Instead of creating a new 'Device Tracking' event, add a flag 'Device
  Tracked' in the existing 'Device Found' event and add a new 'Device
  Lost' event to indicate that the controller has stopped tracking that
  device.

 lib/mgmt.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0d1678f01..3bc35bc7c 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1014,6 +1014,22 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_ADV_MONITOR_DEVICE_FOUND	0x002f
+struct mgmt_ev_adv_monitor_device_found {
+	uint16_t monitor_handle;
+	struct mgmt_addr_info addr;
+	int8_t rssi;
+	uint32_t flags;
+	uint16_t ad_data_len;
+	uint8_t ad_data[0];
+} __packed;
+
+#define MGMT_EV_ADV_MONITOR_DEVICE_LOST		0x0030
+struct mgmt_ev_adv_monitor_device_lost {
+	uint16_t monitor_handle;
+	struct mgmt_addr_info addr;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1152,6 +1168,8 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Removed",
 	"Controller Suspend",
 	"Controller Resume",
+	"Advertisement Monitor Device Found",		/* 0x002f */
+	"Advertisement Monitor Device Lost",
 };
 
 static const char *mgmt_status[] = {
-- 
2.34.0.rc1.387.gb447b232ab-goog

