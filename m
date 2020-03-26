Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E3C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7478207FC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 08:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uujnMj1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZIOf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:14:35 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43728 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCZIOf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 04:14:35 -0400
Received: by mail-pg1-f201.google.com with SMTP id v11so4139896pgs.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m81ZEmeg1MGjYVxqj/0ycBvptA/xiyZG3FgH5j3no3s=;
        b=uujnMj1WRvFWtR7cEUqQetjgSrP+mo4tQ7z7SO3fJQsWbYofn942kuh6L8oiVDt/RH
         O9v2btcFBMTLmYROJ4SfpJvlyhGU9QRxTvUST70GqFZC+29VDd05Dlx18YCq9GjE2DBu
         OP/gB+AOt0vrTe1KeypBVlXgoVGGXz24FrgqTa9/mtr0ohdk5IMglQ4g7je7Igjbu1ma
         5MSOaGgNtikYhU/kyCDZ/tllZ3rUR0TcJfDhsE1+Yfgt0CTPgs1BVGHnKgucKShZu81x
         U6XQoDty4+5f6Vnua6TfrMBpjiAJthABG43nJ1c+RP4PNN776G5SC1rz+3aXGQ0uV/ZN
         6+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m81ZEmeg1MGjYVxqj/0ycBvptA/xiyZG3FgH5j3no3s=;
        b=RvpTm89PUXweLzBSpDpl3M+7sUMj3bvyr3qTGQxGQm2nB53gKwGCseLI2yudkSG661
         z1KzLzfG6udgPsGDu5pK6KM5PlIAng671wC5mvBm14jx5vHgFj7MM2LCuBS+psZECRGo
         paI7H/YWYnAUNKVdDPDiKjKsLfCJlBUFdf2Rjpu+Z8uaYr8JAvVwcomn9H3cnzOj7GkC
         NWNEdi3NA7FuICduo4Dszl9IU9eUvmxiANVO8vr8VcQreH4z2k1HSs1J3tcrjItH/eDh
         IZvphbWWaH0FMmUyC693iJnaILefsSaIIUbt+QRDOq9KVr75nxID3aPxnWEgmuRP6qZY
         tySA==
X-Gm-Message-State: ANhLgQ3XCs/dxbmvqZGGsSurkTJBXUG7PL1MoBEiwJF+Mb8hbK6JshSf
        y04N8ZMwgW0yZEMQL4az8SB/lf0kUiqz1paa6NztGJmRJUcPz6yq2nUnUdsT2BzQWN75P65mx6+
        hJN83pdnRoHtGkyqtKutr7BjgoahRp9aTShEMY5xqQdpu+sH/o6WyFD50BMVRBOjq4CFvyxYTWz
        Wx/2vXn9nQfWI=
X-Google-Smtp-Source: ADFU+vs4iB0BzNZd3EXBpixxvtt/FebU2OzQD9b1pc7ylvDri+wPF2hlyXkMqA2H7Zv9LLEPi1d/qSSlz9Mej0CTzQ==
X-Received: by 2002:a17:90b:4910:: with SMTP id kr16mr1847074pjb.142.1585210473982;
 Thu, 26 Mar 2020 01:14:33 -0700 (PDT)
Date:   Thu, 26 Mar 2020 16:14:27 +0800
Message-Id: <20200326161415.Bluez.v1.1.Ieaecd20492214a9bdb962417481330ff73240527@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [Bluez PATCH v1] tools/btmgmt: Fix missing setting string in btmgmt
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Both PHY configuration and wide band speech are not set in
btmgmt.c.
---

 tools/btmgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f631de4aa..b1820b41c 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -353,6 +353,8 @@ static const char *settings_str[] = {
 				"privacy",
 				"configuration",
 				"static-addr",
+				"phy-configuration",
+				"wide-band-speech",
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.25.1.696.g5e7596f4ac-goog

