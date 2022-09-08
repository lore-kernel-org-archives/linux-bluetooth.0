Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BEDC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 21:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIHVVj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHVVi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 17:21:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE78513E9C
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 14:21:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t70so12105007pgc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Sep 2022 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=uZIzmuvhSCygugDShmUo3/ffm1op0ZfZWD1Mt8rYNQk=;
        b=koQVxZeTw+2LPUYzZOse91pDsCIjCx2M9+0LBbE5iJr9KKMVrwXCWKsZ7JCovKocZj
         tVhJMny0kYtA+UKf5OcSktbGi5Ly54EB/7hJ1DiLtnF1ILTqUE2JZp1mSpnj+8wzIAY9
         j6U8C5gHUhN5mj7sD9Bx+7devRmm6+S/PkeFVgZn0Pxsvxn3vAyTKbV+ZQgqQPAp6Nmw
         ++i3qYdIFwSJRcnRZWzFXjVWbknzws6bv2b55JQxiegqk6EURHvp6l+EB3Q2cOw8KxCy
         6iYqtCI6xrOz6ruHgI3vWnXvaY5C2N7d+3Kx14miF+pBW2yKaBHB3duNN2nBPUcEhMa9
         qDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=uZIzmuvhSCygugDShmUo3/ffm1op0ZfZWD1Mt8rYNQk=;
        b=4S6Ta78FLbgZSm8t+w0CeqH+YjAuLffYb8gy+cqx0kACWuBy9iI7h8Y3oslEhG27E9
         8USey/cfC+pbPA4xiVJVRuv0/q7s0OpbB6ObWf1Exj/GO/9pTNQq0TF0l5NJuNV/92go
         8SSa0gajejoCWvRhELjs8YUoV+AKlECHMK7rFKJ7jBeNkhHQ7moYGnRtVessNwldNF2+
         XONrE6zUPXeexqsL3Bqf9euc2cRYQbIIZu4SfVSn+k/TrihGospWpEZJ9+MDr2Wh/e+M
         L1BE8+xfB9/zgEIgUjXqqIgfPcwxgHCXabklyPEU+xxNKCcn3/w0KC+k3jo/v+VttE2a
         OEuA==
X-Gm-Message-State: ACgBeo2VH02ihuvfSCcr0hq2QHK16HbyMWjSwDPmpD19jfnUyDHqmMsx
        C5TivyjgFc2+Trq7LDFZ4EHfS9to2Ygsag==
X-Google-Smtp-Source: AA6agR5PNHJfmAWrjrXUTyisacgT6J4E8myN9NEPOAHmHT9ednPfg9nHeGNgWnXkFI/Z/7eFcNiIVA==
X-Received: by 2002:a63:4b5e:0:b0:41d:e04b:4515 with SMTP id k30-20020a634b5e000000b0041de04b4515mr9196125pgl.100.1662672096723;
        Thu, 08 Sep 2022 14:21:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902e95000b0017541ecdcfesm14906222pll.229.2022.09.08.14.21.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:21:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix HCIGETDEVINFO regression
Date:   Thu,  8 Sep 2022 14:21:35 -0700
Message-Id: <20220908212135.3543626-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Recent changes breaks HCIGETDEVINFO since it changes the size of
hci_dev_info.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 0520e21ab698..9949870f7d78 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -124,8 +124,6 @@ struct hci_dev_info {
 	__u16 acl_pkts;
 	__u16 sco_mtu;
 	__u16 sco_pkts;
-	__u16 iso_mtu;
-	__u16 iso_pkts;
 
 	struct hci_dev_stats stat;
 };
-- 
2.37.2

