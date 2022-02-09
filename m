Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6361DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiBIJZW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:25:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiBIJZV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:25:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9BC1DF807
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:25:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso4623826pjg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj9lmaqr1ILhWR4H8tl30NHz4jXQUSH7MNOMbElh7EM=;
        b=encWBATk5KKsq/cKWCBTkFPSqVC1Fb+cgRI+6kV4gwsQo7wx6ejdekNakqAwZauWKa
         vmZYimM8F7OGgKE3Nu16j2QQVVwxBIbtzA+34DdLtRMGECWySTvfUzQoZJzRDTzdHmVr
         bZNFfhAjlWmrHFb0/kGTcZWyOGIu+o5PZKUbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj9lmaqr1ILhWR4H8tl30NHz4jXQUSH7MNOMbElh7EM=;
        b=zdGsdf6es2fiqCty1FR+yeqfuFbG3lOddFVbo4yjpyKsqr/wSb5VNz7EYB27SLebLK
         2w6B+ouBCSB5VfqnQuj+Mnf7EnnLsQOwllQ7UiRkhjtUc4z+1t/sFu3gq7BuEtW/uZ9q
         z4yGFTww74cI3pUDPjANTEI4IUwc6rRxwWNSg/Nz5vjEMKX5ikZJtO7Zmiz4aNdhgBkg
         TZX5aetOzNF0fqv9Wnzf8A3goxCVC2q41yDcsQIa6Q+NZxotx5JTpg9KMZAZ3AuA/f99
         8/UB995aIVRXaj9YqdID+7LJUvvjIJwC+r1WPWkkK/VYAlbcGGaBzKAlB+i7wr76l9Am
         7hng==
X-Gm-Message-State: AOAM533SXkIV2SlmPF28BFVWg0pAI4JaoG8hP/IeZ9SN4BMxx//7KZQX
        Zy4cudq/78LFc1Zj23sL8IRwGZcB86BWVA==
X-Google-Smtp-Source: ABdhPJzppLhFvM4SIHQmmkdncEDhmQrPI3+e+YEMWuoxtv78d611RlezJc3jJNNgTNuXK/CUd+H6mA==
X-Received: by 2002:a17:90b:4c43:: with SMTP id np3mr2407475pjb.88.1644398661595;
        Wed, 09 Feb 2022 01:24:21 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id q17sm18938271pfu.160.2022.02.09.01.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:24:21 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v3 1/9] doc: Add Bluetooth quality report event
Date:   Wed,  9 Feb 2022 17:24:06 +0800
Message-Id: <20220209092414.751642-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the Bluetooth quality report event in doc/mgmt-api.txt.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- Swap AOSP Bluetooth Quality Report Event and Intel Telemetry Event.
- Add 5 new patches (5/9 - 9/9) to enable the quality report
  feature via MGMT_OP_SET_QUALITY_REPORT instead of through the
  experimental features.

Changes in v2:
- This is a new patch for adding the event in doc/mgmt-api.txt

 doc/mgmt-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4..5a32091fa 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4978,3 +4978,22 @@ Advertisement Monitor Device Lost Event
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
+		0	AOSP Bluetooth Quality Report Event
+		1	Intel Telemetry Event
+
+	This event will be sent to all management sockets.
-- 
2.35.0.263.gb82422642f-goog

