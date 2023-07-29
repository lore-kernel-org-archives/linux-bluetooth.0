Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C4EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 00:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjG2Ar1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjG2ArY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 20:47:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF53C33
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so4381791e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690591556; x=1691196356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN9ulR1RTIM7xD12Rmyc+n5jrFHxZwEL7KSkU88Qtgg=;
        b=pKeh1vWetNDfZ8Fgpi4sne3SH0xdncjgy1dlbdA0MH/uJ2l+P+eJe+DYMecq3a88Fb
         DyAPeEdWeGyz6L5rOh2CyMf4axq3KYz0DVwSCduqRjCLqLcvHuvhjoGFmC0+LV/Pytwv
         fLEzHTn5pVuF24mefgHckDHzNfWup8U1llFrvdfp3YGKbVphJ3RpNr/1973JQnDPz0rJ
         m2wUco2Q1Eck2sVcJBoOCYINo1PIsTP/OtDjPEjZbe+CTqZnhAYpj9ClkDE+p7kfBMaR
         mWH2jmuQOEk1OzOAcm420hp4Egm4CjyhxSYZBzjLqYkwm+3DORtBnud6esFTGqwBRdvu
         JNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591556; x=1691196356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN9ulR1RTIM7xD12Rmyc+n5jrFHxZwEL7KSkU88Qtgg=;
        b=XGPn2AaS8P5jANoCOT9Ptwf5mzw97XLjxe/LjFPnHx5k7ib4lJ6TgODrDUQm1u+a6O
         fSas6feuZUvnTGeGPLiK++Qg6eWhkg2EZSZbaFioxN9upd5Gt4p9XXadmck3yNAYjCSH
         lHvpVVb5O9DfkG3i0rGwX0tc8uZzfcxqqrPzJNDeyeVRiTD77yJ6FRy5NrkUvHjtE1dl
         PQ8g5tY+mJ+Zru/mC4xCCF5BZBMRHVjjGvMlU8rK37iwfTl/uOFhrMgnVINefl8wLSUz
         AlsbYm5wrx+LM9klqJ6IrlB8zXKQPAkh1stqKyVhBpopv+fBu1BtPkXRysGgCtTduDDH
         W2YQ==
X-Gm-Message-State: ABy/qLZ2/SfvUBkvyzANF0D3TEOGqkZOLCnLkqsN5Ezxs0cykE4pUfQC
        AZ+DJJ+T/67QBKHe+s/CfPUJU5pQ9MhtCyH6Z9o=
X-Google-Smtp-Source: APBJJlGLaSzgCIiaZKlOJwOSi+nv3nAC73T34OD708czi/Wa21h4qBbYCTjeQNOJx8AOv/GooC/aJQ==
X-Received: by 2002:a05:6512:ad6:b0:4fb:8ee0:b8a5 with SMTP id n22-20020a0565120ad600b004fb8ee0b8a5mr2976878lfu.46.1690591556195;
        Fri, 28 Jul 2023 17:45:56 -0700 (PDT)
Received: from rymek.localdomain (217.96.255.138.ipv4.supernova.orange.pl. [217.96.255.138])
        by smtp.gmail.com with ESMTPSA id r25-20020ac24d19000000b004fe1f1c0ee4sm617746lfi.82.2023.07.28.17.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:45:55 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 2/5] monitor: Update le event mask with bits 20-23
Date:   Sat, 29 Jul 2023 02:45:49 +0200
Message-Id: <20230729004552.1422547-3-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/packet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index c7c0308db..fd8df7a8b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3087,6 +3087,10 @@ static const struct bitfield_data events_le_table[] = {
 	{ 17, "LE Extended Advertising Set Terminated"	},
 	{ 18, "LE Scan Request Received"		},
 	{ 19, "LE Channel Selection Algorithm"		},
+	{ 20, "LE Connectionless IQ Report"		},
+	{ 21, "LE Connection IQ Report"			},
+	{ 22, "LE CTE Request Failed"			},
+	{ 23, "LE Periodic Advertising Sync Transfer Rvc"},
 	{ 24, "LE CIS Established"			},
 	{ 25, "LE CIS Request"				},
 	{ 26, "LE Create BIG Complete"			},
-- 
2.34.1

