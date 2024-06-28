Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA41E517
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584477; cv=none; b=bFo7ahEo4eNa7aB7MicKve94naHenn6YHCk84vKU05qUnpWoh5rmj0Y/3oZu6P28gRfYOCQUM80VD15WStqYwNWrgQziuLHtYMdZwn/rY8ePDNqhCmsOK093jVFDoWeZJHZlpIZgSVkdC1Fkz82z6JX9MJ/8Npdbuq6dH5TrKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584477; c=relaxed/simple;
	bh=oXSCItITuFksxzqCDmAly1kV5TPcN/AGMkWyYKmvzy4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JaWkMoMqyKQuSOZb4KFOvOTSNE0O48kn3tVlKg+CRQ57oGImZNhTAhnnQOndEluwa8SEcRCEX00xl8uITh1gNVqqbo05/P3bFNWQM/+1SgNjbRUumwKMx/818G48SpP2oOeqbent23aPzkk7YyqrZenqcgS0eScG/CumVZdSO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWQ9TKEM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWQ9TKEM"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-700cbdd90fbso391766a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719584475; x=1720189275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufRtBc5ri5Cu55SSolDDR/J5P4Jer9hVehG4WUdaqHo=;
        b=dWQ9TKEMMJxn+isut9V66sVa7Q2CPnkOm6pAiPtW3fVoplFtU2hP6yJWxFPAEUP7/3
         fSJ37C1WG/WZOzknBZ80MRKobGGoonGTvTQqDNDtC04S0FVzqfp+yrdL17XUZB+9RQ62
         ltRJDf3XN7SX1KeLLiirlOxhLkf99Hc/kxPkwpTknFM6UPVs0HfeITVLzgd6YQPEIrSE
         GGvcEgeybJbDc7I7aHalpaCMzvxWQ2WFZDvXBgSpHfHxz5guLFa9ON+NkOmGpAHb3xha
         /I68tkV4aAcBCRiB4+S1LxtOO+T0VqhpKC0kOtWuieKyYS5VwE+MeLONno2Gf5vSiORR
         y90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719584475; x=1720189275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufRtBc5ri5Cu55SSolDDR/J5P4Jer9hVehG4WUdaqHo=;
        b=TqnINO71hCjHzTr9WqA3xZASgsHfLkU9GxT1KJlY2WEKv/SpEFQ/DE3Nb8unUALLEU
         urLabxXzOXyl3znHVIp33DF8Rd7MhUAUpu35aeOOjG77krSZjbouYk+9L1YtXnrVLMSa
         AdT8DNO7LtxOS+Anu8AU7APfRBN5yxqK93g7Sb6GsFmbXK+QXI3BnfKHSvPAlfryF8M2
         02RI6L3gaFdB7qzScFYaLAFu4lYfoLJACBMRFqjXkqV+2UiAtpDzG00jOKwLlP6hwWJ+
         qQNqlpifMysOnC42q38p4L0SOuiyIY5hkwEGuvMCpEp99m214Kza1H6lwYDCzSLu268q
         31OA==
X-Gm-Message-State: AOJu0YzhcQiZpb7/y59TOgufKGzHErwHTemdoAeitZslg6TZD09BoFKl
	g1T0wT2PyMfIvqkBRRBZkpPlubYD9VLjNhq6ZqBcK+H+h1gsEwjZ8w72jQ==
X-Google-Smtp-Source: AGHT+IGk4fvMluRj72Ttyz7Py/2O4wDpR2IwHnKGeTeNm+J5W0GWRmZX5pkfqqnwxAW7ZI9rIsaRMQ==
X-Received: by 2002:a9d:4d16:0:b0:701:ef44:e69d with SMTP id 46e09a7af769-701ef44e764mr7456992a34.11.1719584474680;
        Fri, 28 Jun 2024 07:21:14 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f29225aba4sm271599e0c.35.2024.06.28.07.21.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:21:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable
Date: Fri, 28 Jun 2024 10:21:11 -0400
Message-ID: <20240628142112.575748-1-luiz.dentz@gmail.com>
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
 doc/org.bluez.LEAdvertisingManager.rst |  8 ++++----
 2 files changed, 18 insertions(+), 18 deletions(-)

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
index b9d5cafc6ff3..713c9f6a5b97 100644
--- a/doc/org.bluez.LEAdvertisingManager.rst
+++ b/doc/org.bluez.LEAdvertisingManager.rst
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

