Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E7267B67
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107182; cv=none; b=RQ0E3SVUeQwVPMR5GO07mf/ITmTjNjwZoFMGxsqjlxnFGboRTQWfkHhnSARHZboH/BmNwcMC6C7k5c+5unNPypIX9n7Iao3SOcfJQ3gSHnCzklAiOoo/OD4X7z+EOkxiZw8WSbNqixDjQ1DcVwNKx5e+9ClrAFkd6E8Tx2KZGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107182; c=relaxed/simple;
	bh=3nPlrs9qba3GEz4h7LBcqx1yUs1HTSapaLlgBggZ4VM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dSC5OhlIY4KEINYO0Qkr3I+2Xbb4hS6NOF2ngfeQXaLw5dEv6xfAgLK2uH2T2X3rUhX086KZOiAmkZzsIn5rJ/JKOFlUH51IK4kn7g10qxjse1MgihyieNwxNiL6LqWuixA7YWc1Ut9Ut+rhlS0UrbMDYEQtdAU8/+EVlgv76sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+OHlatj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+OHlatj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso653468166b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107177; x=1744711977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVQieKdrrEJrsqoGUiwq8RLWLLgJdxqk32LLYX5HjhI=;
        b=I+OHlatjiaeccKAS85NOJVpIDEaJS7RGSVo1pjc/GTjlakm8m/cte9tPdfQY/KVgKI
         TCtGGsbbkVam8mDzzTk4Ga7tszsGY0+1dePNujkfgvwWG7D0867UdC0Di3x9dvepkzR/
         sTDXfGQWGzBwEDHc6QL3cRWxkS9XcOkfowL4KEseZaRv5TpLbIpp1PC1ASLMBzbg1eGe
         9HZ+Qte991/dh8u6vU3wSjtyLT2onos2SXQxPn9C+u79tieBSsA4RTOKTJE59uYbX7GU
         6qRXbJdENa1uzXHQrpMiV1PMX7D9GBC/exy6uf+6pA427DTHmugdF9hX97L4VNNYqRjC
         qZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107177; x=1744711977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVQieKdrrEJrsqoGUiwq8RLWLLgJdxqk32LLYX5HjhI=;
        b=rFhua45J77edZ4zmKJXY+2j0rpIfjsXS1mKKR83b4x0djnY5wu62YEBnsDls78IwI/
         RJ8E26T5cjBxeleAd5XsN0dt5UH82bTF9fKsJT6VKmN5ilHBhEuD4FNGq6pujK7pHaYb
         QXrhTO2LNaS2WzHYht0QPfE1hFSjWVvVHnfO2U/JCZB1pUwQCvdcm+PFH+0Le6d2y3Dn
         nOTtRGtLJiteG/Hfd4r/PBvfHxCdDz9GZdDeUIUGg9QtuJWFyYRBqTFdJv8D6W0+aHEB
         2hjmeTMTU1t01MecDo5AYAKmJbx57YAMoT2pYpCPS1SNLHe61zWA5m6oWrOzxjEvt7/K
         tmuA==
X-Gm-Message-State: AOJu0YyBWIn1p1f7ave4bdImSskbBGEoWREeUBffFa6jGvYYXb/HXh3k
	v7tgTHriGl6VGtyU7khANakcg803dG5r8I5pOiqZm0gsl8a7nAfu3LqyPNxU
X-Gm-Gg: ASbGncuJrN55OEI5CG2sA83ZutrPMUE3qWB0R94wFsW8L4SAV197wJU0uO9cFT3pEKD
	gUe5FiPcvkiom9O2M4UAiny8bYxssPny0wz8EGYx2UFFlkCFbkpxV1DTokJq7U9ruzpzkRpLF+i
	4FSaoOCOFWbDTBJfNKaexVxsIabiaMaRj+h8IsX05FeFIgLVknM7mK3U91SbTmzFRqRsdef+pEQ
	nK6kTqBr3MvlUzUgwElUsmyEEttWuFt+UVKKIPsac1mekc22lM1PRpqA6ik/R1VGI0KHtUb7LHQ
	etuxWDOiTUaKt/jxhdO8L8jhVf0Wq5HZUZnDBObJsXNJrgQ7m+m8zkp9DJQlFQPhCjHbetF/keb
	EtigdZd3WiRT5Z4GLMWQNTx2fPkilDwZ7TLLXRw==
