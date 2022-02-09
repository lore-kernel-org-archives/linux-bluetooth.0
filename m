Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC311C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 09:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiBIJZv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:25:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiBIJZs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 04:25:48 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F57E0B2A8D
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 01:25:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso2992714pjd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 01:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Ezf2K87PY88yQLZVVdIdZGxXgxLe9pcYiYstWtu8lU=;
        b=Jvd8VZiKyaHs39Wjs7e9iLCcU+EkjI9kr+EtrwiUR3Z5P9l2yLFjlPxEP/gYMUWGa0
         lLuD+Mm7ll5h/FcgxAbRxfwHuS2C1tCwXhbLds5VHGuoq/CsSBWSO7P02+fISmZIH/Pc
         9yY68P/kqkVA7P0cEIFzhrqg3VDNnlRNsCBVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Ezf2K87PY88yQLZVVdIdZGxXgxLe9pcYiYstWtu8lU=;
        b=j+7rDbSu+xLf2hss/Md2B2EeCOLNTpKP8OA9yujQ4qmfPyXUxCX++Ko1Q6AT+6SCJd
         yHd+sHMaiB1s3vVhvfyJC3vYLmip9GOWXqazO3syJCwmct227UzU0J0hWfYFa6ydWDuX
         UVqYezb7hTkbTFJgd0KAEeLQAlR9nMx1wYsVweRH7PxxVGjW39KQBk1lGjMr7JvzGV1g
         AXIyL5+4+N5Ppa42J2La0c8dlbOqqTI8O3QaPRdHmu98wToAbUi0dsZAtsWrto/7LuOS
         RZPrA9mwxKXnwqBttBn8necIFaAG/cu0dbzpxlzBF1q88s2PXo8lTyQk0/2ZMjula9Mq
         a77Q==
X-Gm-Message-State: AOAM532rOif5ZwQ8MM4SYBNPygMBTDp9ClNXS0UeFvU8aa+59WFrQNg9
        8snTkjkE5NtTPjHOpadeG5cSm7aOdorzRw==
X-Google-Smtp-Source: ABdhPJzC+mBF8NDjH1P32ICsaDV/p7PuoySduAN2ZJkepj4YwuYUQpU9na64LJU/4syyN8JfqrvuHw==
X-Received: by 2002:a17:903:28c:: with SMTP id j12mr599500plr.78.1644398672687;
        Wed, 09 Feb 2022 01:24:32 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id t9sm5253516pjg.44.2022.02.09.01.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:24:32 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v3 5/9] doc: Introduce the Set Quality Report Command
Date:   Wed,  9 Feb 2022 17:24:10 +0800
Message-Id: <20220209092414.751642-3-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the Set Quality Report Command in doc/mgmt-api.txt.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- This is a new patch that introduces the Set Quality Report
  Command.

 doc/mgmt-api.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5a32091fa..4ac84d41b 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -332,6 +332,7 @@ Read Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
+		18	Quality Report
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -2924,6 +2925,7 @@ Read Extended Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
+		18	Quality Report
 
 	The EIR_Data field contains information about class of device,
 	local name and other values. Not all of them might be present. For
@@ -3858,6 +3860,37 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				Invalid Parameters
 
 
+Set Quality Report Command
+==========================
+
+	Command Code:           0x0057
+	Controller Index:       <controller id>
+	Command Parameters:     Action (1 Octet)
+	Return Parameters:
+
+	This command is used to enable and disable the controller's quality
+	report feature.
+
+	This command requires to use a valid controller index. Otherwise,
+	an "invalid index" status will be returned.
+
+	The parameter "action" can be either 0 to disable the feature or
+	1 to enable the feature. For any values other than 0 and 1, an
+	"invalid parameters" status will be returned.
+
+	If the driver does not indicate that the controller supports the
+	quality report feature, a "not supported" status will be returned.
+
+	The command is sent to the controller to enable/disable the quality
+	report feature. If the controller failed to execute the action, a
+	"failed" status will be returned.
+
+	Possible errors:	Failed
+				Invalid Index
+				Invalid Parameters
+				Not Supported
+
+
 Command Complete Event
 ======================
 
-- 
2.35.0.263.gb82422642f-goog

