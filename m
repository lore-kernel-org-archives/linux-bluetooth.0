Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFD35295E
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049512; cv=none; b=lr+oupry7Tj+IbOzpWPvTM1+Nru0AJjsbdnn6MbCCySBXVohAFmRrtC6kUTSSlIkCoHF4Ws1d+o43k8Hvrzbtc8C7A2vyV+175tlKpsD0756xl2dxyUAfrS6d8hyw0SsGw67P+l/51wSoqBpatb88uyvih9b8wqBUl4fKW1nMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049512; c=relaxed/simple;
	bh=xsaaMN2INsjRDjgPnXUzBThWQq/HiyoQpwRS0ZRyv98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oDM3zNFrykqfi7YLhY/wvDmnnHtH67/zvXsF0G8dwMYG+uSAhqwVkxahtAajVvn2nESeH2Cna1wediSXw8Cz+7f9GOkRNPFdjRGSAfZ3DlkZUv9AAPA1NM0NOjHfjP2jJqf/Is0mBcTzVlR8wQYCURhlEOFiO07+fGYq7Q1eadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGvrbkmP; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGvrbkmP"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93728bac144so569517241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049509; x=1763654309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7gPnscMRt9XblbUNOxl0DKuJoyR7BTkbacmWMwYAJg=;
        b=JGvrbkmPrM57OTNkW8ThIAXkhlLiVOcUr7uk5ubjBlzHxguHTEXOxCY/7poUS5NCRL
         uTkezTv32QnWW55cXsgEDD2/29l40Yixi3v4yBILRp4icU2e+HOQlfOSlHXFqUVCaLFs
         LsvRbNQ53JBY+ZDUwMzHUh8615hkDfbpPCO/X8EbtzHlRCg297Fawm5DsynaRPSgc0Ge
         67UQCYbXIsoZO68plVjc+T6lV23DP8KeIeOKH2NSG+V1yHnElaNC8IxqmpE/nzllLzVD
         59z//i7OQfuCzsQyIRA4scvAz4spWI4G0CzeCXOxRD94xCIjmpcJcAErZDDTatfj2kEA
         9tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049509; x=1763654309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7gPnscMRt9XblbUNOxl0DKuJoyR7BTkbacmWMwYAJg=;
        b=MhJ6fWxQONkVI/jA4nMfgckUlPdC1SUWCy5VNeT9SB2t9QtPGCnyhqFvvq/8DE1Kko
         5+sh4yhkOvNioEa04IhAFYiD95kBjRh4pN96b/nlZohObI6ibm/k/vcjoNDn+Tcuigjz
         S9G/8aDuNgqB+8SYeS7XxBf5v3mOk4Ezaik+HBdFkXILj/qUaPi/lDchk+O7sFAve+8R
         pDpmf5c90B+FQbApNtU3DFZqQ8kUbO8iyKx/61yZoJL9qr6oY+Ys92phzo5kB3YlO5qo
         i+69hPmzb9RzKzuF1Jq+wysWIPBXl+ilJRyrm9SCVmYQN2WIQ+APAMf4gYray8jEzzfU
         JVQw==
X-Gm-Message-State: AOJu0Yyfv/Vs3NDS4Gegvk3k8E5agf23j+mwfbypvmqEvFJn3TNK44zo
	crxuZUekW9fvDUqD2tl/ZO2xyrSjIdCl1h+3V2bhAU/NDXxzZsSRAlmNRingVQ==
X-Gm-Gg: ASbGncuWy04vmOn8mOIezT/rbA2LTjoXxefsVcpwsLe0JqZYBQLf0fOJTECv/U9q8UA
	uAMphgAMnMEmNMxcyPkRlh16cmnWYYvnFIK2bxdiMdnnA/WzHHx+9FMR/35kTKRWrlqbnYZRXa5
	Zqf+8b3M1nJpxwS+O2cxjyg/n2XNCzEhKpaf9jNhfhhaDOlG1baRhuasz06X1znm20LU/Toa6yZ
	x/fXLLxsrhmdyIoowHfrCNrSwAHT6K+NyWEkjxiduiOfLJRGZu90MLVapWgRQdmD31KJqa6gK4q
	q3pkdZ2SDqQAYiYxoF5sgRC+t9eqeHXRVZvHuaf/30kqcMXYFa0gmdG7RRjYnC9LbR6egJ+oPOf
	83pr06HtodZ8/CqzsObGSl5lQLbaEroWkyidDSsvlr64h3BMpsLL4tNz6PEfdkjhDKFOPAw6ySt
	LZBRM=
