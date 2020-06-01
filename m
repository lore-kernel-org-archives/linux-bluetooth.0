Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B95C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 00:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136E42067B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 00:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="haiHeVkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgFAA4F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 May 2020 20:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFAA4F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 May 2020 20:56:05 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88CC061A0E
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2020 17:56:05 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so4684883vsl.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2020 17:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMwHaXbeSkXrwG2sSCSubJWsZKMT+JxW+Nt8ziFLHC8=;
        b=haiHeVkL6R5ItR1U1IZsbhi4W1XY132nR9OlY8MUO5Z+/VK7ucEWYCCMLxapR+nysE
         dDOKSJm8Nh0O+Cwl8ZVE6yEUsrY5B8bwnPdwiaMuS8zcnU2TWrm4iOHgJZ7s3aE0I5t0
         515jQ+UOuLmqnS1Gv4Yf4E54UdQAyVFB0VmBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMwHaXbeSkXrwG2sSCSubJWsZKMT+JxW+Nt8ziFLHC8=;
        b=WuzBJCRDtmM0x/PWTD4A5GX2dfV0OTE3SApoPQFkBe65MpmyhwjzckCKjle4DPR3re
         8BR0co6T8zJOdDM8Y7ezUTrGsQWnNDEgEAL2pmG7OXW/NQUW/RoL4xlDFwP6rqLcZwyZ
         54ORoCVRP1+dJRf4hKX1JKce4PYkXsAmf3T0PSXzFqN7vvQuzW4hIa4M+zhQFkz2MYtC
         rYgid0UoPo+NCLJAsHQ0hhildb0EArPYHD4HayBIvX/CGiZ+RYuHaNB712670n6chAM6
         7wjHI18pTghB/N9fGex14Eftj4QwoCXcZnoczd8MTnkzThjXmP3n0nPiZs1TLnyUOEPK
         uREQ==
X-Gm-Message-State: AOAM531kpKbb3g89olC2HLkrxmz7wH41er0kj5m0BbQJ4KwxjxrsSjgr
        UTlSPamq32jU7Db29ou12I3g/9/crmY=
X-Google-Smtp-Source: ABdhPJy0E7JaLyncd9CV/B9/p+gws7ohXZMB5B1sSv2+fv48Bemf3SpAYvIbSmIAkWJsrxWP61rBPA==
X-Received: by 2002:a05:6102:2268:: with SMTP id v8mr10434140vsd.114.1590972964252;
        Sun, 31 May 2020 17:56:04 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r17sm350701vsi.34.2020.05.31.17.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 17:56:03 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH] a2dp:fixing double free in load_remote_sep
Date:   Mon,  1 Jun 2020 00:56:00 +0000
Message-Id: <20200601005600.254025-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes a double free condition in load_remote_sep. Value is
freed, then the inner loop is broken, but the rest of the outer loop
will attempt to free value again.

---

 profiles/audio/a2dp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index a2ce3204d..6f46c92bf 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1967,7 +1967,6 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 
 			if (sscanf(caps + i, "%02hhx", tmp) != 1) {
 				warn("Unable to load Endpoint: seid %u", rseid);
-				g_free(value);
 				break;
 			}
 		}
-- 
2.27.0.rc2.251.g90737beb825-goog

