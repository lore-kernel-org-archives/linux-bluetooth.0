Return-Path: <SRS0=tE/w=AI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88C0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Jun 2020 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C624D20E65
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Jun 2020 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oA98iK/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgF0Pyy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0Pyy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Jun 2020 11:54:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4F7C061794
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2020 08:54:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a205so3153007ybg.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2020 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wwG49oJv2E9BC5IPEBRunn0tfdHVNFwxaCLCJalnlu0=;
        b=oA98iK/cnjfUWSHeRPIT9n09/GF3uH7/r4/RHDYchP1J7klf/fGY/BtEzGrrY8lbh6
         XMTpb29/g4Ih0H0k8IyfVX3bjdYmIAvyM+a3ESUy/mTQ+AvyERGN8xCB1j11eadgFLik
         hXs+bPhgdT64ucGb084G7mv4gcuJV6Ek3TKjEf5Ace62B/rA6OtN+cZ6sslB04lkcD9y
         i7M9Wuc8akRF/O3NOayNRyejHdU4FzFtrU82wf/KOpH6+6HC5B2VRuy2EzHSMTMeSdHo
         8WGk0vB5C81vgyYmlX855rJjUbJaPSE3S1uZ/lJp/2WkbgUYO4aTMdKKGm6BIs38vM9O
         8OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wwG49oJv2E9BC5IPEBRunn0tfdHVNFwxaCLCJalnlu0=;
        b=rPtFp1rxMdM9C0AvNOzW6fxJDZbtnYdM16plVvbY8+QDG/nHNwkjVHbzHam88jw73O
         2+lTm/Aw+UoKsppDUxt8AiOxRIZ51H+iWA4K7aK6CtPvlneR3VpSiopY74eiZSV5n/+3
         8d+N23rgfwTJL0KIkCiGmrYMFwMCnW0FPShxalDuf8g9TvT3bwg8vWlhuj8EhtXrJUgn
         QViDYMjn6UwwCyRa6b5gjq18i9lgxt85AJTgYJXA2YypIcdZlIoU/R/1SIjDxpBbWuvN
         awWI3U3DvJbWGoPArpnqo8k1zuNRG06Q2DcJARZv18F4T5piCy27gH2QG4DPLDX89wbD
         GX5w==
X-Gm-Message-State: AOAM530NX6to9h4ZD6/4XF7INb//7+dI03HN41ADVgG2IU7jV61ECHxC
        msfC8K7gfiF/V4Pjf7bjPlDo1fcGIw29nraH1Whs+mTrs6ZNMB1QivCvC8Up45oM64LfYgr7Y2L
        lItF/4BqVUZc2XyGoH24kvA8VZ1v9z09Lbnqr4unpI2KICJK1ZWkFtl6LhvFnETYO4eFLJyqMB3
        D6
X-Google-Smtp-Source: ABdhPJwqiCiCVoox+4PONZzMiPvhaXnDrxBouPifbpgtxfWgidb48v9iGGEhm4LIZRLImtBJSGVuRcMcSLP9
X-Received: by 2002:a5b:58e:: with SMTP id l14mr14229642ybp.352.1593273293026;
 Sat, 27 Jun 2020 08:54:53 -0700 (PDT)
Date:   Sat, 27 Jun 2020 23:54:08 +0800
In-Reply-To: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
Message-Id: <20200627235318.Bluez.v2.2.I16f38fd33617bbbf84d144605861b8391605a761@changeid>
Mime-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [Bluez PATCH v2 2/2] input: Remove bonding info when receiving
 virtual cable unplug
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

From Bluetooth HID Profile 1.1 Spec: If a Virtual Cable is
unplugged via a HID control Virtual Unplug command, then both the
Bluetooth HID device and Bluetooth HID Host shall destroy or
invalidate all Bluetooth bonding and Virtual Cable information
that was previously stored in persistent memory for the respective
Virtually Cabled devices and hosts.

This patch removes the bonding information upon receiving and/or
sending a "virtual cable unplug".

Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2:
- Properly pass the correct argument to device_remove_bonding
- rename unbond_on_disconnect to virtual_cable_unplug

 profiles/input/device.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d3724ed54..a76ab90bd 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -88,6 +88,7 @@ struct input_device {
 	uint8_t			report_req_pending;
 	guint			report_req_timer;
 	uint32_t		report_rsp_id;
+	bool			virtual_cable_unplug;
 };
 
 static int idle_timeout = 0;
@@ -148,6 +149,14 @@ static void input_device_free(struct input_device *idev)
 	g_free(idev);
 }
 
+static void virtual_cable_unplug(struct input_device *idev)
+{
+	device_remove_bonding(idev->device,
+				btd_device_get_bdaddr_type(idev->device));
+
+	idev->virtual_cable_unplug = false;
+}
+
 static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 					const uint8_t *data, size_t size)
 {
@@ -188,6 +197,9 @@ static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
 					const uint8_t *data, size_t size)
 {
+	if (hdr == (HIDP_TRANS_HID_CONTROL | HIDP_CTRL_VIRTUAL_CABLE_UNPLUG))
+		idev->virtual_cable_unplug = true;
+
 	return hidp_send_message(idev->ctrl_io, hdr, data, size);
 }
 
@@ -344,6 +356,9 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	/* Enter the auto-reconnect mode if needed */
 	input_device_enter_reconnect_mode(idev);
 
+	if (!idev->ctrl_io && idev->virtual_cable_unplug)
+		virtual_cable_unplug(idev);
+
 	return FALSE;
 }
 
@@ -408,7 +423,7 @@ static void hidp_recv_ctrl_hid_control(struct input_device *idev, uint8_t param)
 	DBG("");
 
 	if (param == HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
-		connection_disconnect(idev, 0);
+		connection_disconnect(idev, (1 << HIDP_VIRTUAL_CABLE_UNPLUG));
 }
 
 static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
@@ -532,6 +547,9 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if (idev->intr_io && !(cond & G_IO_NVAL))
 		g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
 
+	if (!idev->intr_io && idev->virtual_cable_unplug)
+		virtual_cable_unplug(idev);
+
 	return FALSE;
 }
 
@@ -1042,6 +1060,9 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 		shutdown(sock, SHUT_WR);
 	}
 
+	if (flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG))
+		idev->virtual_cable_unplug = true;
+
 	if (idev->uhid)
 		return 0;
 	else
-- 
2.27.0.212.ge8ba1cc988-goog

