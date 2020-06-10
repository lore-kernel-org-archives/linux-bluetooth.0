Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E9DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED322078C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxPB1aXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgFJPGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJPGJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 11:06:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E310C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:06:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p22so2424305ybg.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ytCJjlQonwgpmtQxsMptExchNW5WfYR+Wur9JMGT4ts=;
        b=OxPB1aXFJ3JX5/JjHR6obEQrCdw9SFVl75XDL/LfGPo+eaza1HUoMN1qpPQaeb0e1s
         pkhaGPSbl8i/PI9OQt7xVIS96sI6jbDu0daPYsQZzyv1zXPmpcDIIIGd//SGfAE07cOt
         PRPfqPN2MgKA71SdCkwR0dUqqCVSy62kOjHRz+9sv7k+uLAlohcpaoWq+GalzvQgf0MH
         Hwvk4w8CpETzbvrh2KhLDz3J+ZpZr+xAhzZmjReRPe0IRsDAU9zyfRc7hIkE3XR4ANW5
         gekZ5eMXYH3Fy9PPRfSDGTgKAh0Il7lXOBomuWWwpA+WJExj6o/k8Zi7dSriZujBKaAR
         E+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ytCJjlQonwgpmtQxsMptExchNW5WfYR+Wur9JMGT4ts=;
        b=mghhIqYhHaWL/sbDYCdrSdGWzEf2b8BltHMvqPCt1ytXSD96+386jFQ32Dx8kOj4w5
         UrN/mBfgg55KkLQnVmyfrXJIJn2Si/XSdYXycmlildKki3hreo8a8pdVoWuPep45pXuL
         BXwaOYN6090L83QhrhDLkZUvqUv0nn8p8l9KdabdPSEL61REVVvV+r/0nYWD2MHF1jv7
         2EPSXArf5dS1ll52cNhJDPXcxhKlMo0MlPxtHleiVVk5S6lZkr/bHMxy5x4Vh+jXCV1N
         EXcrR2AFOu3kulgt16BXqewM+SvNgtl+OvAUjmh5LRKpvALhcq0WOACficMwHm3+93G8
         bFKQ==
X-Gm-Message-State: AOAM531iH9VLSEP798BVUgNnDnNsNkF05n1U5w0GuvU4tLBkSksIsHGt
        zw1RN0wJh/U70AxC7keTXZ/z4FVNXdU0vOsxcL19tucQ2p1rTnArEyKToV4sgTVsOOmWl73nhKs
        EcvIMo/kB+a/2/nHptq/sE9uAexKE79FKJPlDMTAMRFTK+1xeFBKU2rcGXgoPP6pbq3wywZD36M
        B3
X-Google-Smtp-Source: ABdhPJxKKFSSyKoPkkA6IWiM8I7Bn+urZLgFaW9REsaG1+Wrhe31D9ibJQAQ5zXaTSCzM865LECSWkv5tkii
X-Received: by 2002:a25:80c3:: with SMTP id c3mr6970636ybm.33.1591801568483;
 Wed, 10 Jun 2020 08:06:08 -0700 (PDT)
Date:   Wed, 10 Jun 2020 23:05:45 +0800
In-Reply-To: <20200610230524.Bluez.v1.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
Message-Id: <20200610230524.Bluez.v1.2.I16f38fd33617bbbf84d144605861b8391605a761@changeid>
Mime-Version: 1.0
References: <20200610230524.Bluez.v1.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [Bluez PATCH v1 2/2] input: Remove bonding info when receiving
 virtual cable unplug
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
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
---

 profiles/input/device.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d89da2d7c..45d86b6cb 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -88,6 +88,7 @@ struct input_device {
 	uint8_t			report_req_pending;
 	guint			report_req_timer;
 	uint32_t		report_rsp_id;
+	bool			unbond_on_disconnect;
 };
 
 static int idle_timeout = 0;
@@ -148,6 +149,14 @@ static void input_device_free(struct input_device *idev)
 	g_free(idev);
 }
 
+static void invalidate_bonding(struct input_device *idev)
+{
+	device_remove_bonding(device_get_adapter(idev->device),
+				btd_device_get_bdaddr_type(idev->device));
+
+	idev->unbond_on_disconnect = false;
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
+		idev->unbond_on_disconnect = true;
+
 	return hidp_send_message(idev->ctrl_io, hdr, data, size);
 }
 
@@ -342,6 +354,9 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	/* Enter the auto-reconnect mode if needed */
 	input_device_enter_reconnect_mode(idev);
 
+	if (!idev->ctrl_io && idev->unbond_on_disconnect)
+		invalidate_bonding(idev);
+
 	return FALSE;
 }
 
@@ -406,7 +421,7 @@ static void hidp_recv_ctrl_hid_control(struct input_device *idev, uint8_t param)
 	DBG("");
 
 	if (param == HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
-		connection_disconnect(idev, 0);
+		connection_disconnect(idev, (1 << HIDP_VIRTUAL_CABLE_UNPLUG));
 }
 
 static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
@@ -530,6 +545,9 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 	if (idev->intr_io && !(cond & G_IO_NVAL))
 		g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
 
+	if (!idev->intr_io && idev->unbond_on_disconnect)
+		invalidate_bonding(idev);
+
 	return FALSE;
 }
 
@@ -1035,6 +1053,9 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 	if (idev->ctrl_io)
 		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
 
+	if (flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG))
+		idev->unbond_on_disconnect = true;
+
 	if (idev->uhid)
 		return 0;
 	else
-- 
2.27.0.278.ge193c7cf3a9-goog

