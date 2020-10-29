Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ADAC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA40020838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkH+5ANf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgJ2VXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VXv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:23:51 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7407C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:51 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r129so1366582qkd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CQX7W5tMg0C/rkuxt4IPLmY9UnuctOufHVY1gy1DhcY=;
        b=rkH+5ANftUy2+0Tcub4lmzHaf95znxzORWBdwDfVsjrfMyWbpmlyH+nKMy9C4GKzR9
         bca7t4U+cJWgw2aZWYd4mcdKnWrVUj+zILnRT5buYMKLS6YkiNX5CVdhnHkRUMjiTs/c
         K0IDImaXfxtElYiJUeJ5g/++VBK4MLSCLy8MB4Q05IRXrZpp1JjVB1hJHb/RlSZIo+7C
         DuZbTJrGNfwesACmvt6j8WNc7GfvPVTdwyD8Vsw/aMoI6ZEfni/apNZlSBzTtw1J6PuI
         pZqEPl0JSHfc0xYOfMvMG8ivSceZPT5BXlqNYtGnbmZQKebtEJr3IbBKPl2/gLNOOjFq
         k9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CQX7W5tMg0C/rkuxt4IPLmY9UnuctOufHVY1gy1DhcY=;
        b=HaCzT4NtQu7iggNvgwqKR0t4eBHc75GLFWr4nzBbaZekBoWo8KSA0WiEpVRJTpa+nJ
         FR2ubmUvTIdrg5dD/eg6Zghyzvbm+hPkTUrZ/4QMDPqif+DW+xYFgQwRqdXGoYeejvZK
         +mCg67ukDgpT6P9i4CK8Z3LJcVVkvERpLEtKGcsWUtLjAL1ZCs9DyytvZgTBRqtEBw9O
         ulTgb2z+ZCPwxJoZeJzHljiDCSAEsKoagJzFvGKV5ihXk4MDrGPs8cwLRjEUH0mQs7Cb
         adi0PxCSo3vQlVAiz6gfk+D3Mmt5WGS2HsQb3ZbaYV4dBM9VoGKC8DArzS+MPSECWWRb
         8JVw==
X-Gm-Message-State: AOAM532cul/uHCnw6Jtjpw7z0ZZ9ICXrvLWepCAT/CqjKFCc1q24RxGG
        WxN52XcaXycjcPpN1cewXf0pWAAt6C2QXD6J36O+
X-Google-Smtp-Source: ABdhPJw6YclMD4UeuteY5UWLCWEx93XYoGTwAsUh3Nh+xbMzecvuO0KwTbTC6Q9GJkpwl6UUkUzglgnbS+skB7j85kkW
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:4d46:: with SMTP id
 m6mr6381820qvm.60.1604006630950; Thu, 29 Oct 2020 14:23:50 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:28 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.3.Iabfcf7ec8ac293130a7d903ee8094414256799b3@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 03/10] doc/mgmt-api: Update controller capabilities
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

Changes in v5: None
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
2.29.1.341.ge80a0c044ae-goog

