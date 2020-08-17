Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD50C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A732072E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K0yJoQVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgHQVVy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHQVVw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 17:21:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B5C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:21:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b18so10844857pge.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H+P2hBP+bTbEiqpMOjw9YdTEsWCnSEAX3HMUPcelPTI=;
        b=K0yJoQVvDltX6RzpiNK2gFuIayDflFySItq5E7bwJXcMwo1fmF4NvVIahfO1u67PPB
         7KTNPSNdPHULdCiUWGNUliMW/eHpkfzLc+HHXx0ECbMZ8W1gae+Ave56Guq1JLVWtyRy
         StccwtlYRg7+DEcdab00BRETzmFrHiQKiD8S0uLDlX4Mvw+r4QhPG62rZcSG4n+gg0b2
         Gr0LdL5tCQDxLpDe2o7gyGdbE6twPJhbhsMe0QeiwQVYA5jPvXmlGoVb8EIHRnqaTXD2
         td/mlkNitW6xPA6laK2L5ulEa/eq3XRR5NiBWOkPZSKMVHG6ChI/f/tL/lEC8AzUX9SH
         UXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H+P2hBP+bTbEiqpMOjw9YdTEsWCnSEAX3HMUPcelPTI=;
        b=Vih+MAD/xuEtpbF20qqpcrndS0mg5JDUzY2k1/+iSSZ10MLH69LAc7SGQom8dkwzKk
         VsSA/eJ8EVNnA2B0bPjM8zDmwsU0ZGDIQXpqIDCEfS9OZ+r2EArG+lu2U+PglzbkDK9H
         kozdXDvs2lvUH0tckZdiJWA9juNe9g8wx3nd0QjZTVPGxFnKt1xAQjYMsDdHj7g7VOxF
         0w5lVJg0ldl+Puh7ygCBNrLEM+q9GofCFHiVI46cAwLFuuHGrFzKMfwVrzDt5eH3fBel
         ufWfeVgFdALpRwZqueg7iP7gwDNcn16hDUM3P+vh4v0XT4FW3609XilOTvbvWaFh/xeS
         Vtxw==
X-Gm-Message-State: AOAM531MgNvG691yNpy55e/g9n3bvitTCgVXfu9z1RBclPfpArcj8t/5
        CEvrgxcN8idH79nM5bnuJx27BYaqz+kgXSeNXTOGBwkaYNE1VkMMHWgoaZvJOvVbarqmJrYcwtg
        kYT9McZfwIEzbJ4HrF32Wdjc2t8ndhA83gPVAaPkj5cynx8FRFZUEcQSvdQNUK3ko8ptRYlsfpo
        pq
X-Google-Smtp-Source: ABdhPJzQSMaEncZL/vTAChPbeosYJ8UpBIPKpI8MYSRMc06spjAm2UbqlsPKrNJjQm5T+o37nnaNb4I5RmJz
X-Received: by 2002:a17:902:c3c9:: with SMTP id j9mr13180422plj.62.1597699311986;
 Mon, 17 Aug 2020 14:21:51 -0700 (PDT)
Date:   Mon, 17 Aug 2020 14:21:47 -0700
Message-Id: <20200817212148.3839311-1-yudiliu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [RFC PATCH v2 0/1] A client needs to query whether the Bluetooth
 adapter support WBS, so we
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

designed this new D-Bus API to provide a generic way to query the
adapter's capabilities. Initially this will only cover WBS capability,
but can be easily extended to support other capabilities.

Changes in v2:
- Return an array of strings instead of a dict

Changes in v1:
- Initial change

Archie Pusaka (1):
  adapter - D-Bus API for querying the adapter's capabilities

 doc/adapter-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.28.0.220.ged08abb693-goog