X-Google-Smtp-Source: AGHT+IFVwbm6WgvNNSVNhpNPBEIrehOvE2IB6iwFDH5jLDwUh7yy0QPJuR1cM76Eu0+gBehGh0b43w==
X-Received: by 2002:a17:907:d91:b0:ac3:773:62a7 with SMTP id a640c23a62f3a-ac7d18c1c7amr1372654366b.31.1744107177178;
        Tue, 08 Apr 2025 03:12:57 -0700 (PDT)
Received: from localhost.localdomain (46.205.201.86.nat.ftth.dynamic.t-mobile.pl. [46.205.201.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013ebbdsm894389266b.93.2025.04.08.03.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:12:56 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] doc: Fix various typos in D-Bus interface documentation
Date: Tue,  8 Apr 2025 12:12:43 +0200
Message-Id: <20250408101243.6010-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/org.bluez.AdvertisementMonitorManager.rst | 6 +++---
 doc/org.bluez.Agent.rst                       | 2 +-
 doc/org.bluez.AgentManager.rst                | 3 +--
 doc/org.bluez.GattCharacteristic.rst          | 4 ++--
 doc/org.bluez.GattDescriptor.rst              | 2 +-
 doc/org.bluez.LEAdvertisement.rst             | 4 ++--
 doc/org.bluez.LEAdvertisingManager.rst        | 2 +-
 doc/org.bluez.Media.rst                       | 6 +++---
 doc/org.bluez.obex.Agent.rst                  | 2 +-
 doc/org.bluez.obex.AgentManager.rst           | 2 +-
 doc/org.bluez.obex.FileTransfer.rst           | 2 +-
 11 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/doc/org.bluez.AdvertisementMonitorManager.rst b/doc/org.bluez.AdvertisementMonitorManager.rst
index 3775a4835..477a0e9e2 100644
--- a/doc/org.bluez.AdvertisementMonitorManager.rst
+++ b/doc/org.bluez.AdvertisementMonitorManager.rst
@@ -14,9 +14,9 @@ BlueZ D-Bus AdvertisementMonitorManager API documentation
 Interface
 =========
 
-Service		org.bluez
-Interface	org.bluez.AdvertisementMonitorManager1 [experimental]
-Object path	/org/bluez/{hci0,hci1,...}
+:Service:	org.bluez
+:Interface:	org.bluez.AdvertisementMonitorManager1 [experimental]
+:Object path:	/org/bluez/{hci0,hci1,...}
 
 Methods
 -------
diff --git a/doc/org.bluez.Agent.rst b/doc/org.bluez.Agent.rst
index 11d09b94d..6b6d75edb 100644
--- a/doc/org.bluez.Agent.rst
+++ b/doc/org.bluez.Agent.rst
@@ -9,7 +9,7 @@ BlueZ D-Bus Agent API documentation
 :Version: BlueZ
 :Date: October 2023
 :Manual section: 5
-:Manual group: Linux System Administration
+:Manual group: Linux System Administration
 
 Interface
 =========
diff --git a/doc/org.bluez.AgentManager.rst b/doc/org.bluez.AgentManager.rst
index dfc0297da..fadadecb1 100644
--- a/doc/org.bluez.AgentManager.rst
+++ b/doc/org.bluez.AgentManager.rst
@@ -9,7 +9,7 @@ BlueZ D-Bus AgentManager API documentation
 :Version: BlueZ
 :Date: October 2023
 :Manual section: 5
-:Manual group: Linux System Administration
+:Manual group: Linux System Administration
 
 Interface
 =========
@@ -80,4 +80,3 @@ void RequestDefaultAgent(object agent)
 	Possible errors:
 
 	:org.bluez.Error.DoesNotExist:
-
diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index 7b1b3fbb5..bdb3476fb 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -50,11 +50,11 @@ array{byte} ReadValue(dict options)
 
 	Possible options:
 
-	:uint16_t offset:
+	:uint16 offset:
 
 		Read start offset in bytes.
 
-	:uint16_t mtu (server only):
+	:uint16 mtu (server only):
 
 		Exchange MTU in bytes.
 
diff --git a/doc/org.bluez.GattDescriptor.rst b/doc/org.bluez.GattDescriptor.rst
index f4497c6d5..536ef0ca7 100644
--- a/doc/org.bluez.GattDescriptor.rst
+++ b/doc/org.bluez.GattDescriptor.rst
@@ -50,7 +50,7 @@ array{byte} ReadValue(dict flags)
 
 	Possible options:
 
-	:uint16_t offset:
+	:uint16 offset:
 
 		Read start offset in bytes.
 
diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index bab507439..b998f40a2 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -177,13 +177,13 @@ uint16 Appearance [readonly, optional]
 
 	Possible values: as found on GAP Service.
 
-uint16_t Duration [readonly, optional]
+uint16 Duration [readonly, optional]
 ``````````````````````````````````````
 
 	Rotation duration of the advertisement in seconds. If there are other
 	applications advertising no duration is set the default is 2 seconds.
 
-uint16_t Timeout [readonly, optional]
+uint16 Timeout [readonly, optional]
 `````````````````````````````````````
 
 	Timeout of the advertisement in seconds. This defines the lifetime of
diff --git a/doc/org.bluez.LEAdvertisingManager.rst b/doc/org.bluez.LEAdvertisingManager.rst
index 7f6359dff..93eac411a 100644
--- a/doc/org.bluez.LEAdvertisingManager.rst
+++ b/doc/org.bluez.LEAdvertisingManager.rst
@@ -117,7 +117,7 @@ dict SupportedCapabilities [readonly]
 
 		Max advertising scan response length
 
-	;int16 MinTxPower:
+	:int16 MinTxPower:
 
 		Min advertising tx power (dBm)
 
diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
index 678e6090c..ecd982652 100644
--- a/doc/org.bluez.Media.rst
+++ b/doc/org.bluez.Media.rst
@@ -14,9 +14,9 @@ BlueZ D-Bus Media API documentation
 Interface
 =========
 
-:Service: org.bluez
-:Interface: org.bluez.Media1
-:Object path: [variable prefix]/{hci0,hci1,...}
+:Service:	org.bluez
+:Interface:	org.bluez.Media1
+:Object path:	[variable prefix]/{hci0,hci1,...}
 
 Methods
 -------
diff --git a/doc/org.bluez.obex.Agent.rst b/doc/org.bluez.obex.Agent.rst
index b832e278c..74e014570 100644
--- a/doc/org.bluez.obex.Agent.rst
+++ b/doc/org.bluez.obex.Agent.rst
@@ -14,7 +14,7 @@ BlueZ D-Bus OBEX Agent API documentation
 Interface
 =========
 
-;Service:	unique name
+:Service:	unique name
 :Interface:	org.bluez.obex.Agent1
 :Object path:	freely definable
 
diff --git a/doc/org.bluez.obex.AgentManager.rst b/doc/org.bluez.obex.AgentManager.rst
index f18f227bc..cdacd4d2f 100644
--- a/doc/org.bluez.obex.AgentManager.rst
+++ b/doc/org.bluez.obex.AgentManager.rst
@@ -19,7 +19,7 @@ Interface
 :Object path:	/org/bluez/obex
 
 Methods
-```````
+-------
 
 void RegisterAgent(object agent)
 ````````````````````````````````
diff --git a/doc/org.bluez.obex.FileTransfer.rst b/doc/org.bluez.obex.FileTransfer.rst
index 6dce7e59d..b0a2f8495 100644
--- a/doc/org.bluez.obex.FileTransfer.rst
+++ b/doc/org.bluez.obex.FileTransfer.rst
@@ -141,7 +141,7 @@ void MoveFile(string sourcefile, string targetfile)
 
 	Possible errors:
 
-	;org.bluez.obex.Error.InvalidArguments:
+	:org.bluez.obex.Error.InvalidArguments:
 	:org.bluez.obex.Error.Failed:
 
 void Delete(string file)
-- 
2.43.0

