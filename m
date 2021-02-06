Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B3C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0063B64E83
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBFOPK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Feb 2021 09:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFOPI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Feb 2021 09:15:08 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58653C06174A
        for <linux-bluetooth@vger.kernel.org>; Sat,  6 Feb 2021 06:14:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h12so14730026lfp.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Feb 2021 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQ+CbAlaw4uucL7FMwrztqDlv/M4O9KCNQGflzaRSNc=;
        b=cPO/RLNmsFT0csdR5ZAhlHhqFj/F90aAwErLC1O5ExHFCfciTnxMEaDzAK2QZTDmG6
         m55R33dIq5keOJT2JbCRxkT45qkZJDMxPdD1ATor9SFf67nIFCdsi2zXLH/65+hCmJO5
         X8iPaLhKFtVwsRo9kdeDdOLcaHq9Y9yuBxgU9OtVdX+O2kLeKb551mKyaltQn8iaH5UU
         8E/UsHRUzvUZ6MZCCvum1s11hQSH0NNVoN/hv94w77i/kF92WWt9QZW/MFH4Yyy0Adws
         lySJSuq9TYXKTHK/Dp8o/6B3uH2enAz8Ft1xz6LPVV6nBZLKqP4ho0CGFkjOgnQ8eeEU
         H6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nQ+CbAlaw4uucL7FMwrztqDlv/M4O9KCNQGflzaRSNc=;
        b=KnC7PkxsIUJWokfG8UhmqLw7gHJLdMPD5RLl5ECyDa6bHDLKaOCmMxhxX6if2ziKQ4
         N8+47rP+yhw1YRAOuB6FoDaPy0DmMlVW5ZIJdgRnoSmVYw1+rDpvwwxs5grR3NRr0PCI
         3yTWWIY9ztBTnpSQWUGWH2AjVIAXcYjUyQcxeukl+tLG6+bd3MsZ8CwqiuTHJBhIV+j0
         2hpK2WYHMVOJtj1s1s+7bwlWso3VWRrtZyOPwe+7C07okZUNx6hNiGihr53VZgDLiLLY
         A8t3e7Yb53ivpwuro55pewYtHR7fj/vj0OXrjrQBFCXXJGAnrk6WTjKvUnsNilqYvv1K
         wpRQ==
X-Gm-Message-State: AOAM531326/gf3YawgWkPOLSO1i1nO1WeM15ViJOn1DkvS85OCGngxBL
        kPoTVZc4KywyUO1zvJ1OgIrNai9ITTO7LIpLxQ4=
X-Google-Smtp-Source: ABdhPJxPM8nv4h5O7zeERtDFB34xCV5hn7w9gNrZeX6gMA069el4lCywiHZRGbTUNS8ryko/EPq7Zg==
X-Received: by 2002:ac2:5104:: with SMTP id q4mr5269722lfb.517.1612620865216;
        Sat, 06 Feb 2021 06:14:25 -0800 (PST)
Received: from localhost.localdomain (dy57dxw0xwqyrd19ksxjt-4.rev.dnainternet.fi. [2001:14bb:676:39cb:d393:40e1:d7a8:7ccf])
        by smtp.gmail.com with ESMTPSA id w15sm161137lfp.171.2021.02.06.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 06:14:24 -0800 (PST)
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 0/1] Bluetooth: Fix Just-Works re-pairing
Date:   Sat,  6 Feb 2021 16:14:22 +0200
Message-Id: <20210206141423.13593-1-matias.karhumaa@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi maintainers,

While updating our CI machines to 5.8 series kernel, we noticed some
regression in how Bluetooth LE Just-Works pairing works. In case Linux
acts as responder and another device tries to re-pair using Just-Works,
pairing fails due to DHKey check failure. This appears to be regression
from eed467b517e8 ("Bluetooth: fix passkey uninitialized when used").

Best regards,
Matias Karhumaa

Matias Karhumaa (1):
  Bluetooth: Fix Just-Works re-pairing

 net/bluetooth/smp.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

-- 
2.25.1

