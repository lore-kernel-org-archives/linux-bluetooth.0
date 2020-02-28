Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDDC3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C6A246B7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAE41cfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB1XrG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:06 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:33922 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgB1XrF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:05 -0500
Received: by mail-pj1-f45.google.com with SMTP id f2so4702733pjq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a4mt3tuBEtrcFQaO04FkgRzkU5NWsbNKqrXQXndd3Lo=;
        b=JAE41cfzDEddUoF89z01cmKJCa1ICMR9riB04GVa9TLtSknXNHkpIhyyppzRG53vzz
         oDDlUJSbi00CAGUrQYi6DafximPtDrQ1fWeMxJK8vCs4CY8jk8qHkt8J4XWnaJOUu251
         8GtmkHypZ1exTEl3lYL9KVrymahP1MJI2ePCtuIXsOAcxZfeBB2wgNUPk+wAqRb9uztF
         BHwqk6++kEmceWxEyDaGrxTF2kFefVKSExvVLIf0RK63Qd7QRLDc7xClGDrmaUCWw9aq
         3kam9VAO5+FAoO5VjIiEAhLyXuyaBSbg6Tjt8T4jIg9hl5yPoYew9qdMFDduvaaq1zx0
         WNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4mt3tuBEtrcFQaO04FkgRzkU5NWsbNKqrXQXndd3Lo=;
        b=HbGTZ4yrGL0yPwPbwcBfuZfiDz0++fZeHgM2k1y55RYmj6cmfS0cxITModReyGvh5j
         JAFQ9dVNCFKF82N7BRKtYQbVrfesRVwIDBod7Ymoa0vQajO+3NxV8XpyPc7Ca4qJoSw9
         mK4msGW74E/AIfqCC2MOjibRspowaFcCv+IyMLPASxNdw/6pf6neIW/3IF2ijNJrTVhA
         aCam9+Bi+kp9MapQEEkHScS5YbZ9Wc5Ya/wD4BohEyy6S1OJHe/5GznQkYTWDZqPlk6U
         2FGn0q8SlnJyW1VKeR+VTwwaHPG67shQE4wlZontk5siw6ZaKSv1x8b6DPSnX2eEghcA
         c4SA==
X-Gm-Message-State: APjAAAVOH2dOk50cmmjkjoWIcB7GkGyyWRjxT1jxxWap9ou8jqctC9Pk
        GY5FIXX+cwrMTg2hFome8ppxVUaRAkk=
X-Google-Smtp-Source: APXvYqwblYvciv7f7kHmDiW0jcNlt2mK1qRYN2plv6ZAr9Rs3xy9LrI88P8X2YIIRAdtYLuJZPMc4Q==
X-Received: by 2002:a17:90a:17e5:: with SMTP id q92mr7484160pja.28.1582933624183;
        Fri, 28 Feb 2020 15:47:04 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/12] lib: Add definitions for Enhanced Credits Based Mode
Date:   Fri, 28 Feb 2020 15:46:50 -0800
Message-Id: <20200228234701.14614-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228234701.14614-1-luiz.dentz@gmail.com>
References: <20200228234701.14614-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/bluetooth.h | 2 ++
 lib/l2cap.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index d14217eac..47521d50e 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,8 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/lib/l2cap.h b/lib/l2cap.h
index 5ce94c4ee..f9ceb2f33 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -197,6 +197,7 @@ typedef struct {
 #define L2CAP_MODE_FLOWCTL	0x02
 #define L2CAP_MODE_ERTM		0x03
 #define L2CAP_MODE_STREAMING	0x04
+#define L2CAP_MODE_EXT_FLOWCTL	0x81
 
 #define L2CAP_SERVTYPE_NOTRAFFIC	0x00
 #define L2CAP_SERVTYPE_BESTEFFORT	0x01
-- 
2.21.1

