Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04061C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 15:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbhKTPdA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhKTPdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 10:33:00 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B39C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:29:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q19-20020a056a00151300b004a4ca777976so696423pfu.19
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f6zYR9MAYsS0039Eqvpfb2Rwm7MPpeLd6nNVycQISeQ=;
        b=pE0DUh6TPtbXYhSKVRGbXRr1v+E2953Plpa4no+jCLMGbz9z7vHc58RErlz914sAS5
         6Ad+JRfq+lQPnaT2/JC5sJiVLenr7n3BD7kMpmqmolzVa9Rk0b6TB/I1WOWhQ5DD1HD2
         dHemqGbJ1ueFe3FxoenThqP+zgsIlhBM0lyj+zhwBTWqougf8l6z1WfNX9JfsezUSafk
         jE+/NLlD43ItH8Ov49frkxUWBIlDhs3I4m0dzjIr0mf/CD+kuz/zUNCzXdXXb0jaMK9R
         jk7HLIX4/63pEQV018XLqpZyeEhRFwaU9TzTeV4mHMI5RYekoqlTJizyxlkrEWAdEJbi
         XvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f6zYR9MAYsS0039Eqvpfb2Rwm7MPpeLd6nNVycQISeQ=;
        b=fuf71tUey1N/6k4SrTynz9sk6qix54iMZWjEWHDtqy4WP8zqulVPD8Qt3GWkeg/f2w
         hlqVW1Tn0hCr99qFlSK+sY3STpy+kmQIhsZioWz/iTvODyjqO0GGS5XT9vuxb5v1UHj/
         orSNOhITb5vH5eKC9lGjmF3SHB50z099l5i9O5Oegw84I3vcoZPTIDUFptQz+3Tu8/c2
         Mpb9NItqn53jzxnxSCntZc/4je/RmzBnbYlvlvw36R4vMDVLq3tjePljJnSrhqSs+G/e
         wongUn/R/zbO1AVIn2ZErsvnRRWfKspxnvid0OnEPBfmfVNRiJEmz6gmd041u5zOEeEo
         eSjg==
X-Gm-Message-State: AOAM531zQkovcuHVzLUznr9aASYvspvJKewWf2ingudbFttKFKSqw7RL
        Ovc8ceIKVUMTXS/SdMYYUN3F0ps95uxGew==
X-Google-Smtp-Source: ABdhPJx7krLnsVhMhPmRUOGulF1eG4p3sjyJNCKFXheqpUr0sS/Tcp8VCLW3bIDkXXZgtWBQpcCDw4aBvBJ4pg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8437:70f3:c03b:1c71])
 (user=mmandlik job=sendgmr) by 2002:aa7:99cf:0:b0:49f:9d3c:ac0f with SMTP id
 v15-20020aa799cf000000b0049f9d3cac0fmr73053611pfi.39.1637422196566; Sat, 20
 Nov 2021 07:29:56 -0800 (PST)
Date:   Sat, 20 Nov 2021 07:29:37 -0800
In-Reply-To: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211120072449.BlueZ.v6.2.Ied4afb8c4c882e573f4a23670fc060cbc3e319c9@changeid>
Mime-Version: 1.0
References: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [BlueZ PATCH v6 2/6] lib: Add definitions of the Adv Monitor Device
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

(no changes since v5)

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
2.34.0.rc2.393.gf8c9666880-goog

