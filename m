Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F247C25B08
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 04:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiHWEom (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiHWEoj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 00:44:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BDD53005
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:44:39 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m24-20020a17090b069800b001fac361aec2so5680884pjz.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=lUCov81UkiL3yx2Zk6OCNHheGGSC+JEtAVpS5cfgjxg=;
        b=VQQRSuwFAryakFZN7o3XBnaC86NJb8BJN0kRwrV1UIIXqU6A4bnuxTOScxrfAYh32h
         AFsHq3EqIR/7SXFP72lFWxUyEZczBThvbRXWGVEegkJk2vJM6nV72YXBmf1+lxt/IGvP
         yXHwxpKfsThjjhWZzQI8//FWRXgDqOU4sUnkrhBRsXHHnzbZnB/tLEREshRyt8/D0K1I
         3K9o2H+mau3uY9LNULYduQ3LmFi8GnYNe9PwfLPaMjcivIR+H6Df56RSEu4sVvSlr/Gi
         lp3ApSG31oiReNNTdWxh1fI/2LArEf/6HjkzgcakX6PVq9Qzl1VXfuYHcq3FTJ+tRX8k
         k2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=lUCov81UkiL3yx2Zk6OCNHheGGSC+JEtAVpS5cfgjxg=;
        b=RxlkoNRY+1icB5sEsF0jhi0RJ58tMFwYSIEYPVEAYriMwcQQf6kdTvmTRrMr4tr/+R
         jAtp+h0EOGqh6EtZX2V/jcFMrg3wYBYuUGP5gmJSTLk9XT4n0mdSAYm1ir5/RtGzMRvH
         PokF5dSbHCOzzq9+Tw6ouXFE0i0hHBbnKAuAQuE7cPIlHgwgtGy6Z4DEYZniOicYRwBu
         FyqpwI7ipmWr6cNOnfL1gAGGNnDqCVudcdQrHdN1euUmVEz36s+M6AkLxWKRAp6cqdS3
         OFrKGfhCFTxKwZldUhWsNXfoPf0eIYj5MKM+/ipamCQhg1rx30l+xwTVhFCykHOsT6d1
         XwXg==
X-Gm-Message-State: ACgBeo0H6s6lGG0l+N8QvJh/lHAQdsx7oJyOngQvyRgz3qJ1MYzevCb+
        dOYbpIlrCaOR7pofgfoWWgofLkMjmIvhqCBAI0BrZFU3BMK6S6izJqD2MFcVVb7+SYzUJz0ti5u
        3zLasM02WgnXeZR3OdwAu7AMXRxyTIhy1+HMUt/K2K/umDyCuTVT+A53jk910ekT4GbGjbesjDY
        4M
X-Google-Smtp-Source: AA6agR7/lhkKKG625n3CGJmIMAJbr4gWG/sOy8pBi23P52QZoLOqIdbElGQtnBsHGCnel8Lni/KVxBZY9r4L
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:a14:b0:1fa:bc6e:e5e8 with SMTP id
 gg20-20020a17090b0a1400b001fabc6ee5e8mr125775pjb.1.1661229877885; Mon, 22 Aug
 2022 21:44:37 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:44:33 -0700
Message-Id: <20220823044434.3402413-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v2 0/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
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

Changes in v2:
- Update commit message

Changes in v1:
- Hold hdev->lock for hci_conn_failed

Zhengping Jiang (1):
  Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn

 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

