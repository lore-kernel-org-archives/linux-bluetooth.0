Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF09FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83EE2072E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0SxV781"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHQV0A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHQVZ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 17:25:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F3C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:25:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n19so7881522ybf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2ry2JVOxgxZyCxpqHUw3SBA49AdxBx6Obg5uwKLjEJA=;
        b=V0SxV781es6GMQLoJnWzfE9hR1SwZOVRuDAbom4EbWScAnjDOERImeyJUMc0us6k+F
         iY0v+yVVNJgTkgvUH7qq9SGUeOsQZvLDrz2wYFN1++kXWh95UA84K8POWcevRY9JdJUE
         NvX/znS2ClqrVzEtSoD/IvU6ZTfUVOa/SH/b8Qk/nBS0yjFzvt7IHELSVeRj4ow9KmnD
         efI6wbwUXGT747OwJSt/7No7xBWAHViGhkY9tU50sAy7dujKpoBgRU9thBvS5jbwhNQN
         NVMCxkoGqadRSaFeXMCfpUh9yhBGue+VKUUGAGg4MCP4zF9DEPC8d26kvAOy0OqEerAM
         QJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2ry2JVOxgxZyCxpqHUw3SBA49AdxBx6Obg5uwKLjEJA=;
        b=UYkq16B/Rv87pncjyPHZWnUjirdKjTSt7I1ltnVgPmY6HEx4BtyaohQyJm/RYdspfA
         01AW2d6gTFpZpUJEyHNJEPlacjcrvqy410Pw0GFr0JGhFDU5Q/D5i++1W4OS2BJpr2XX
         z0U/3HFtOHi4SyjGQzjP7MytVB3eolB+cEoEJzSk2FGfXvKfM1y4rnXVc2nL9OabGkIX
         mgjBW9vVSTcb4cVn0zTUBBuS7l3jq6aRg/E1Bu3gi6MTD4s6Z+WGfFA7HwaIZZBFefT3
         jTp4sfWGc/43DWB2mOLa5Avaz4loSDQE5+AWvcGkOKjxCG4LNFB6k7cwC99e+iBqJswQ
         CHXA==
X-Gm-Message-State: AOAM5311DBGS3FrD3Hh6b+GAxgXaYYyxkErpQTZ8MR2n7xeqsk2i+Q8S
        btMUG7ZIvzmtF3uT/MTa2S0lJvdHKIxEmLnmQJz0BtS/p8tjstecdDtCMBfA7p2VmcO3EWD3yhS
        9vT8PANbDh34caaV3tqntVeuoeLU1lqw/qoag5kcqjNlAIppe5cxgFp6LeyzotANhJmNa19bPv/
        i5
X-Google-Smtp-Source: ABdhPJxCif0p8c1He++UfAUR//plXBTqdbAExLua3wh9TYCPnA5fxeCjg3St4xR4AKo/ILhsmIU655pjQznf
X-Received: by 2002:a05:6902:6a8:: with SMTP id j8mr22738269ybt.417.1597699557713;
 Mon, 17 Aug 2020 14:25:57 -0700 (PDT)
Date:   Mon, 17 Aug 2020 14:25:53 -0700
Message-Id: <20200817212554.3844965-1-yudiliu@google.com>
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

 doc/adapter-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.28.0.220.ged08abb693-goog

