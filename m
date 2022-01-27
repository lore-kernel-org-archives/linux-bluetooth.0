Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEF0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 10:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiA0KQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiA0KQ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 05:16:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3636C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 02:16:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so7105010pju.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bct+9uJXCp9AR4JZv//NgLkcqYHpNSr+0PKnUweua4g=;
        b=IINhtUv7Q56jAtl+GQEZujoNP1Y2erydYgb82WDuNCXEPQdgihxzmv59XWG2cFS9+P
         sxwEZiGibV2ZADw2teYh03HSSpGWfiX2NwL52/mG0IhRQ5/fbwJymIe8Hkj4nIPprDRY
         a72eZhA3qLyJKpFNCzy5IP8dq4TpdHT52DVcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bct+9uJXCp9AR4JZv//NgLkcqYHpNSr+0PKnUweua4g=;
        b=oDhnwrVdrj2KbCW7Z6VJGpVfoIsrpe6sacre3sSlVDnCNYWiBzjpfn2v4P6yb/k69L
         wYefgH9+DtHxQxDmjjzs6zPOJo+Z31ws19Pxw73Y2UIqvXwHv2b+LECtNZ0x0LtXkXYr
         WS+zts7He6I548UKgUT4bLaj5vJ/mkh7PU042SBBZU38EPCRD0Mfs1vC+DU5oNOSPI/I
         7llheIssZi4zfaUM4+9dQurOsbUZlDA6rv+DNIbX+O6KPPZVvo3oGbppKntumQgcvklP
         EvW8VJeCP7Z0qeTB22Kb1bDujpKYyTERJpXz/kVoFtwCmN27OgK338hXroaqOfCiuxmU
         LQHw==
X-Gm-Message-State: AOAM532aerIeqbYSSA+t/UYat4b1aiwV9o/7HvljiE5Yp+WvOIVGyVrz
        3q42uGawHwmUUOP+wHyvD4FMs7g/xFj4MQ==
X-Google-Smtp-Source: ABdhPJzII5yJLLnhrZ+KJTxEjiSJ6gell3puHJ3wSI85bggW5uopoayP+JgCq7omgbP6dvBeiZewlw==
X-Received: by 2002:a17:90b:1c89:: with SMTP id oo9mr3464302pjb.146.1643278585094;
        Thu, 27 Jan 2022 02:16:25 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id h6sm5192692pfc.35.2022.01.27.02.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:16:24 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v2 1/4] doc: Add Bluetooth quality report event
Date:   Thu, 27 Jan 2022 18:16:06 +0800
Message-Id: <20220127101609.3646316-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the Bluetooth quality report event in doc/mgmt-api.txt.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v2:
- This is a new patch for adding the event in doc/mgmt-api.txt

 doc/mgmt-api.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4..a0e71a732 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4978,3 +4978,23 @@ Advertisement Monitor Device Lost Event
 		2	LE Random
 
 	This event will be sent to all management sockets.
+
+
+Bluetooth Quality Report Event
+==============================
+
+	Event code:		0x0031
+	Controller Index:	<controller_id>
+	Event Parameters:	Quality_Spec (1 Octet)
+				Report_Len (2 Octets)
+				Report (0-65535 Octets)
+
+	This event carries the Bluetooth quality report sent by the
+	controller.
+
+	Possible values for the Quality_Spec parameter:
+		0	Not Available
+		1	Intel Telemetry Event
+		2	AOSP Bluetooth Quality Report Event
+
+	This event will be sent to all management sockets.
-- 
2.35.0.rc0.227.g00780c9af4-goog

