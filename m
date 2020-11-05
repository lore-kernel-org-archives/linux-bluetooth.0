Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3F0C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DF02071A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtgOVjdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgKEGkw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgKEGkw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:40:52 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BC2C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:40:52 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t12so605190pgv.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AiMlLJgHixAXDnCP8ZY72ZbeqLVurDL36FqDlebGM/8=;
        b=ZtgOVjdmQI26kRDYKIW5vRBGW7JwgkwfgDLSjII5ASh2mQoV67Md74IOQdrQuJIKPD
         THobIf2oZ7HQfn4GoHEgNym7e11H3B1WpD4F7hu5NcMqtX7uWvMPp41f07trq+6VAGhF
         G8AiMpOd1F4Tc4lBJFHanq71z5Aa/SOKF0xV32jM2wJhLyv+Wr7vJWQ7BlTAcMHwqnli
         inPJVlXq17pnXug1FctdquHXnQinkFKmMWos0A/51AYjpSa84K3j3iwuiYmkVwlTC8/n
         79r6ExuygRCTNUGzdu/fnnC4lwq7FJF9T01mEUAB2wiQrmcN7uJeH4utVJKN8fArm0tj
         Dy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AiMlLJgHixAXDnCP8ZY72ZbeqLVurDL36FqDlebGM/8=;
        b=VR1wdaIm1a2u2mydLkUJVkdbG6sxaK2p8R/XpbSNwI4O0uJyDHihu8pfOa0XwtBmzG
         jK/51Au8o1kAwCnQibMKIW356QVhFqW4EXl1V6QnNTHzlQvfcZzNsk9QDRGbrYIjYbBc
         BtOgMo6E5XXluQGpnJiRWQJ9SFpg83pYTIb7G0Emt8Y/kXL6oLzSC+zABxXGT26sckpf
         Y5lSAsox279ScGviWj5yZt9wWhyqB4LOkD22Pr9WBWyCnR9FcWSskTwVOI1bQUJao/pv
         KjrkViT2KbLjU9PPn5UliQsiJyfsDtqKHNjMRRaswTpizR1Y6BAGYI/5cf5A8DmYtrx3
         Ovgg==
X-Gm-Message-State: AOAM531BLu1As+hNBFCNTzQLIEFFbrer04g4nQhvXiEfiJBnDoHSXyNS
        Zqc1SbrBek6mpToPUYT4u9D8u7yrh6HRZMOVIcv8MgHloFecP2+l7ZYKtEKAgk7/j3DD/vk787z
        qMCVG6JQT+Q66hibMPa7Xbg9EenGUXEr0wdFpS1j5yjigTeNFI6vCj//Krh8ufwVoGhk7ey4iRZ
        50
X-Google-Smtp-Source: ABdhPJzQOKLk4bdAPbeoNNYbZWRLSk+HTZFwyFoj/A/GF/3Pbbmwl3NpBh5W0jRJBY1+UeQWeQJtSdKbmXDZ
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:902:7c14:b029:d4:d894:7eed with SMTP
 id x20-20020a1709027c14b02900d4d8947eedmr625745pll.81.1604558451568; Wed, 04
 Nov 2020 22:40:51 -0800 (PST)
Date:   Thu,  5 Nov 2020 14:40:33 +0800
In-Reply-To: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Message-Id: <20201105144005.Bluez.v3.2.I4c872b9b8fdee53a335db41acbb6e59fe9692cc5@changeid>
Mime-Version: 1.0
References: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v3 2/3] audio: unref session when failed to setup
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There is a possibility to miss unref-ing when source/sink fails at
setup.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

(no changes since v1)

 profiles/audio/sink.c   | 5 ++++-
 profiles/audio/source.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 134d157bc6..d672670e25 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -258,8 +258,11 @@ gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session)
 
 	sink->connect_id = a2dp_discover(sink->session, discovery_complete,
 								sink);
-	if (sink->connect_id == 0)
+	if (sink->connect_id == 0) {
+		avdtp_unref(sink->session);
+		sink->session = NULL;
 		return FALSE;
+	}
 
 	return TRUE;
 }
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index fca85d4cb3..c706c928a7 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -259,8 +259,11 @@ gboolean source_setup_stream(struct btd_service *service,
 
 	source->connect_id = a2dp_discover(source->session, discovery_complete,
 								source);
-	if (source->connect_id == 0)
+	if (source->connect_id == 0) {
+		avdtp_unref(source->session);
+		source->session = NULL;
 		return FALSE;
+	}
 
 	return TRUE;
 }
-- 
2.29.1.341.ge80a0c044ae-goog

