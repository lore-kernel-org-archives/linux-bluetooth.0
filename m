Return-Path: <SRS0=Z40G=BI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80662C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613BF2076E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jul 2020 01:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mv5ftazH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgG2Bmk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgG2Bmj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 21:42:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8BDC0619D4
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:42:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so1797501pfb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JREyKdWiZay/mV18M1Axh+euiqXpqs5sXmHMc+iAKQ=;
        b=mv5ftazHEBjQoDdXHQUpaVOF1CD/lzXNM9zfmJde18RJxukAT2Wx8L0bZBp7YGKNbx
         e9uphKZyPXLxsThr5ua9lbNWsAvEOrbDPDh4SnRUsxEj3KepOa5d2jGbyXpTAdsRCcXu
         1xfJpH55O0nvsvyiDtieZSWOaXnVXd5BD95m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JREyKdWiZay/mV18M1Axh+euiqXpqs5sXmHMc+iAKQ=;
        b=LTYqa2JZNexIe+klDrezaNCDdL703vhu5nDLi+vWvrkmWWOjeyawvkBWp079AH/cIO
         9Ho/PWlxUmzdRtuslrQIQ7uw0ancVFw5gT8gEF9/hChhDJUHT8lnB9a25TRZBfIJcpqv
         H3SS/KW24KPfFjOwSDPhVJ+2LAQltjRGmCUZwov7Vgfy+/bwlLlDp80O0dHwuWpBZYTr
         saprdhIJtdxd7LiVshESExQf/HanWIi3PZloucOOMTDNoCbamvWuPgUSJY2ozTEqT2lT
         DCNy+iht+jiz9EhWwxy9SvBhK/nlPCsUxe6YUwwlL6gRIYdtWp5hFlSl3nCUWINkFxTo
         UbxQ==
X-Gm-Message-State: AOAM531udwwNg1i5ZuhzuiJiQxLU8IfesLsOUxqT2+4cYLdn+cdZAm9H
        kteUD1GWY8ToZ2IHADQ1yne23Q==
X-Google-Smtp-Source: ABdhPJyCZXaEbxMk/vJPZ4nalToz0Wmy+riDDLOIm88MjiSUydfptFoj2rCEtzKrzaZTiG7rhBHK9g==
X-Received: by 2002:a63:935c:: with SMTP id w28mr26269597pgm.174.1595986958935;
        Tue, 28 Jul 2020 18:42:38 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id e124sm280678pfe.176.2020.07.28.18.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:42:38 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/3] Bluetooth: Emit events for suspend/resume
Date:   Tue, 28 Jul 2020 18:42:22 -0700
Message-Id: <20200729014225.1842177-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel,

This series adds the suspend/resume events suggested in
https://patchwork.kernel.org/patch/11663455/.

I have tested it with some userspace changes that monitors the
controller resumed event to trigger audio device reconnection and
verified that the events are correctly emitted.

Please take a look.
Abhishek


Abhishek Pandit-Subedi (3):
  Bluetooth: Add mgmt suspend and resume events
  Bluetooth: Add suspend reason for device disconnect
  Bluetooth: Emit controller suspend and resume events

 include/net/bluetooth/hci_core.h |  6 +++
 include/net/bluetooth/mgmt.h     | 16 +++++++
 net/bluetooth/hci_core.c         | 26 +++++++++++-
 net/bluetooth/hci_event.c        | 73 ++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 28 ++++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog

