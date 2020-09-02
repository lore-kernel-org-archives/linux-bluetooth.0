Return-Path: <SRS0=7X4B=CL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C19C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 11:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A6F20FC3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 11:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599044669;
	bh=NXgeav573xoVWsJ9e7SLPQ8svoQ2BcSre88zTAW0a84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yUYEFusRxOmp75iuR8I6ac8BEhOeRxztZ1kfiDK3MDQDLTguZ8uFCfAN63AWOoY+0
	 FLv/qjIAMEQS2LM+Ymzt+Tg6ROgxqxwpgwt5cWGBZNkIhAptVm7FMVuqJH58VCUug/
	 Cf7+tyN4a/LyXNT69ReoKe9HjZnGwsSkwHTfOms8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgIBLD3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgIBLBP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Sep 2020 07:01:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621652098B;
        Wed,  2 Sep 2020 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599044475;
        bh=NXgeav573xoVWsJ9e7SLPQ8svoQ2BcSre88zTAW0a84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LN8KTAvshdpXMQxfJz2GAfxA34G5mquJQFmkcoLMqumsTybBV/KzvVmSQj8cEnAPq
         5wxM7bZYVIexRH0dBH6DP/uU5J+0naKKCegjXSjrYLmO3nl0dW8OvKbpcZSacQwlzS
         MtAidBU3SMfrFtUFmUTkntIy31bd96kWh9SGToEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 03/10] USB: core: message.c: use usb_control_msg_send() in a few places
Date:   Wed,  2 Sep 2020 13:01:05 +0200
Message-Id: <20200902110115.1994491-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are a few calls to usb_control_msg() that can be converted to use
usb_control_msg_send() instead, so do that in order to make the error
checking a bit simpler.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/message.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 6aa49b237717..dfd079485c76 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1081,7 +1081,7 @@ int usb_set_isoch_delay(struct usb_device *dev)
 	if (dev->speed < USB_SPEED_SUPER)
 		return 0;
 
-	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+	return usb_control_msg_send(dev, 0,
 			USB_REQ_SET_ISOCH_DELAY,
 			USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
 			dev->hub_delay, 0, NULL, 0,
@@ -1203,13 +1203,13 @@ int usb_clear_halt(struct usb_device *dev, int pipe)
 	 * (like some ibmcam model 1 units) seem to expect hosts to make
 	 * this request for iso endpoints, which can't halt!
 	 */
-	result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-		USB_REQ_CLEAR_FEATURE, USB_RECIP_ENDPOINT,
-		USB_ENDPOINT_HALT, endp, NULL, 0,
-		USB_CTRL_SET_TIMEOUT);
+	result = usb_control_msg_send(dev, 0,
+				      USB_REQ_CLEAR_FEATURE, USB_RECIP_ENDPOINT,
+				      USB_ENDPOINT_HALT, endp, NULL, 0,
+				      USB_CTRL_SET_TIMEOUT);
 
 	/* don't un-halt or force to DATA0 except on success */
-	if (result < 0)
+	if (result)
 		return result;
 
 	/* NOTE:  seems like Microsoft and Apple don't bother verifying
@@ -1558,9 +1558,10 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
 	if (dev->quirks & USB_QUIRK_NO_SET_INTF)
 		ret = -EPIPE;
 	else
-		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-				   USB_REQ_SET_INTERFACE, USB_RECIP_INTERFACE,
-				   alternate, interface, NULL, 0, 5000);
+		ret = usb_control_msg_send(dev, 0,
+					   USB_REQ_SET_INTERFACE,
+					   USB_RECIP_INTERFACE, alternate,
+					   interface, NULL, 0, 5000);
 
 	/* 9.4.10 says devices don't need this and are free to STALL the
 	 * request if the interface only has one alternate setting.
@@ -1570,7 +1571,7 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
 			"manual set_interface for iface %d, alt %d\n",
 			interface, alternate);
 		manual = 1;
-	} else if (ret < 0) {
+	} else if (ret) {
 		/* Re-instate the old alt setting */
 		usb_hcd_alloc_bandwidth(dev, NULL, alt, iface->cur_altsetting);
 		usb_enable_lpm(dev);
@@ -1718,11 +1719,10 @@ int usb_reset_configuration(struct usb_device *dev)
 		mutex_unlock(hcd->bandwidth_mutex);
 		return retval;
 	}
-	retval = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-			USB_REQ_SET_CONFIGURATION, 0,
-			config->desc.bConfigurationValue, 0,
-			NULL, 0, USB_CTRL_SET_TIMEOUT);
-	if (retval < 0)
+	retval = usb_control_msg_send(dev, 0, USB_REQ_SET_CONFIGURATION, 0,
+				      config->desc.bConfigurationValue, 0,
+				      NULL, 0, USB_CTRL_SET_TIMEOUT);
+	if (retval)
 		goto reset_old_alts;
 	mutex_unlock(hcd->bandwidth_mutex);
 
@@ -2103,10 +2103,10 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	}
 	kfree(new_interfaces);
 
-	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-			      USB_REQ_SET_CONFIGURATION, 0, configuration, 0,
-			      NULL, 0, USB_CTRL_SET_TIMEOUT);
-	if (ret < 0 && cp) {
+	ret = usb_control_msg_send(dev, 0, USB_REQ_SET_CONFIGURATION, 0,
+				   configuration, 0, NULL, 0,
+				   USB_CTRL_SET_TIMEOUT);
+	if (ret && cp) {
 		/*
 		 * All the old state is gone, so what else can we do?
 		 * The device is probably useless now anyway.
-- 
2.28.0

