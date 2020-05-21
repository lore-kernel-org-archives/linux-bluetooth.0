Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5878AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 14:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347F6207D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 14:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXmqrEVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgEUO6E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgEUO6E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 10:58:04 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114DC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 07:58:04 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id e10so4149781vsp.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2QlpYk/TiknBxPgObZphY5p2POSt/Dzgdqn8mxwS5Y=;
        b=nXmqrEVY8Z8I0VtRTwB2/cYwhG3P1eibGKqToQTLuSXBSA9FoUt+NSyBfi5/3riWn9
         UduxNRjeqmHWc6HeD43xsHD4wYSzYK5cAmjm1JsVDd0j2Hwxouk3eRUGfucAw7OfK8pp
         pNcSSD1g6IaYlKrtEDxkzxWLiuigK4RJQ7BOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2QlpYk/TiknBxPgObZphY5p2POSt/Dzgdqn8mxwS5Y=;
        b=R8yJCpbNEGgEA55jBAf2oDmsV3X2sn7C3/q9y3SHtXhAlKKclTb+HNx7814gKs7Q8r
         AX/BBldEZDHU5GBT9k6zMHqp9HIQcc89oEp2FjE768/pIXSXz2TXmHPLw8+Gl9QRAf+w
         OJYaJJ8bI787TavdvppuGwCm6DoiAFpIyNvBY7iBs2+gYpdyXLuFiwtc4LfU3PmmKjHE
         PGXDF1iXMJswHZTPC2EEJF1M0KS8Y4yJ2GUDMw3u+Xk0I3gT6qPeK01CSTH/+lNXYwJ9
         XEX+05/xYrXB+8dK8E+UBPorwYb6+tlzdbpa5ipbnBpRs9ITRw8zRSLfJ/GBF+0f7Qrp
         LBJQ==
X-Gm-Message-State: AOAM532hFDm9iDu66QOBOgBnb0RgQRQtR05wX6vGlPPrMLVYnzOfBeNy
        74zL36yewXHgCNIyYDYueJL2vlWoZPOK2A==
X-Google-Smtp-Source: ABdhPJwIo9uDx6DJfNiQdEvHqFjOfQMwQrxwCx6UCDvjkPQxvIisSpwC8O3MU3f9DV3sMtOldkysKw==
X-Received: by 2002:a05:6102:3030:: with SMTP id v16mr7294119vsa.177.1590073082631;
        Thu, 21 May 2020 07:58:02 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id o21sm639973uat.8.2020.05.21.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:58:01 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v3] doc:adding definitions for load default params mgmt op
Date:   Thu, 21 May 2020 14:57:57 +0000
Message-Id: <20200521145757.245774-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the definition for the load default parameter command.
In particular, this command is used to load default parameters for
various operations in the kernel. This mechanism is also expandable to
future values that may be necessary.

This will allow bluetoothd to load parameters from a conf file that may
be customized for the specific requirements of each platforms.

---
rebase against current master

 doc/mgmt-api.txt | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 6ee01fed8..c6575e654 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3223,6 +3223,68 @@ Set Experimental Feature Command
 				Invalid Index
 
 
+Load Default Controller Parameter Command
+=============================
+
+	Command Code:		0x004b
+	Controller Index:	<controller id>
+	Command Parameters:	Parameter_Count (2 Octets)
+				Parameter1 {
+					Parameter_Type (2 Octet)
+					Value_Length (1 Octet)
+					Value (0-255 Octets)
+				}
+				Parameter2 { }
+				...
+	Return Parameters:
+
+	This command is used to feed the kernel a list of default controller
+	parameters.
+
+	Currently defined Parameter_Type values are:
+
+		0x0000	BR/EDR Page Scan Type
+		0x0001	BR/EDR Page Scan Interval
+		0x0002	BR/EDR Page Scan Window
+		0x0003	BR/EDR Inquiry Scan Type
+		0x0004	BR/EDR Inquiry Scan Interval
+		0x0005	BR/EDR Inquiry Scan Window
+		0x0006	BR/EDR Link Supervision Timeout
+		0x0007	BR/EDR Page Timeout
+		0x0008	BR/EDR Min Sniff Interval
+		0x0009	BR/EDR Max Sniff Interval
+		0x000a	LE Advertisement Min Interval
+		0x000b	LE Advertisement Max Interval
+		0x000c	LE Multi Advertisement Rotation Interval
+		0x000d	LE Scanning Interval for auto connect
+		0x000e	LE Scanning Window for auto connect
+		0x000f	LE Scanning Interval for HID only
+		0x0010	LE Scanning Window for HID only
+		0x0012	LE Scanning Interval for wake scenarios
+		0x0013	LE Scanning Window for wake scenarios
+		0x0014	LE Scanning Interval for discovery
+		0x0015	LE Scanning Window for discovery
+		0x0016	LE Scanning Interval for adv monitoring
+		0x0017	LE Scanning Window for adv monitoring
+		0x0018	LE Scanning Interval for connect
+		0x0019	LE Scanning Window for connect
+		0x001a	LE Min Connection Interval
+		0x001b	LE Max Connection Interval
+		0x001c	LE Connection Connection Latency
+		0x001d	LE Connection Supervision Timeout
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.  Note that these only
+	control the default parameters.  Higher level Apis may influence the
+	effective value used.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
2.26.2.761.g0e0b3e54be-goog

