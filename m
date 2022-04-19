Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15EC43217
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 18:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356969AbiDSSi1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357709AbiDSSiB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 14:38:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8B286DF
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:34:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso2687218pju.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLgVVt96BYUXkm0q4K75l1wjsNucJJck339ryBLiGls=;
        b=ih42wntxus6VPCp//QpETx3y7SoYHx5n95I4cdROE9+5kXBbK1YriHrSbjY+x/fyTr
         AStZb+t3H9tgzJl03Nw9NqVbIja9dJOwn/5vr+37j+RGpyiiD2AlvzM+em6VJd4Y7Lik
         xKFJCpOQNLNBx8tbKAQttQpepNlirEVd14EAy7g1NQCRDBYo+NxmXkzNVHIB6zFPbmEU
         Ojl0D529WF0uzuPD/aDbJarvSew4352s/sk4qbPsJyc9T4DSkszxyZKgpDNJ5EGuPvIA
         Hk3iJHo6RepCDe+K+g4ilfHxsaKY1GU6dGuK2RgBxbhMgTFZKm+TDtB2RD7B0M838QGX
         B+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xLgVVt96BYUXkm0q4K75l1wjsNucJJck339ryBLiGls=;
        b=HpmeZL40JsLED5oqrFfGa+kvQB9bi38KJaWD49Yw7AT5DbkjzR1OhxjnyLwpuzUqx8
         r8f4wGx6gncRl3jaYNB3t4uWIJadwyl7OKrKGQKCOCmL4S2iz7N1kaMu9OOitvmpAgq7
         DMzIVCJ2xFkpZ1zu154CCrb6x+fsp3lJgxSSi3L4i+f7j4mlpz/TxsD233t4nzeRH/J0
         JbvGB/ZsfAwizgV6G+6j5U9bbgs5XqAQmCM8j5VP9ET2he89HAfEiSAaPQTLvGe4Cmy8
         9ISu0kRNqnwXJynpn8TJxZXybT21C9D/Ow8zeMrvbR9Y39mLuVksg+obOgkkY2/rI0JA
         QP7g==
X-Gm-Message-State: AOAM530gqIW0saNHL2mbgaR2Kn83IIns1aaNL4bG1HkPtpCxUom/EFhU
        iK6nUYVsTMpZ+zA4ijOnr29stWDu/zQ=
X-Google-Smtp-Source: ABdhPJyVgcMFolyqL53EqLLqYjQ4tLT/up/aQR2FH0Z5P7FI/PpfnicA5nMjbCFMJbqhh0dfSu9c0g==
X-Received: by 2002:a17:90b:390d:b0:1d2:7a7d:170e with SMTP id ob13-20020a17090b390d00b001d27a7d170emr16396267pjb.230.1650393276007;
        Tue, 19 Apr 2022 11:34:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b005060849909esm19816838pfl.176.2022.04.19.11.34.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:34:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] settings-storage: Document use of StateDirectory
Date:   Tue, 19 Apr 2022 11:34:35 -0700
Message-Id: <20220419183435.2534491-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This documents the use of StateDirecory environment variable which
overwrites the default storage diretory when set.
---
 doc/settings-storage.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 26584f201..178e7d07b 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -18,6 +18,11 @@ change.
 Default storage directory is /var/lib/bluetooth. This can be adjusted
 by the --localstatedir configure switch. Default is --localstatedir=/var.
 
+When loading as a service the storage directory can be set via
+StateDirectory environment variable:
+
+https://www.freedesktop.org/software/systemd/man/systemd.exec.html
+
 All files are in ini-file format.
 
 
-- 
2.35.1