X-Google-Smtp-Source: AGHT+IEasZjHDAGpmg/wAf8RF1rFOizbjYc0xc/krhOJCxXNnSFSvtVjF1OnXYLMnMq8qNrEbAHpGw==
X-Received: by 2002:a05:6102:5091:b0:5de:8ce:3cb0 with SMTP id ada2fe7eead31-5dfc55043d5mr61388137.1.1763049509398;
        Thu, 13 Nov 2025 07:58:29 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9376111e98dsm704023241.7.2025.11.13.07.58.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:58:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] monitor: Add page information to print_features_subpage
Date: Thu, 13 Nov 2025 10:58:17 -0500
Message-ID: <20251113155818.2628720-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes print_features_subpage print the page they belong:

> HCI Event: Command Complete (0x0e) plen 253
      LE Read All Local Features (0x08|0x0087) ncmd 1
        Status: Success (0x00)
        Page: 10
        Features[0/0][8]: 403900f301000080
          LL Privacy
          LE 2M PHY
          LE Coded PHY
          LE Extended Advertising
          LE Periodic Advertising
          Periodic Advertising Sync Transfer - Sender
          Periodic Advertising Sync Transfer - Recipient
          Connected Isochronous Stream - Central
          Connected Isochronous Stream - Peripheral
          Isochronous Broadcaster
          Synchronized Receiver
          Connected Isochronous Stream (Host Support)
          LL Extended Feature Set
        Features[1/0][8]: 0000000000000000
        Features[1/1][8]: 0000000000000000
        Features[1/2][8]: 0000000000000000
        Features[2/0][8]: 0000000000000000
        Features[2/1][8]: 0000000000000000
        Features[2/2][8]: 0000000000000000
        Features[3/0][8]: 0000000000000000
        Features[3/1][8]: 0000000000000000
        Features[3/2][8]: 0000000000000000
        Features[4/0][8]: 0000000000000000
        Features[4/1][8]: 0000000000000000
        Features[4/2][8]: 0000000000000000
        Features[5/0][8]: 0000000000000000
        Features[5/1][8]: 0000000000000000
        Features[5/2][8]: 0000000000000000
        Features[6/0][8]: 0000000000000000
        Features[6/1][8]: 0000000000000000
        Features[6/2][8]: 0000000000000000
        Features[7/0][8]: 0000000000000000
        Features[7/1][8]: 0000000000000000
        Features[7/2][8]: 0000000000000000
        Features[8/0][8]: 0000000000000000
        Features[8/1][8]: 0000000000000000
        Features[8/2][8]: 0000000000000000
        Features[9/0][8]: 0000000000000000
        Features[9/1][8]: 0000000000000000
        Features[9/2][8]: 0000000000000000
        Features[10/0][8]: 0000000000000000
        Features[10/1][8]: 0000000000000000
        Features[10/2][8]: 0000000000000000
---
 monitor/packet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 06c0894d8a18..2ae4f8ffff74 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2837,18 +2837,18 @@ static const struct bitfield_data features_msft[] = {
 	{ }
 };
 
-static void print_features_subpage(uint8_t subpages,
+static void print_features_subpage(uint8_t page, uint8_t subpages,
 					const uint8_t *features_array,
 					uint64_t *features)
 {
 	int i, j;
-	char str[16];
+	char str[18];
 
 	for (i = 0; i < subpages; i++) {
 		for (j = 0; j < 8; j++)
 			features[i] |= ((uint64_t) features_array[i * 8 + j])
 					<< (j * 8);
-		sprintf(str, "Features[%u]", i);
+		sprintf(str, "Features[%u/%u]", page, i);
 		print_hex_field(str, &features_array[i * 8], 8);
 	}
 }
@@ -2865,7 +2865,7 @@ static void print_features(uint8_t page, const uint8_t *features_array,
 	if (type == 0x01 && page)
 		subpages = 3;
 
-	print_features_subpage(subpages, features_array, features);
+	print_features_subpage(page, subpages, features_array, features);
 
 	switch (type) {
 	case 0x00:
-- 
2.51.1

