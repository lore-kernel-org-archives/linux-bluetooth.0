Return-Path: <SRS0=V5YL=WQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C5C3A589
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892E2214DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 17:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfU8br0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfHTRBp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:01:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41435 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHTRBo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Aug 2019 13:01:44 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so13655788ioj.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2019 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=aS5PNUy2MHt/9aSHzx1Jx8fCt54+FF9VE9gI0rGoi3w=;
        b=JfU8br0IKMAtBeZqIK5B5m9NCInQmFgbbCsttTtM8wd+pzXKy/lRf8kHRV0wjrX6Q7
         eUC08SnBAlFmo03Ij//nargupChAJPBUXzv5gubGHWNZYLNF0WixPHzZpIo59wwPtkPb
         IJC3gurnLYmiNeH28auktMrXl+bq2Qv7Pa8Fdvnx9OuWqgIuULXDoTypyRgxDuCmjsdc
         qRunJ5KTX5mSIpFaudBxiYC9X4Cm5IL3OADaARHCEzAgL2vpxL/g/Tru4z+NFPTidEJo
         GUIN4MWDWVq9aCFbo8BYFbyT29V9FKitssLTmvXxQ/VT04U7fEs1+YzUaAaJWctw7qzI
         y88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=aS5PNUy2MHt/9aSHzx1Jx8fCt54+FF9VE9gI0rGoi3w=;
        b=sU4aa2BJpjB7NxLykOIRJKHkMkvUa9MzAV/WlquMD/b56VsghbB4VWdtDjuyYPt2Mq
         P/QUKaWZa+n+oFGuWZlVLzQENS0QBkuGCq4BjFxKI35oRanTYU76qHqAgiQKkDIgN6zi
         hyutP+2JVCWC6BBHzEAClbcToXnrC4+3skTeUjHhg9Ed7AL8ZAYDyM68UtWoTdEE5i22
         eg2ZMjySWp6ZNF6GKLUxsKJy7OVRilx1/XpcBSj8vVt5PwhEglhMeWM34vbZ6hwN3FZA
         4w2qJxT/YN6buPrceuiUV3R4R9zV8J0CH+sfa2+B9+Vvpv7qQ5eHny7eDyL8tNYDrzaX
         2b/g==
X-Gm-Message-State: APjAAAUINFTejPpw/NqKmJFrqmgYLW3aBLb58DQ8Wwdx314is05R4xKW
        7WpMBDmVdG3sl2VTw6+UeDmS1iW+3oQ=
X-Google-Smtp-Source: APXvYqwWk1CqcI3FFqMFzplFRLQZtADOgcNZIApuHOQa4Vs4M85V0sNdtPFttofmdtlyxaoyXh/9pQ==
X-Received: by 2002:a02:495:: with SMTP id 143mr4735961jab.94.1566320503947;
        Tue, 20 Aug 2019 10:01:43 -0700 (PDT)
Received: from [10.1.1.187] ([8.39.228.178])
        by smtp.gmail.com with ESMTPSA id v13sm13909880ioq.13.2019.08.20.10.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 10:01:42 -0700 (PDT)
Reply-To: Carey Sonsino <csonsino@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Carey Sonsino <csonsino@gmail.com>
Subject: [PATCH 1/1] bluetooth: update default BLE connection interval bounds
Message-ID: <1c707bb9-999b-7ca3-3c91-7b183dacfdd5@gmail.com>
Date:   Tue, 20 Aug 2019 11:01:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update the default BLE connection interval min/max bounds to the full 
range of permitted values (6-3200, corresponding to 7.25-4000ms).

Commit c49a8682fc5d298d44e8d911f4fa14690ea9485e introduced a bounds 
check on connection interval update requests, but the default min/max 
values were left at 24-40 (30-50ms) which caused problems for devices 
that want to negotiate connection intervals outside of those bounds.

Setting the default min/max connection interval to the full allowable 
range in the bluetooth specification restores the default Linux behavior 
of allowing remote devices to negotiate their desired connection 
interval, while still permitting the system administrator to later 
narrow the range.

Fixes c49a8682fc5d: (validate BLE connection interval updates)

Signed-off-by: Carey Sonsino <csonsino@gmail.com>

---

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 04bc79359a17..f4f2f712c527 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3181,8 +3181,8 @@ struct hci_dev *hci_alloc_dev(void)
      hdev->le_adv_max_interval = 0x0800;
      hdev->le_scan_interval = 0x0060;
      hdev->le_scan_window = 0x0030;
-    hdev->le_conn_min_interval = 0x0018;
-    hdev->le_conn_max_interval = 0x0028;
+    hdev->le_conn_min_interval = 0x0006;
+    hdev->le_conn_max_interval = 0x0c80;
      hdev->le_conn_latency = 0x0000;
      hdev->le_supv_timeout = 0x002a;
      hdev->le_def_tx_len = 0x001b;

