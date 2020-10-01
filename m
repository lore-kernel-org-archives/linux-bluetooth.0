Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE1C4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E8A2075F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8yct7oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgJAXCF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgJAXCF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD366C0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7so500297ybq.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ELyHh4E4M/qxzihfQVWNiDRPB3NtJ1mBapDQ1W8rXwI=;
        b=I8yct7oM2cYMB1yX8bgUsFfd1SKjZf5n8DHVK+APzYy4OUB/JemHHvwVye4BiYTEy3
         JIqJf/qihtL8895KQIDhZOxIJ6khimtPStxUUd/7rLGz16lbzYjkasGOqHP6EHwvxOBD
         ZHa0TX2abvSIUah7vk5nk0oKoirlFAN1aSoksEGhXZ6sxK8h12dhlv80ayBRt9xW0WsL
         IiROnDZdcNK/TNuYtUR6za4CU02q8pZN7CcVGELYmvU0QfIBr5Kwhl8vXNaQXYrOtMPB
         QXr5mhkaT4d9UdOJXdu1583cEDqJBi/fm3dsZ5pfh2uaQIrmhdS1C+gfN7C85503BK6L
         mETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ELyHh4E4M/qxzihfQVWNiDRPB3NtJ1mBapDQ1W8rXwI=;
        b=oNcebsvxO4jY+f84pZ75MAgUsTdi/I5Y9LsqDoUxUNA+6ZBTvgD3zXbwpyRHpi+jd2
         o7DsLX0T5mzWC2WsydxHFaikiC+GLXIp0mOzC1cmwWVE6wTIse4bnSP+p678osqDLpQx
         Ir2ZEXvk3SbB+n+nVs5+drGL31RwysW9L7jlbkUTvWRhulx/xsoyV2MwGjjQ4P+BUxbO
         4O6KFoj3f2Efdp26i8KD8i9hmBVqb43WKu9Z9pjqRZVuOsjh+OJRhlnlqYyb9vECFw+s
         ljvv65rMvJm8IohkPwb3mCnAnXKpVcvsnOBT28vtueXrNl8y4FQZ9iFe0r4BW5zw4fC9
         2sSg==
X-Gm-Message-State: AOAM530lezal+CNcukf+/kHkCh0wTCjfpxOxMMasZEz74QjzvX1VD3vo
        1nl+m7DRlmDQy4VwbgKckh+24ndxuH8X4z2t5+IE
X-Google-Smtp-Source: ABdhPJwPcDywewNOkNHs8FD2cHCYGfmIOfzczMdr3IMJ7CgYn5eQOXDLNUpF18O+/C99NIoJmt1pKse3nwYXNM6YPgiU
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a05:6902:705:: with SMTP id
 k5mr15288510ybt.63.1601593324066; Thu, 01 Oct 2020 16:02:04 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:45 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.3.Iabfcf7ec8ac293130a7d903ee8094414256799b3@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 03/10] doc/mgmt-api: Update controller capabilities
 MGMT command in mgmt-api
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch changes Read Security Info MGMT to be called Read Controller
Capabilities Command

---

Changes in v4:
- mgmt-api: Move Controller Capabilities MGMT doc into new patch
- mgmt-api: Tx Power range put into single capabilities entry

Changes in v3: None
Changes in v2: None

 doc/mgmt-api.txt | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 7c899a8fe..1aa43d6c3 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3110,19 +3110,19 @@ Set Wideband Speech Command
 				Invalid Index
 
 
-Read Security Information Command
-=================================
+Read Controller Capabilities Command
+====================================
 
 	Command Code:		0x0048
 	Controller Index:	<controller id>
 	Command Parameters:
-	Return Parameters:	Security_Data_Length (2 Octets)
-				Security_Data (0-65535 Octets)
+	Return Parameters:	Capabilities_Data_Length (2 Octets)
+				Capabilities_Data (0-65535 Octets)
 
-	This command is used to retrieve the supported security features
+	This command is used to retrieve the supported capabilities
 	by the controller or the host stack.
 
-	The Security_Data_Length and Security_Data parameters provide
+	The Capabilities_Data_Length and Capabilities_Data parameters provide
 	a list of security settings, features and information. It uses
 	the same format as EIR_Data, but with the namespace defined here.
 
@@ -3131,6 +3131,7 @@ Read Security Information Command
 		0x01		Flags
 		0x02		Max Encryption Key Size (BR/EDR)
 		0x03		Max Encryption Key Size (LE)
+		0x04		Supported Tx Power (LE)
 
 	Flags (data type 0x01)
 
@@ -3146,6 +3147,14 @@ Read Security Information Command
 		present, then it is unknown what the max encryption key
 		size of the controller or host is in use.
 
+	Supported LE Tx Power (data type 0x04)
+
+		When present, this 2-octet field provides the min and max
+		LE Tx power supported by the controller, respectively, as
+		reported by the LE Read Transmit Power HCI command. If this
+		field is not available, it indicates that the LE Read
+		Transmit Power HCI command was not available.
+
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
 
-- 
2.28.0.709.gb0816b6eb0-goog

