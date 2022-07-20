Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE98CCA483
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 23:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiGTXgL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 19:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiGTXgK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 19:36:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF94B0C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 16:36:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id i12-20020a17090a4b8c00b001f20db22239so1765214pjh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aQrGPJR17lmJnXe4JQSkdLd3fsLqXa+0sk3zvKl8a9Q=;
        b=sGTXT1xAwxj8cmzJ9miCE24XB9YINb+O+i1wBcZcZ7m4agLhd1W6nUVTe2SiNt3uT4
         r4Py3ionEdmB4NiBBqSmNHh3m7Zu3fRyGAx1Qp2gdBb9d2XytZCYpX15rGG4dANve3kC
         t4iUs15VJJ4aJmd2iQBSmSpLanUIKYrbhVsAu4BFX5bRz8wmdjOZ67NLamN1MN/llKXz
         BtHptIrE6krUH+rftVbBGztURvWMXtvVZ9zRszVjvQp/7pLWwe0VEi3BnpDpMNQcbKWc
         ha0DKeqxtvA8cIxqcrXwafCSxF3cbby2vBxnZMNospvN1TlJnJusIEWdQQMmFeJqa6xl
         VJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aQrGPJR17lmJnXe4JQSkdLd3fsLqXa+0sk3zvKl8a9Q=;
        b=TfMJfQ0rnmSfH5DGf0i91FvOzKnKGlDjSIut0+gzL817OyWGmsisHqtvlpQ424AAmi
         JLVozT+PXrhAPRYQnoqVWdZAJ3gdV6y2Sn7PfPfSzYF6CjqEEuglbjk99mis1MDKRYlz
         SceKyale+qE0xxW3FhUntzNugIOxfa6BDEN/Kma0U7S8XdeS+DoTbM6C+pzQTQA0FTWR
         WkB9EgcX5BHJ9ni9gjO+/hWO874ktUYKsFW1jvJ74G44y2WN3iWx96eXARa5Pa7BMbIi
         P2ZxBst9xtHFG5Qq385d/m0Une6JkEc+lXy5Je4X0KD2OwPCNbqCGeq1Xn9ENJnRViG/
         /M4g==
X-Gm-Message-State: AJIora/pOl7dVAb5dlXCfPllMomB5s062Fa5EAsAUucH5oDMpZwiNJbf
        I18gmXjjJhRRYAjiE8MH+bfD3cPHu1iy4KoBaId8OIE5IKwFkNXWcJl1jGNfkyF3XsN3kclwTd3
        SNvZd40HcB9GnBgJoo9Jj1PhNkCTSyeaJudRl2PLZ2v4nO2g8aq33UpbMKf5nYNnAozH1Hi+55V
        v6
X-Google-Smtp-Source: AGRyM1t5aOID38OPghaC4aS98F2ngwbOeYnycrlhpNISQR5l3WI228w37Y/URSoaeqTanAErfusjf2tR7KGg
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:b92:b0:52a:e60d:dfbb with SMTP id
 g18-20020a056a000b9200b0052ae60ddfbbmr41195872pfj.72.1658360168868; Wed, 20
 Jul 2022 16:36:08 -0700 (PDT)
Date:   Wed, 20 Jul 2022 16:36:00 -0700
Message-Id: <20220720233601.3648471-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [kernel PATCH v1 0/1] Fix get clock info
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Similar to get conn info function, the function to get clock info also
need to set connection data.

Fixes: 5a75013746640 ("Bluetooth: hci_sync: Convert MGMT_OP_GET_CLOCK_INFO")

Changes in v1:
- Fix input connection data

Zhengping Jiang (1):
  Bluetooth: Fix get clock info

 net/bluetooth/mgmt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.37.0.170.g444d1eabd0-goog

