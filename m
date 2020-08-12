Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E58AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 04:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A76206C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 04:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c64mJIYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgHLEVO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgHLEVO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 00:21:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC828C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 21:21:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id q19so785542qtp.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+D4+SojV3Y/sxfWJh2lOz+64TmUygXb7unMVRm5nVlg=;
        b=c64mJIYEdJS1vHCGKh56UAFMxMmAInNMzJQy6xeVJP1jnnG+ZcIgxRgocKAX5ia6cp
         4yMd5nRQFOO5g89miBJz6K2FpthVzGgYiZNhqiakXmW8S4+YinzG7hlAE41vRzQ58bbm
         05eKUcNvALyZbbk7bbluQbBMcIhzYmNTPPzEgSPSkqBC9NyrItphHDKq8gdONP1qWQMp
         T9nvx98/m5fOkMW3N5cF8iaOZAXF5gUdLEKoTwCXW/EmDdP1WBBARDsPZ/OwovhF0yxr
         uN2k4/eEZgmMqLDtnV89hEJJuyGWMrHs3m2D0uA/2wtpxm6YqZOMBGC2LuHxhtWK9Gky
         4/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+D4+SojV3Y/sxfWJh2lOz+64TmUygXb7unMVRm5nVlg=;
        b=ofLSSXjYMRzEImFK5GdBtOJixCUbcn8v6c+DG7o2Fi09dE09NZmEkV4TSO4CwUH2K4
         MDiDDOZ90f3eGy36MpC9SX7LlNyQuFUXC/d820OmIz1vo2pBFIfVOcGdYnfGvX/9IjLC
         TLWv9AaenM3cFR4cx4j0v7UJWweOnAVkuti3FOYo/GpmdDN25qKp47/l7RfwEYTYKaNE
         WLnoSLDAqYbPTbii6UW+JyrF7KSqdLV1rLA+tBpuo/A1rbN7Sk7llnbQEuJq36JgsTD7
         +cj21qam+WhdT9I65VRBejvT5xs4ryZG3YFT4ern/Z2if4Z2yItZT/IvyCSVR47I6cTM
         i7NQ==
X-Gm-Message-State: AOAM532uHSugMHXgi0AMdQxtXtk2SV+aC3IhLlGL3WAi/WQlT7ZDe3UO
        fBggwyFGZ0El9Yrr2HDsTuf3QbPn5il+OjtJowDoG0na6CsEa5fDL77g61YyoP1e1YpTrZMqYcA
        ft0E31ojxwb6wAnvLUWUGI/628Y34BMXb2GLOK+eHqtIWDYYe0IVjRlonCtyvMVZTqSY57HQCf+
        qg
X-Google-Smtp-Source: ABdhPJw0XULDvdLIOteN/Ki85Ly6P10QFgsxdTVoKyCUAzaA3gGP0W7kMlPaV7w9+BOnPdSZ7KrYwcrZsPXw
X-Received: by 2002:ad4:462f:: with SMTP id x15mr4837625qvv.180.1597206072767;
 Tue, 11 Aug 2020 21:21:12 -0700 (PDT)
Date:   Wed, 12 Aug 2020 12:20:52 +0800
Message-Id: <20200812121946.Bluez.v1.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [Bluez PATCH v1] input: Don't browse SDP if HIDSDPDisable is set
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to the HID1.1 spec, part 5.3.4.9:
The HIDSDPDisable attribute is a Boolean value, which indicates
whether connection to the SDP channel and Control or Interrupt
channels are mutually exclusive. This feature supports Bluetooth
HID devices that have minimal resources, and multiplex those
resources between servicing the initialization (SDP) and runtime
(Control and Interrupt) channels.

However, Bluez still tries to connect SDP upon HID connection,
regardless of the existence of the HIDSDPDisable attribute.

This patch prevents the connection of SDP after HID has been
established, if the device has HIDSDPDisable attribute.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 profiles/input/device.c | 2 ++
 src/device.c            | 8 +++++++-
 src/device.h            | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6ec0a4c63..fac8c6896 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1373,6 +1373,8 @@ static struct input_device *input_device_new(struct btd_service *service)
 	/* Initialize device properties */
 	extract_hid_props(idev, rec);
 
+	device_set_skip_passive_sdp_discovery(device, idev->disable_sdp);
+
 	return idev;
 }
 
diff --git a/src/device.c b/src/device.c
index 2237a7670..a67787a2d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -195,6 +195,7 @@ struct btd_device {
 	bool		le;
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
+	bool		skip_passive_sdp_discovery;
 
 	/* Manage whether this device can wake the system from suspend.
 	 * - wake_support: Requires a profile that supports wake (i.e. HID)
@@ -1472,6 +1473,10 @@ static gboolean dev_property_wake_allowed_exist(
 	return device_get_wake_support(device);
 }
 
+void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip)
+{
+	dev->skip_passive_sdp_discovery = skip;
+}
 
 static gboolean disconnect_all(gpointer user_data)
 {
@@ -1805,7 +1810,8 @@ done:
 				btd_error_failed(dev->connect, strerror(-err)));
 	} else {
 		/* Start passive SDP discovery to update known services */
-		if (dev->bredr && !dev->svc_refreshed)
+		if (dev->bredr && !dev->svc_refreshed &&
+					!dev->skip_passive_sdp_discovery)
 			device_browse_sdp(dev, NULL);
 		g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
 	}
diff --git a/src/device.h b/src/device.h
index cb8d884e8..5348d2652 100644
--- a/src/device.h
+++ b/src/device.h
@@ -145,6 +145,7 @@ void device_set_wake_override(struct btd_device *device, bool wake_override);
 void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
 			     guint32 id);
 void device_set_wake_allowed_complete(struct btd_device *device);
+void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
-- 
2.28.0.236.gb10cc79966-goog

