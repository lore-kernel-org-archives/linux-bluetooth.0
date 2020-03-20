Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AFCC4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5577220753
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i2YOhPJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCTBu3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:50:29 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:55691 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCTBu2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Mar 2020 21:50:28 -0400
Received: by mail-pj1-f52.google.com with SMTP id mj6so1796150pjb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2020 18:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=beFEUX3MbwzmugTexHZnvU+XdMz+mzb4XXeBdaJB39E=;
        b=i2YOhPJE9siKggAcr8H/1YLv79EjoGFtKimBVMVU5pcwCRY0FfFer/syc8FaPfFeKt
         k6HEydiXK546y8MVTlc5MUT+Ftgwgao6jdrzCSS2ySALPceUi297P71sMJn7z1XgCXus
         EP/34Kg3hJEJFlQZh2fA/dM3Z59Ottf6JS2bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beFEUX3MbwzmugTexHZnvU+XdMz+mzb4XXeBdaJB39E=;
        b=kzF9oGuZMsGBH6WZBqxByboCU2/Db9BwSeGvNX396EeGN3xl97LVK11QMj1iahOIDW
         a37XtDB5MKkD5Xp081EP9wd7aEStIM2rEfhg48EMqciKfP5321TBTpVI5vMzMkI2XUYO
         2ABjAq+5X4BvjfDLkJAFJBG3m3Rkh7cidVjU5j7vi1OVhfKMcT4WcEMYLZ1GGgoyH0Dy
         ITJuSXYh0manxdZkUMHYx4f4FkO5eTbT9ZV9TV5/tCv3JjIIfxYY4UPHXGO1zl/3zC9f
         hspeA3NlQI6uvNFpgSWoXiNR/BvL+jrXewpdhFnNzYdCeEoDT40pyWpOeGATJkOkoC/5
         fJXw==
X-Gm-Message-State: ANhLgQ3O15uAVWK0VDhnNCoxsF8mCWS3mHcY8C8zDvULXiY8E11cE5ui
        Te/FcblD+888KjFqdvV80MjYjQ==
X-Google-Smtp-Source: ADFU+vuptLAbbOOy412Rjt5M7K9ka9p68WOlJUv/lr8XjSlX8+06myWP206zd+jhFGSzAPfDhgmLAA==
X-Received: by 2002:a17:902:7c8e:: with SMTP id y14mr5881754pll.139.1584669027543;
        Thu, 19 Mar 2020 18:50:27 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 136sm3410485pgh.26.2020.03.19.18.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:50:27 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 1/5] mgmt: Update docs for Add Device
Date:   Thu, 19 Mar 2020 18:50:19 -0700
Message-Id: <20200319185000.BlueZ.v4.1.Idb4f0444e40064a861ee73b098264abd30114aaa@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320015023.85896-1-abhishekpandit@chromium.org>
References: <20200320015023.85896-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update the docs for Add Device with information on flags mask and value.
Add information on the Wakeable flag that can be set to allow the device
to wake the system from suspend.
---

Changes in v4:
* Newly added support in Add Device for flags

Changes in v3: None
Changes in v2: None

 doc/mgmt-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 27a41f334..e99c23710 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1997,6 +1997,8 @@ Add Device Command
 	Command Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 				Action (1 Octet)
+				Flags Mask (1 Octet)
+				Flags Value (1 Octet)
 	Return Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 
@@ -2014,6 +2016,9 @@ Add Device Command
 		1	Allow incoming connection
 		2	Auto-connect remote device
 
+	The following flags are supported:
+		0x1	Wakeable
+
 	With the Action 0, when the device is found, a new Device Found
 	event will be sent indicating this device is available. This
 	action is only valid for LE Public and LE Random address types.
@@ -2036,6 +2041,13 @@ Add Device Command
 	connectable setting is off. This acts as list of known trusted
 	devices.
 
+	To set flags on the device, first set the bit in the mask for the
+	flag to set and then set or clear the bit in the value to indicate
+	whether the flag should be set.
+
+	The Wakeable flag controls whether this device can wake the system
+	from suspend.
+
 	This command can be used when the controller is not powered and
 	all settings will be programmed once powered.
 
-- 
2.25.1.696.g5e7596f4ac-goog

