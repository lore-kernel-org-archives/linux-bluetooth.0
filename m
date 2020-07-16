Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09863C433E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D8220787
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 18:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkJS67oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgGPSEy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPSEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 14:04:54 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4494C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 11:04:53 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g16so5951328pjz.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=84ZnAl+Wl+nXgilPdMEdlwfyHxKc0sYcqxvvPLTxkKI=;
        b=RkJS67oZofXZ9bsHQs5EB5JBDC+D8Sm5WsrUL3WDnWovcsSdsNmH8lTqd2fq+XRigw
         pjBEVYFgZiC809mxuJoF24Bu676nvi3QhQzZQaz3BRppP/YfU15Xm+BHgNwB2t4Uu8Yb
         mdQc96JQTBR0UaQVu+PF8Lo0k51EzP/kFf0QjnNyvq2M7OW9w3eKsms7epj+j8zZLDCL
         +4/5H810nHpwDfHOugXPaZiDZMq1ydFJ7+fDCJto0G/xULiAHmMH+BDQZTPT+hWmdUoR
         ojUJfDAWFWXSn7jAlYOfpz6SP0+DdNuRI2PMfaW4cHE5M4blr+U8TD+luWDwNjxK0KNg
         vRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=84ZnAl+Wl+nXgilPdMEdlwfyHxKc0sYcqxvvPLTxkKI=;
        b=uA6DIo5X1/nR4xhaQ8fBIQqvdOGEyz4RAKvygfXALdWN2KktNQyWgxJo02oei58b7n
         qpp1LXr/LQsq0kRSLH4zJuk7WSspx+dvfq1+nrovlHglgCAm8pLoH+2uIdacdoreV0zw
         86UO6QbpSGZnNW7dDpNZa/Zrt+TLR2b2Exh6mNsipkoQJFGmGa+64L1SsnMSWQi5f/gy
         fOLULu8ZjiPQxWz2rIM5zN0sx8WQkuDXcXxydimeUI6A7uaw2z9ClGl3xnCKfFipPdat
         GPYomhyfy3qPiRqB1lJAaTUQ5M2yo4f8ETV0jr8+0ggBTy9zylfO7bhqbkoihgK+Cz2q
         2FMA==
X-Gm-Message-State: AOAM533M+O0Q18rnnYN98B2hI1nK0lIRESpaWzqjBGWCPm5X9FgxtFUC
        VUziC+NtVtQvQZc4Rymst2NMbmlNDIpT0hU4iniipv2WTj8h/AJ5uDoJ3YFFB5gV09gkNpChNvE
        Gv08iy1gk0LcwFzZ76mO7cYFGN+RrW8beaiXQ+z8okIU+ggAV9JOnmAGj9tF6JgTpvBdMNnAijv
        uT
X-Google-Smtp-Source: ABdhPJzolNYZetJMgwDncfSJCYlU+EvegYSKOAQHxyBBm9tvK2BKTrGgFczjAaK1Nv+f4P1K4OrUnr47tuDJ
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr6353887pjb.65.1594922693122;
 Thu, 16 Jul 2020 11:04:53 -0700 (PDT)
Date:   Fri, 17 Jul 2020 02:04:33 +0800
In-Reply-To: <20200717020332.Bluez.v3.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
Message-Id: <20200717020332.Bluez.v3.2.I16f38fd33617bbbf84d144605861b8391605a761@changeid>
Mime-Version: 1.0
References: <20200717020332.Bluez.v3.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [Bluez PATCH v3 2/2] input: Remove bonding info when receiving
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

Changes in v3: None
Changes in v2:
- Properly pass the correct argument to device_remove_bonding
- rename unbond_on_disconnect to virtual_cable_unplug

 profiles/input/device.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2dc2ecab2..8e29de391 100644
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
2.27.0.389.gc38d7665816-goog

