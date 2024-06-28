Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E5D2E5
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593227; cv=none; b=NG9GOCKory1hLKCIERyqSCsE/ZQ+hLmnwhqgfW5JvyT0Iw2bHe4aqBskvj50wecKPN1ZEmWWMg/eCXaHa4RFj8upVAYQ6vgen3ddTBkKQPRssaW4py2AncZ9ShzGhyqjRaXMQ54SuY6R/tOCy/v9UJ3je/TQJXzzchI1zATrb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593227; c=relaxed/simple;
	bh=p20ejLKdvCU/3URq16KIqjJK83eX1LezeXiC8IDLNb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DFc+u6fBB83SXU0/GDcBS37dAlqC1MJiAEKhoKh4unjSGsJTA20xCIhr/tvP6ajZvmzG0vQUrtrEmaOZy4yN66nWMUzfnz9jCwfElR9mDhpAVQA3TSCUKrIM33hDFlOtNTFtptDs8QUF54vGPEuCyj8Cc5ilBfP+sH0hDma9las=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anyGeQlS; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anyGeQlS"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80f6525a0c2so254691241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719593224; x=1720198024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRD5dLdGtkO/Gix7WtjHG2m2ijNexEx8WM/0tlXfUVM=;
        b=anyGeQlSbbJh7Ebx1FPtPYi+69g6ukyP7Pf6QSKXmhJNczCPHmmCqD0ogfbjzIN8Q/
         u3edwoy2Y2Doz8kSrbFoO7DajczhqX9rP71JYqrCglDlEbml4pCQRWoAbHn1H4vhNNI7
         VoDH6x/FxT89iBxCjO1qwjPiuJ0PHIZqbbcqxEvwH0OcOVawRI7JVjczwqzFanDegdu7
         dO4AgaSLyk7xEUmnezV+NCG9ZUzu3eGmj5LB1lRdEqYB+pTJ7+4WO2M2GTFdOEQQsJ4/
         jJXwKCwdkBJjIZZ8vphKRU16FoKqn/d/JsDjuF0RBzNv2/jf0ZzaQdUeYKnkPkvpDCm/
         c7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719593224; x=1720198024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRD5dLdGtkO/Gix7WtjHG2m2ijNexEx8WM/0tlXfUVM=;
        b=slxsDBUYtFfrkrSPqe6TmzpjVqnnwtnoSHa3cQTsVj75u4JISk5bCH3J711II/4H7V
         conrVs1dh1JVO5GRSaR0ezQe6CQ9Tu+L1j2ohod70uo99Zb/+gHP6dB9CsSg9okvCtF3
         oIyS4Uwz8lpqO5pNjhibr1DcOQfWmMDiAcG08x1jxmNrelRU8j1tsgYRQlzzd7CvJxxB
         jz3QpOc+FQ1SVZPUp8M7E27PjABg3hOsRjUp/+ghCqoufi32fzxxuYljtDJXlzYn1RqG
         le1XR8Isr4J6n8kiTEfZ5VOls+u+JoJNOqxgH8p37+ugy0/FPAHcWR0WIl9FO9fHDdzm
         R9kg==
X-Gm-Message-State: AOJu0YydSGjxjnWU05OdDPfxajsSmJb9Fx/oq5G6rwioReCdrewt1TB5
	UwYgpVbpejxcYAvFfrFNT0SZKuiVCTnDC34Os0EftUI/6wAzJTVXicms9g==
X-Google-Smtp-Source: AGHT+IGBTfxCADuqO0LZ/P5EBFSjK9J+45qet43HCBPKjYx66WFIyFLvZYUrdDTv3oi/cOzvuPQc0w==
X-Received: by 2002:a05:6102:2255:b0:48d:a159:dd80 with SMTP id ada2fe7eead31-48f4efecd1dmr17737408137.12.1719593223793;
        Fri, 28 Jun 2024 09:47:03 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80fdda531b8sm273373241.16.2024.06.28.09.47.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:47:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable
Date: Fri, 28 Jun 2024 12:47:00 -0400
Message-ID: <20240628164701.626148-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This promotes experimental properties to stable since they have been in
use for quite a while without any changes.
---
 doc/org.bluez.LEAdvertisement.rst      | 28 +++++++++++++-------------
 doc/org.bluez.LEAdvertisingManager.rst | 12 +++++------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index 4609bde74a5e..d3f9cc480470 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -83,8 +83,8 @@ dict ServiceData
 	Service Data elements to include. The keys are the UUID to associate
 	with the data.
 
