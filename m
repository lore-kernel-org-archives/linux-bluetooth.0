Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 23:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbiBOXmE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:42:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBOXmD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 18:42:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB164E4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 15:41:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d17so715133pfl.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5yFjwpZudKmDr8ONcK53NTMeXGzinWVPNuJic0k70Y=;
        b=p+11puHZ1f0BmrxwzSFJJgUdin3Ssk2QZPX3LDMiAo/VD8szqZ+ryDBMWP3jD+vlXj
         DGp6Z5U3kPlb1p2D6xEPRN8yr5NrAFflauKFEBFtskU16+Kf2Afv8MkGfjdvBACgorrp
         +lVS0tgqk8fiC4hLGpx699p+DqkpuEJxTW2AuDr076qLU/LLuH4dEnwpHUlQvOPf844x
         fFILYEo83zpCthWB6q9VGVZYB2FyxN1Ii8LxTYBeIdARe91qjZhqqP6HxCR6os9+1HTe
         HXkrC1tMvGOKVhXtsAeHiQzFhajaBaJO+QUR3YsFMwh1W5HdF4tDyxnl+G38ZcykxyNW
         ds0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5yFjwpZudKmDr8ONcK53NTMeXGzinWVPNuJic0k70Y=;
        b=6EJqEtStxMRcg6+3FNnNjCG5D6/kF5mL2hAtFwzrcJ5DMigKcfW54NidsZFwXzRUUs
         D82dQ1HdxJF4btGMZmBwGj8awgI7/rkWUNA8fH9XSyJinoqNZJcg6wVHxekhY069JvBn
         2T1l5A1/jskRqCqFWP7tOTriVFE+cFSrePclz5yOfVnMsqgj/ar5/yK7NtzhwAbwteFs
         zlLT9SJ1FzGRnv41YK0z+DNgo37klU8WekIqkC/j7lIo3n/stfLSV0qtvdFazJ/GGy1K
         6eF5K/Cuh5EuHUYbjhlFdUpdpHEvG/RE8pV+byw2FgKE7hm+pzlG3aKRylatz3CVJ5B6
         tSRQ==
X-Gm-Message-State: AOAM533XPX+ZDTtDfbGVyHbeK1Q0EkVg7GrDC1pq3m2eJUjVOqTt6m8S
        XUvbxAgkML+b9aUUfG+TyZHYyXUOuw0=
X-Google-Smtp-Source: ABdhPJyQsJZsH6coSn01GOBGYJikkUXf3CFgzez4FtIQFZ2wXbHnD4macu0YMgO7HSmA16MEnb8TFQ==
X-Received: by 2002:a63:fe01:0:b0:372:b258:a8c9 with SMTP id p1-20020a63fe01000000b00372b258a8c9mr11523pgh.376.1644968511279;
        Tue, 15 Feb 2022 15:41:51 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::b99a])
        by smtp.gmail.com with ESMTPSA id f16sm4078638pfc.110.2022.02.15.15.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 15:41:50 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: DO NOT MERGE: Test patch
Date:   Tue, 15 Feb 2022 15:41:40 -0800
Message-Id: <20220215234140.3416-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

to trigger CI

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 669ac7c32292..2647915be88c 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+CI Trigger
+
 Linux kernel
 ============
 
-- 
2.25.1

