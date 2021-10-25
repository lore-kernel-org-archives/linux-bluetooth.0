Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC797C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BB0604AC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 19:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhJYT3Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhJYT1A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 15:27:00 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E39C043183
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g18-20020a631112000000b00299f5f53824so6817281pgl.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2O13I+eCaUQoEjOsTHL0aOiW+ClxYsgJIdDs3MHPtIs=;
        b=DR0eTKRNcGfnz3qorL/3gXAzhdxRO9axeVLJ2sXd46sR1j6BYZ30dhxxzTASm7RCps
         ZSEKImJZeCrNshcWtNT3y/MvEzy8NewVyLUX2eY5vgkuItU89E8uaV6FaeCfuXwA4UQt
         0R9gJal6dvKUTzcOHi/Ps4qNrfNeoxye6q6NAnOGBmBnXl+5VV8u8eLXmik3akIJWu88
         5SqdWLf4758MbqTI3F/1QHnz4tOicB67BQAu8RwDEIS4Ya7pNduUKkFV3Wd+SSRCmm1r
         stEVTNyTrj/fc6BpG6sNQTD6c4P/dnZktldN8RadW6BAQ4NgUWPNto3i9lWT/gXc29Ue
         iuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2O13I+eCaUQoEjOsTHL0aOiW+ClxYsgJIdDs3MHPtIs=;
        b=3yxqbf6ucarj40MkMG61NjoeOh94A0sBdIP/NduXqYvNBokfKTw//M5cnIl9i63//r
         knOYqrrxJpSOEKOwfNSoP8+6sSLxg0yJm+Z1/OE4pRVlL1Kx4exp1Wy6WuL2Ue76Ixz3
         E75iaruzTNYPXwkEhiVk6tq9KwPpnaje3/Qd2R367RsOPogd0eQJdu3ZHrLEN2b2qaQX
         qc709c/0nI7hV7IJU4o9yk4bDL99ZidwQ/w/Kauo2AITqJGxU90UUEE004zXnjslVU3v
         EzGlsp7lwXGiLutP5k2XUCgO8e/dvhE13E7c5B7AEqwGxQvpQuRPKZFwf8QtO6/YCtOn
         EfkA==
X-Gm-Message-State: AOAM531SRycuuRZsE7bOuyZHuU/D50Uw14kdzn1EeOZBce6Y4PsXySQC
        8a3kX1gWRT9TindXzPdfy7c0sMAanfs2WQ==
X-Google-Smtp-Source: ABdhPJwaAfmX44YNKzsczCJuPcv8lIPKyf6z1nmdLOAveaXh/Npq/gh6o7ehynyBIQKn1sEyRnxm5Xst22HcFA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e7c3:c740:ce43:5358])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:644d:: with SMTP id
 y13mr23129735pjm.10.1635189514013; Mon, 25 Oct 2021 12:18:34 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:18:10 -0700
In-Reply-To: <20211025191811.3575708-1-mmandlik@google.com>
Message-Id: <20211025121343.BlueZ.v4.2.Ied4afb8c4c882e573f4a23670fc060cbc3e319c9@changeid>
Mime-Version: 1.0
References: <20211025191811.3575708-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [BlueZ PATCH v4 2/3] lib: Add definitions of the Adv Monitor Device
 Found/Lost events
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds definitions of the new Advertisement Monitor Device
Found and Device Lost events to indicate that the controller has
started/stopped tracking a particular device.

---

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

 lib/mgmt.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0a6349321..50519c065 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1014,6 +1014,18 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_ADV_MONITOR_DEVICE_FOUND	0x002f
+struct mgmt_ev_adv_monitor_device_found {
+	uint16_t monitor_handle;
+	struct mgmt_addr_info addr;
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
@@ -1152,6 +1164,8 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Removed",
 	"Controller Suspend",
 	"Controller Resume",
+	"Advertisement Monitor Device Found",		/* 0x002f */
+	"Advertisement Monitor Device Lost",
 };
 
 static const char *mgmt_status[] = {
-- 
2.33.0.1079.g6e70778dc9-goog