-dict Data [Experimental]
-````````````````````````
+dict Data
+`````````
 
 	Advertising Data to include. Key is the advertising type and value is
 	the data as byte array.
@@ -101,8 +101,8 @@ dict Data [Experimental]
 		<Transport Discovery> <Organization Flags...>
 		0x26                   0x01         0x01...
 
-bool Discoverable [Experimental]
-````````````````````````````````
+bool Discoverable
+`````````````````
 
 	Advertise as general discoverable. When present this will override
 	adapter Discoverable property.
@@ -110,8 +110,8 @@ bool Discoverable [Experimental]
 	Note: This property shall not be set when **Type** is set to
 	"broadcast".
 
-uint16 DiscoverableTimeout [Experimental]
-`````````````````````````````````````````
+uint16 DiscoverableTimeout
+``````````````````````````
 
 	The discoverable timeout in seconds. A value of zero means that the
 	timeout is disabled and it will stay in discoverable/limited mode
@@ -158,8 +158,8 @@ uint16_t Timeout
 	Timeout of the advertisement in seconds. This defines the lifetime of
 	the advertisement.
 
-string SecondaryChannel [Experimental]
-``````````````````````````````````````
+string SecondaryChannel
+```````````````````````
 
 	Secondary channel to be used. Primary channel is always set to "1M"
 	except when "Coded" is set.
@@ -170,24 +170,24 @@ string SecondaryChannel [Experimental]
 	:"2M":
 	:"Coded":
 
-uint32 MinInterval [Experimental]
-`````````````````````````````````
+uint32 MinInterval
+``````````````````
 
 	Minimum advertising interval to be used by the advertising set, in
 	milliseconds. Acceptable values are in the range [20ms, 10,485s].
 	If the provided MinInterval is larger than the provided MaxInterval,
 	the registration will return failure.
 
-uint32 MaxInterval [Experimental]
-`````````````````````````````````
+uint32 MaxInterval
+``````````````````
 
 	Maximum advertising interval to be used by the advertising set, in
 	milliseconds. Acceptable values are in the range [20ms, 10,485s]. If the
 	provided MinInterval is larger than the provided MaxInterval, the
 	registration will return failure.
 
-int16 TxPower [Experimental]
-````````````````````````````
+int16 TxPower
+`````````````
 
 	Requested transmission power of this advertising set. The provided value
 	is used only if the "CanSetTxPower" feature is enabled on the
diff --git a/doc/org.bluez.LEAdvertisingManager.rst b/doc/org.bluez.LEAdvertisingManager.rst
index b9d5cafc6ff3..7f6359dff1f8 100644
--- a/doc/org.bluez.LEAdvertisingManager.rst
+++ b/doc/org.bluez.LEAdvertisingManager.rst
@@ -89,8 +89,8 @@ array{string} SupportedIncludes [readonly]
 	:"local-name":
 	:"rsi":
 
-array{string} SupportedSecondaryChannels [readonly, Experimental]
-`````````````````````````````````````````````````````````````````
+array{string} SupportedSecondaryChannels [readonly]
+```````````````````````````````````````````````````
 
 	List of supported Secondary channels. Secondary channels can be used to
 	advertise with the corresponding PHY.
@@ -101,8 +101,8 @@ array{string} SupportedSecondaryChannels [readonly, Experimental]
 	:"2M":
 	:"Coded":
 
-dict SupportedCapabilities [readonly, Experimental]
-```````````````````````````````````````````````````
+dict SupportedCapabilities [readonly]
+`````````````````````````````````````
 
 	Enumerates Advertising-related controller capabilities useful to the
 	client.
@@ -125,8 +125,8 @@ dict SupportedCapabilities [readonly, Experimental]
 
 		Max advertising tx power (dBm)
 
-array{string} SupportedFeatures [readonly,optional,Experimental]
-````````````````````````````````````````````````````````````````
+array{string} SupportedFeatures [readonly,optional]
+```````````````````````````````````````````````````
 
 	List of supported platform features. If no features are available on
 	the platform, the SupportedFeatures array will be empty.
-- 
2.45.2

