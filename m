Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D571C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 01:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJHBLj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 21:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJHBLg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 21:11:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4871DB48A9
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 18:11:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b2so5934440plc.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 18:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dDCoGNmc7mSsDOR4zzwwci8uBmu2b0a+9pHPilQw+E=;
        b=EzS9r/IGyM97zKDltAkAr33qOF0JlWrk1ALG3bqu+8o3kI6TOUvfWmtsfXGW5447wu
         LPaJHyTq/na9z6mCwNGTfrrt7ZdUisZviaTMkiiHVJ8YhidKBeDwIPV341nd32E9f06F
         tednfhdIyr5jFROVQF6FVLuib4yT4clNkCxnYCrQIH8KScuDJ0JDXSevjYhSPflhMSp0
         KzjdYgsT9v2zHRUeG34dTxPyn0eRhV0QbYPgSgntov/k50W/0wBcwiLOqbsLFvsnD/oi
         32kstApR1yMlRzoFC5I+CKlMDMJCeICL8Jn/sXbdEZgHFgc1nQHDwBX40fFF2dlLwZdh
         XTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dDCoGNmc7mSsDOR4zzwwci8uBmu2b0a+9pHPilQw+E=;
        b=M9nfwQsFxb6gqfqocBtPpNfafDAkzewghfU4X+WbZbTgFBWsihtT9aVqFzW/KTEXVA
         knANXmzztI1vqXMrJ1DF/PcZ+HG196Qufmi2/lVfWz8SnHaHnrLbudsjrM+jLesThDcB
         vBT1kKx4VOr5kEoBeOnfe2Y3dFjjPqvCpkI5PTnWMQD/Fr61FzhRC3llBay6k9nV66Rw
         xeqMxF2i6B38ujEM53i7JFGwev7vvt9J8vTX7m++ECMUfrX/QpBt3Tz4/tL5CO8+0NDV
         tfQMvt/dSwqu4zvgrY3EH/o7389GzdkWLRNtvqAOYrJAlc/DjB/ongSq2BkL4Dx8D0uq
         nB1w==
X-Gm-Message-State: ACrzQf10t7tgrRge31ezeqhvlerP26DjtYDHTecSXxj1LE9E2M0DIGth
        L3DhdApP25rFlUAX/VlnSotHnPjHekLYTw==
X-Google-Smtp-Source: AMsMyM5mVJoqYu1repIV0RkFI91KJr89Z7qvgHWDwfm9y+J3iet60lNDsweygrUqYNmoM5mBWXAPZQ==
X-Received: by 2002:a17:90b:400f:b0:20a:9965:ef08 with SMTP id ie15-20020a17090b400f00b0020a9965ef08mr8442608pjb.155.1665191493244;
        Fri, 07 Oct 2022 18:11:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h187-20020a62dec4000000b0056158a41d74sm2234123pfg.58.2022.10.07.18.11.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 18:11:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_sync: Fix not able to set force_static_address
Date:   Fri,  7 Oct 2022 18:11:29 -0700
Message-Id: <20221008011129.1906898-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221008011129.1906898-1-luiz.dentz@gmail.com>
References: <20221008011129.1906898-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

force_static_address shall be writable while hdev is initing but is not
considered powered yet since the static address is written only when
powered.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 3f401ec5bb0c..b7f682922a16 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -757,7 +757,7 @@ static ssize_t force_static_address_write(struct file *file,
 	bool enable;
 	int err;
 
-	if (test_bit(HCI_UP, &hdev->flags))
+	if (hdev_is_powered(hdev))
 		return -EBUSY;
 
 	err = kstrtobool_from_user(user_buf, count, &enable);
-- 
2.37.3

