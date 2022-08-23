Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0955C25B08
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 04:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiHWERF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiHWERD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 00:17:03 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB535D133
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:17:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id bd20-20020a056a00279400b0053609a39408so4146054pfb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=RQF+Hp7R78XaNSbP7FojiWh6Ao2+lXh+qmPouBKsoxs=;
        b=hvvCtSMC0Rq+dBBMJ5/nypqanMxOAHvudpyxc+IxZ6lJomJw9YZ+46Td1IjlOeO3sQ
         6jNaU3VtHrGBlpybAUUCHjrZbX//Xl5mS4RV2d40mCyQSKNo4ZucXdF7F8I1g1fvqZdM
         Sqpg4AMErjvRTLy6cINr88zSPKEpf9haHufA8oKfqPNnmE66jyNZt3Hbta+VPSyri8B5
         3plvN2/EuHLtLkTE+mPOETi1Ti3qioAIspnkbs8HD0h8Esn6G+fni3dezZppbtQ8ZtwJ
         UO9UneKitbkHzuBhN/xJxXiQIveSx4GJEPL06MLK9fyI4FVz9ZDtJeCDPiCj2vduLlpt
         3RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=RQF+Hp7R78XaNSbP7FojiWh6Ao2+lXh+qmPouBKsoxs=;
        b=RGExMqw7PhcSke2c6ruHtpBfoxuEUdhUv7WWLmEjVxyr+GovN6qljtKmYbJcUN92nr
         tX4d65xC3Hs1M5reRgUVxHQiyjh9oBicmDXneVIRGiQmi1LPVRsocjm4b/+ZRjA2IsAf
         jQocHnL8Fi+LQDGlbqTuC5fDktSx8MsF/AQ4gOKpUlICc7S0ncSo6CBVhYK1rlNPWk1l
         2N2Diz1Injkmt+184m2fxx7rExTb53qBgJgfqbPRCWaDzzOdUh+zntwNbX7o/h7lrrID
         fyA5IyW8ms6f2xBEkZAkMaA9RIqhmx67XmX+hKxiZx5RLgOPOsoFsWi+M9xVUqoJwyEm
         RLMQ==
X-Gm-Message-State: ACgBeo3KouMBMTToxp2selg4xUzbDIm7HhhfKEf8H12NlG2/nCs3bEtt
        M8jwj48MkpN00MxAezX28M8b02OxpmirEbogkpafpf/IBQvKmguWGp5qaLcyiWP9e6LvXpUb9t0
        DLsjStRf/vgjlHuWXYS/S5hD1Lv5PN/JQOcIWJn/lkQdHUif7tbjldiHJgE69KkG3peY055pmMD
        ca
X-Google-Smtp-Source: AA6agR5GsrlymQnzABGSg82b/1ULRf+EGCNJ+vYGzb2JaeGX2VQvvlFplwzTUlar4K29y9a31LyiQW1sAtAP
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:354e:b0:1fa:a4a3:bb3a with SMTP id
 lt14-20020a17090b354e00b001faa4a3bb3amr1542937pjb.134.1661228220929; Mon, 22
 Aug 2022 21:17:00 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:16:55 -0700
Message-Id: <20220823041656.3398118-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v1 0/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
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


Hold hdev->lock for hci_conn_failed. There are possible race conditions
which may cause kernel crash.

Changes in v1:
- Hold hdev->lock for hci_conn_failed

Zhengping Jiang (1):
  Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn

 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

