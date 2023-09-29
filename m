Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445CDE71D21
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 13:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjI2NIL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjI2NIK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 09:08:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BC1A4
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:08:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-406402933edso57543885e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695992887; x=1696597687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i463V6Kf95PbSaQD87pqeomJqLahMJGQW7ThJvb+fAQ=;
        b=iCoYDyFhyBNzlmoIJ0ig/TsfthjR8NEd7eOlEnNXyuu3GIXMQ6MxbHKplxslFoVJoF
         UOc+nNK3biILDhhTtXStxShpbX0Wy+yC9tCHNMvJQoDw66fBC4/LvosN4gVce/NY8jTM
         vYoVqH9aG3R7R/eM9KU01Nak7NQbs+O6mExsaW3H18DEGFulvNVRMV2w+5PmWTIa2yhB
         N86TfAeEJ2HgWENbNLQkmiIJF6wWJnvKR5S46n9rMQE360VhSUXdDAGsn35ipXDn7a18
         sw9kvWuemea1mUp3U048WKFcFVG2vsiK9JRCB29jx4Rb0XiifEZXGQKzVQ89YxahIdML
         6z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992887; x=1696597687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i463V6Kf95PbSaQD87pqeomJqLahMJGQW7ThJvb+fAQ=;
        b=khp22N8JChZpklfJyrI9p63d5+5dzi6MKEt8FFwMj0srHXuPQY9d39HX72OhMvlA9p
         3FLgEOysUHv2RnRVH6zF08ycMGAZSLYiF1gtHDoawR4vQjGPOLDgQF5ILr4jwV/4ypXr
         1wF/jpUs8v3xac1fdn268PxWwiSXio+E0SJxBIpgyPdB1VO8wiqV0pEEGD+oLHNWHVtS
         USeHpsdRbjbFv0Bbtah9MKNUAL0xaPJzMcy/z1Mu1ZYEqhPb6NAcVN30oRrBc9kqq63N
         5SPcgymYM524O8sUCU3Zl+MSdBdcsf2uoZPF4aqa/Ke6sU21P5BMd/t0Ojy7G9KJyk9g
         qnqg==
X-Gm-Message-State: AOJu0YxDtBowbaM6daRFQYMvdyGj0RP0SefU9bgTbAsN/cSBZFkZ787D
        ultdWR1wGWwJ3esCC1t6r0vEz7LIBLNIhQ==
X-Google-Smtp-Source: AGHT+IEn8vQ9NdEH+MILKTqqK3gMK/7aDEwHjOCwdKtlKJn58qeDKcNkuLyHlR14LlS+4l7V6C70GA==
X-Received: by 2002:a05:600c:293:b0:401:1b58:72f7 with SMTP id 19-20020a05600c029300b004011b5872f7mr4106225wmk.38.1695992885979;
        Fri, 29 Sep 2023 06:08:05 -0700 (PDT)
Received: from vibhavp-vivobook.lan ([2401:4900:1c53:793f:bf1d:92a:6f4f:5e80])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c224600b00403b63e87f2sm1409099wmm.32.2023.09.29.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:08:05 -0700 (PDT)
From:   vibhavp@gmail.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ v2 2/2] adapter-api: Add docs for properties Manufacturer and Version.
Date:   Fri, 29 Sep 2023 18:37:25 +0530
Message-ID: <20230929130742.146571-2-vibhavp@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929130742.146571-1-vibhavp@gmail.com>
References: <20230929130742.146571-1-vibhavp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Vibhav Pant <vibhavp@gmail.com>

---
 doc/adapter-api.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index d38ce7171..10c290c62 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -360,3 +360,14 @@ Properties	string Address [readonly]
 
 			List of 128-bit UUIDs that represents the experimental
 			features currently enabled.
+
+		uint16 Manufacturer [readonly]
+
+			The manufacturer of the device, as a uint16 company
+			identifier defined by the Core Bluetooth Specification.
+
+		byte Version [readonly]
+
+			The Bluetooth version supported by the device, as a
+			core version code defined by the Core Bluetooth
+			Specification.
-- 
2.42.0

