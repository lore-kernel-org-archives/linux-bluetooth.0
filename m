Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7507C11D2F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE8920866
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GOXmMeo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBXPTm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:19:42 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:34529 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBXPTl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 10:19:41 -0500
Received: by mail-vk1-f176.google.com with SMTP id w67so2597794vkf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUNQi7Tp0OXG0UgDEoF3D0uW4+RHz6SryFuaIlErDNM=;
        b=GOXmMeo62RQenK+Kge7uH8b4YzoEJwtCQvdBMLE5OUIqcaZ2isgejg4EOkaE7XPj6h
         WdfPSxQmP+GEc5INbS/hQSdZt+oBSyX0HR3RUAri298mMl4r79UXKU5Du6pQP5rafCS4
         aXIPcOQoMdLoMBk7Hpa56a0TrgMtyidbjvlQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUNQi7Tp0OXG0UgDEoF3D0uW4+RHz6SryFuaIlErDNM=;
        b=Bzw4h+pEoYzFl+RxF3t63obVTXCFFZJW624d4TDGEclAMrBbR82+xEFI+E87l7b2Vu
         Qifyay+jKIowDvpMEl/MTp2h5WkeEkd+WEdDQu8BPwxSWMy1WaMM6hn/BHlntak4CVqy
         1JpcwHK/ojdjiUTMyI8mlj1wWPrJSd9hz5lOAVOMPyxkTxAbMXsoXpG40NWjvCxJeCL4
         ieT58wLpN3cuCg59vmpU0pHGW1vTSJtlQWra/v82L0XhLl8ivak8mAUkUUSn0jhY+6Ks
         NWC5EUeailYXktK2+fi4TFr1vvAID7Jv8qXMiRZ5+mA1PjQmL7Q1TdaF/8p4Vtu8UWe7
         zYBQ==
X-Gm-Message-State: APjAAAUmwKAPDeqUtdYzG7O3PDUAGy/sjl5/U068+zrL8aUf3yrhIbHf
        R6ce2BnMn6iJS4qvaaxGo3OdaFGhu17ckQ==
X-Google-Smtp-Source: APXvYqx13kvPi7QZVHo03SHsYE6IKEJBfye/RlCqi78HQbo4Uxk+EI2/dKna3HvKOEHiTzVn2BNKUA==
X-Received: by 2002:a1f:604e:: with SMTP id u75mr22717565vkb.78.1582557578943;
        Mon, 24 Feb 2020 07:19:38 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id o132sm3412565vkd.17.2020.02.24.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:19:38 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez-PATCH] Add mgmt interface for Erroneous Data Reporting
Date:   Mon, 24 Feb 2020 15:19:35 +0000
Message-Id: <20200224151935.169330-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the MGMT definition to support Errorneout Data
Reporting.  This allows higher level application to query and set the
Erroneous data reporting feature of the controller.  In particular, this
can be used by an audio subsystem to support wideband speech.

---

 doc/mgmt-api.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1e59acc54..953c2793d 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -307,6 +307,7 @@ Read Controller Information Command
 		13	Privacy
 		14	Controller Configuration
 		15	Static Address
+		16	Erroneous Data Reporting
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -3048,6 +3049,26 @@ Load Blocked Keys Command
 				Invalid Index
 
 
+Set Erroneous Data Reporting Command
+=======================
+
+	Command Code:		0x0047
+	Controller Index:	<controller id>
+	Command Parameters:	ErroneousDataReporting (1 Octet)
+	Return Parameters:
+
+	This command is used to set the Erroneous Data Reporting property of
+	a controller. The allowed Connectable command parameter values are
+	0x00 and 0x01. All other values will return Invalid Parameters.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
 Command Complete Event
 ======================
 
-- 
2.25.0.265.gbab2e86ba0-goog

