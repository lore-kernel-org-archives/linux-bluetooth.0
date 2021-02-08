Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E9AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2D464E75
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBHWGS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBHWGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 17:06:16 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28000C061786
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 14:05:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id w36so11401868lfu.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Feb 2021 14:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecHnXy/1wGj2MG7vl2nvsZCgQh4S5SlQOsVq0e9KTNA=;
        b=dYWy5eSzfzpGnj3YEpyMGhZ90mS4/xQ8tSzTgLjD0c9YR/SUBkh+hxrKhhvwO++fqZ
         QIUv8o8D350ZbUjRDtq8y8N5UdsZKy/aYtxXU/RGOKwL2mle14Z5gdKSno6ZfyTz9CWs
         SRpGRFBoNddA900dD609IFI5zABc++m4Zqizf0WaNvTaqWXYDcbNBd19L7gBUor9QqDj
         rvzgbySiNL5Y2yKqrdzDIX5jevtUF7VwHVSGKGRdpaTFErX7Vl1hnTfJw+ns+1HAWlo+
         znrOtXTULR+rSrNY3JgSUz4Jjc+bKReL45lBsWoDDxo4VP+cmAZyxfs901Ib3Dks4BGe
         TQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecHnXy/1wGj2MG7vl2nvsZCgQh4S5SlQOsVq0e9KTNA=;
        b=JMG1svjgDP9tjUVB8ODjoys70AsuLN8FXhptDCE3pLImvVaEDSDIp0UbCSoncTtAzN
         j7Q9LTdMDxOHMTiwIoWq0Aa8ANPkw5TE9F8CNKzo21/UnhFUm/HvDxjQUmcMlTLfRypD
         P7nUEMcAKZpv53KxM2tZiamfqtCqqmi1ua07jleTTrphy4BW+r9yOBPso0q5pOwBdVz9
         pLD2506XMkXhJhiUq+Af5i7/pPWhr8U0Zuno4VeBWbQLHm9AbVWsQcJ35989WEaVGOMO
         /R2SLG34mD/DZ+BtFRKEZ3XoSfJqDaukMxAdwgNdhBY7N83wfyD/UF+es57pF17anLW7
         AP5Q==
X-Gm-Message-State: AOAM530xnOzpMlNL+o9YzD1JJI7ZU1IeAqPQRU40xtTrxSU2Bh2nWWS1
        GPGo2Pz4js28eJaLKSzzqt9uies9w1tli33of+8=
X-Google-Smtp-Source: ABdhPJyI3A99cQ4r4Gshw6zl3CaRmao+KkRBHXSxMZr97RdbYH3ZfJprpzdYTMKI3l+vd0LIHVWBiA==
X-Received: by 2002:a19:ad42:: with SMTP id s2mr11326424lfd.448.1612821934297;
        Mon, 08 Feb 2021 14:05:34 -0800 (PST)
Received: from localhost.localdomain (dzqmct6w75s9d-569np-4.rev.dnainternet.fi. [2001:14bb:a3:5428:6a5b:cbfa:3fe7:5d5b])
        by smtp.gmail.com with ESMTPSA id p15sm975615ljc.123.2021.02.08.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:05:33 -0800 (PST)
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 0/1] Bluetooth: Fix Just-Works re-pairing
Date:   Tue,  9 Feb 2021 00:05:30 +0200
Message-Id: <20210208220531.3471-1-matias.karhumaa@gmail.com>
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

v2: More detailed commit message, improved readability of if-clause.

Matias Karhumaa (1):
  Bluetooth: Fix Just-Works re-pairing

 net/bluetooth/smp.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

-- 
2.25.1

