Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5053F54A2
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335757; cv=none; b=SB9y8kNuTvGmsK+tuANz/FsAB+vf2L6HcrQZTk42ybZO/h5BpQTxbTOuomyPWPCS0bVyriSqDtXKOkRXgvtHQ5+39bLXLP+4ID9mReKn3Jv29WR0VN6ONRfArD7rQufrAXxaoBMZDQJ7SOfgEGEWatR6WAxUexoeWoTIMaEALuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335757; c=relaxed/simple;
	bh=pKrXKHAHgM8UmWEfWJzIvG1JVIMIWl0q2DS0OxkPWOM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvuKFtY/AkqfAbdYjGTNgers0EmGau24ejyNh6R85cztM5Lm5SKJ2Gbr8l/uxjiA3MZmVCK8oS6m4i+Ur7Y62NVcZEjPaQZjtQ6usXfkI7yMBmFmWfhKP8xrOTURsqsvWj+9sKNzslY6+NviHrmmg7GbFc6bgqoKfTQNM/b3TqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG3CaoGK; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG3CaoGK"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so1500833d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335753; x=1773940553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBCN9LMr5Z9gIxbAGBDX3jBphqbQ+6zJYy2rh78SbC0=;
        b=SG3CaoGKH4PmifV2urmr7XI+k4bDKlrIxN2/WwGieGgkoooA4+viey2ATS5wzj2OAQ
         Efli1wfxW8Ys8wYnps9zsZHOBROSim2jyfd/K37rDHE8gWei/j8g8gIaq32xqrTkou28
         LvKpMwOEVL6RSaSYAkorD2JkIOYYaGTjF21kw9y7rA0HEajT/ipJHtt63jXDdR/zS3vm
         pUR7dJGL7CTwSo9i0G/pl2absZFgJJmdWn7TvH8ZHTwfJeexCbO/FOTFUa38lrAEH8rz
         3GEcsItrjEmTX5eyaybTCAF9kNFz/EF+whDktP0xdQNurPJ46bHcHLkd3gWQEAtCH7Q6
         sDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335753; x=1773940553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WBCN9LMr5Z9gIxbAGBDX3jBphqbQ+6zJYy2rh78SbC0=;
        b=iIn7WUXobHzPJM77YjckaKg9cP/iAl42/5vThF0BoVc7NsfeCsnGs0PBS7CX3KoF7e
         J7ZvoKL6v2PlfhJeCD81wr4L4Z/GEUcsqF1nDVBanDLnQVpSIbbiO8Vzckf8vM1yXU36
         LM+SlLMw0S6XABlvs5ZZB0s6Giajs2qhQvIasfiirVH4NZp7X2UFIzlwyg62qci+cR9h
         itrxDkgQJ2OesxXRAfhAuFbcIr7o/qDln5UyItRd7ZlzGl3krhRuGnvtInwMCfw+rB4H
         78x56+UWwFfNG4DHblyQB/4Ef/bS22CJmO1HJdAXs/joGeSxTbYO3ppomgXa6enNaWkt
         gEew==
X-Gm-Message-State: AOJu0YwmdXLbkZgBBYHBdTPsKxnWje9LCfuAqEY5GbXUGwbBwS6PXzYj
	yCTxntefCTB7WVB+oIP0uGubDI80Asc9IkYFYWyLWi40Ms/HxCOxSCXSv5qMUA==
X-Gm-Gg: ATEYQzz/UE9j+jekFBJQ3jAaffh4uz+7wdElsxawz+RYYrqVrW0nl27EELphL4fQhIv
	z0XZgNZq4PjJk79VWBwjpO/KWJ/znfexLCtAkIwsugM5/XFQUil4sSUjJYe3WX8C15y/al3elPn
	9A5svjKQwclL+EulrCr9H1QjgsqCRUa/DJd/RbCJDkP0CKJwjhz4IP2+B7iRfMCmsFnc33Pb7rj
	NpvnaBUqvqGfmqAiBAh15gnh8Uli7/F3/ywBmoeurY33ZT8CL9Nh7+J7v+AOjo/u0UsWJyNVivS
	P2cCS0zee2UjG4JRy6VlWNKnVzwP8ZGORHgBSKqtc9HgZRoiNtgoxPVlz/Ano+2YwZyb+rsSwuR
	GakKKU42VTGncFOjyPZuUZbU3fhTE7G5BmpZz2tjvbaKa/PxU4ty6O93voipckM91Js5nGD3Z1h
	hunrmvmIN/QNRRF3WtO/ZMMn+u90R7x+X3rXXaxE4tRAoJ6rACQn+qBThqIn59K/gvlYKisHoeZ
	DQkom9EimtvpW8QvWV8pTFaW9Rs
X-Received: by 2002:a05:690e:43c6:b0:64a:dbe0:897c with SMTP id 956f58d0204a3-64e63106996mr216021d50.79.1773335753080;
        Thu, 12 Mar 2026 10:15:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d65117a82sm3442572d50.15.2026.03.12.10.15.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:15:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/6] doc/btmon: Split L2CAP Channel Tracking into btmon-l2cap.rst
Date: Thu, 12 Mar 2026 13:15:36 -0400
Message-ID: <20260312171540.1065212-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312171540.1065212-1-luiz.dentz@gmail.com>
References: <20260312171540.1065212-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Move the L2CAP CHANNEL TRACKING section into a standalone file and
replace it with an RST include directive.
---
 doc/btmon-l2cap.rst | 196 ++++++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst       | 191 +-----------------------------------------
 2 files changed, 197 insertions(+), 190 deletions(-)
 create mode 100644 doc/btmon-l2cap.rst

diff --git a/doc/btmon-l2cap.rst b/doc/btmon-l2cap.rst
new file mode 100644
index 000000000000..7154898c00f4
--- /dev/null
+++ b/doc/btmon-l2cap.rst
@@ -0,0 +1,196 @@
+=================================
+btmon: L2CAP Channel Tracking
+=================================
+
+.. This file is included by btmon.rst.
+
+L2CAP CHANNEL TRACKING
+=======================
+
+L2CAP (Logical Link Control and Adaptation Protocol) multiplexes
+multiple logical channels over a single ACL connection. btmon decodes
+L2CAP signaling automatically and routes data to higher-layer protocol
+decoders based on the channel.
+
+Fixed Channels
+--------------
+
+Fixed channels have pre-assigned Channel Identifiers (CIDs) and do
+not require signaling to establish:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 30 60
+
+   * - CID
+     - Protocol
+     - Description
+   * - 0x0001
+     - L2CAP Signaling (BR/EDR)
+     - Channel management for classic connections
+   * - 0x0002
+     - Connectionless Reception
+     - Connectionless L2CAP data
+   * - 0x0003
+     - AMP Manager
+     - AMP (Alternate MAC/PHY) control
+   * - 0x0004
+     - ATT
+     - Attribute Protocol (GATT operations)
+   * - 0x0005
+     - L2CAP Signaling (LE)
+     - Channel management for LE connections
+   * - 0x0006
+     - SMP (LE)
+     - Security Manager Protocol
+   * - 0x0007
+     - SMP (BR/EDR)
+     - Security Manager over classic transport
+
+In btmon output, fixed channel traffic is decoded directly without
+any L2CAP signaling preamble. For example, ATT on CID 0x0004 appears
+as::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 7    #494 [hci0] 0.004488
+          ATT: Exchange MTU Request (0x02) len 2
+            Client RX MTU: 517
+
+Dynamic Channels (BR/EDR)
+--------------------------
+
+Classic Bluetooth uses L2CAP signaling on CID 0x0001 to establish
+dynamic channels. Each channel is identified by a PSM (Protocol/Service
+Multiplexer) that determines which protocol runs on it.
+
+**Channel establishment**::
+
+    > ACL Data RX: Handle 256 flags 0x02 dlen 16    #142 [hci0] 2.034556
+          L2CAP: Connection Request (0x02) ident 3 len 4
+            PSM: 25 (0x0019)
+            Source CID: 0x0040
+
+    < ACL Data TX: Handle 256 flags 0x00 dlen 20    #144 [hci0] 2.035002
+          L2CAP: Connection Response (0x03) ident 3 len 8
+            Destination CID: 0x0041
+            Source CID: 0x0040
+            Result: Connection successful (0x0000)
+            Status: No further information available (0x0000)
+
+After connection, configuration is exchanged::
+
+    > ACL Data RX: Handle 256 flags 0x02 dlen 20    #146 [hci0] 2.035556
+          L2CAP: Configure Request (0x04) ident 4 len 8
+            Destination CID: 0x0041
+            Flags: 0x0000
+            Option: MTU (0x01) [2]
+              MTU: 1024
+
+    < ACL Data TX: Handle 256 flags 0x00 dlen 18    #148 [hci0] 2.036003
+          L2CAP: Configure Response (0x05) ident 4 len 6
+            Source CID: 0x0040
+            Flags: 0x0000
+            Result: Success (0x0000)
+
+Common PSM-to-protocol mappings:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 12 25 63
+
+   * - PSM
+     - Protocol
+     - Description
+   * - 0x0001
+     - SDP
+     - Service Discovery Protocol
+   * - 0x0003
+     - RFCOMM
+     - Serial port emulation (SPP, HFP, etc.)
+   * - 0x000f
+     - BNEP
+     - Bluetooth Network Encapsulation Protocol
+   * - 0x0017
+     - AVCTP
+     - Audio/Video Control Transport (AVRCP)
+   * - 0x0019
+     - AVDTP
+     - Audio/Video Distribution Transport (A2DP)
+   * - 0x001b
+     - AVCTP Browsing
+     - AVRCP browsing channel
+   * - 0x001f
+     - ATT (BR/EDR)
+     - Attribute Protocol over classic transport
+   * - 0x0027
+     - EATT
+     - Enhanced Attribute Protocol
+
+LE Credit-Based Channels
+--------------------------
+
+LE connections use L2CAP signaling on CID 0x0005 for dynamic
+channels. The LE Credit Based Connection mechanism provides flow
+control::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 18   #600 [hci0] 1.824003
+          LE L2CAP: LE Connection Request (0x14) ident 1 len 10
+            PSM: 39 (0x0027)
+            Source CID: 0x0040
+            MTU: 517
+            MPS: 251
+            Credits: 10
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 18   #602 [hci0] 1.886556
+          LE L2CAP: LE Connection Response (0x15) ident 1 len 10
+            Destination CID: 0x0041
+            MTU: 517
+            MPS: 251
+            Credits: 10
+            Result: Connection successful (0x0000)
+
+EATT (Enhanced ATT) uses PSM 0x0027 over LE Credit-Based channels to
+provide multiple parallel ATT bearers.
+
+Connection Parameter Updates
+-----------------------------
+
+LE peripherals frequently request connection parameter changes via
+L2CAP signaling::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 16   #493 [hci0] 0.003915
+          LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
+            Min interval: 24
+            Max interval: 40
+            Peripheral latency: 0
+            Timeout multiplier: 256
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 10   #495 [hci0] 0.066003
+          LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len 2
+            Result: Connection Parameters accepted (0x0000)
+
+A result of ``Connection Parameters rejected (0x0001)`` means the
+central denied the request.
+
+Automating L2CAP Analysis
+--------------------------
+
+**Find all L2CAP channel establishments**::
+
+    grep -n "Connection Request\|Connection Response\|LE Connection Request\|LE Connection Response" output.txt
+
+**Track PSM usage** (identifies which protocols are active)::
+
+    grep -n "PSM:" output.txt
+
+**Find connection parameter update issues**::
+
+    grep -n "Parameter Update Request\|Parameter Update Response\|Parameters rejected" output.txt
+
+**Find EATT channel setup**::
+
+    grep -n "PSM: 39\|Enhanced Credit" output.txt
+
+**Trace a specific L2CAP channel**: To follow traffic on a dynamic
+channel, note the Source CID and Destination CID from the Connection
+Request/Response pair. Then search for those CIDs in subsequent data
+frames.
diff --git a/doc/btmon.rst b/doc/btmon.rst
index 9e33c46ae8db..84b9f29df95d 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1376,196 +1376,7 @@ appears on reconnection, the bond was lost on one side.
 5. Check for ``Identity Address Information`` -- reveals the device's
    true address
 
-L2CAP CHANNEL TRACKING
-=======================
-
-L2CAP (Logical Link Control and Adaptation Protocol) multiplexes
-multiple logical channels over a single ACL connection. btmon decodes
-L2CAP signaling automatically and routes data to higher-layer protocol
-decoders based on the channel.
-
-Fixed Channels
---------------
-
-Fixed channels have pre-assigned Channel Identifiers (CIDs) and do
-not require signaling to establish:
-
-.. list-table::
-   :header-rows: 1
-   :widths: 10 30 60
-
-   * - CID
-     - Protocol
-     - Description
-   * - 0x0001
-     - L2CAP Signaling (BR/EDR)
-     - Channel management for classic connections
-   * - 0x0002
-     - Connectionless Reception
-     - Connectionless L2CAP data
-   * - 0x0003
-     - AMP Manager
-     - AMP (Alternate MAC/PHY) control
-   * - 0x0004
-     - ATT
-     - Attribute Protocol (GATT operations)
-   * - 0x0005
-     - L2CAP Signaling (LE)
-     - Channel management for LE connections
-   * - 0x0006
-     - SMP (LE)
-     - Security Manager Protocol
-   * - 0x0007
-     - SMP (BR/EDR)
-     - Security Manager over classic transport
-
-In btmon output, fixed channel traffic is decoded directly without
-any L2CAP signaling preamble. For example, ATT on CID 0x0004 appears
-as::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 7    #494 [hci0] 0.004488
-          ATT: Exchange MTU Request (0x02) len 2
-            Client RX MTU: 517
-
-Dynamic Channels (BR/EDR)
---------------------------
-
-Classic Bluetooth uses L2CAP signaling on CID 0x0001 to establish
-dynamic channels. Each channel is identified by a PSM (Protocol/Service
-Multiplexer) that determines which protocol runs on it.
-
-**Channel establishment**::
-
-    > ACL Data RX: Handle 256 flags 0x02 dlen 16    #142 [hci0] 2.034556
-          L2CAP: Connection Request (0x02) ident 3 len 4
-            PSM: 25 (0x0019)
-            Source CID: 0x0040
-
-    < ACL Data TX: Handle 256 flags 0x00 dlen 20    #144 [hci0] 2.035002
-          L2CAP: Connection Response (0x03) ident 3 len 8
-            Destination CID: 0x0041
-            Source CID: 0x0040
-            Result: Connection successful (0x0000)
-            Status: No further information available (0x0000)
-
-After connection, configuration is exchanged::
-
-    > ACL Data RX: Handle 256 flags 0x02 dlen 20    #146 [hci0] 2.035556
-          L2CAP: Configure Request (0x04) ident 4 len 8
-            Destination CID: 0x0041
-            Flags: 0x0000
-            Option: MTU (0x01) [2]
-              MTU: 1024
-
-    < ACL Data TX: Handle 256 flags 0x00 dlen 18    #148 [hci0] 2.036003
-          L2CAP: Configure Response (0x05) ident 4 len 6
-            Source CID: 0x0040
-            Flags: 0x0000
-            Result: Success (0x0000)
-
-Common PSM-to-protocol mappings:
-
-.. list-table::
-   :header-rows: 1
-   :widths: 12 25 63
-
-   * - PSM
-     - Protocol
-     - Description
-   * - 0x0001
-     - SDP
-     - Service Discovery Protocol
-   * - 0x0003
-     - RFCOMM
-     - Serial port emulation (SPP, HFP, etc.)
-   * - 0x000f
-     - BNEP
-     - Bluetooth Network Encapsulation Protocol
-   * - 0x0017
-     - AVCTP
-     - Audio/Video Control Transport (AVRCP)
-   * - 0x0019
-     - AVDTP
-     - Audio/Video Distribution Transport (A2DP)
-   * - 0x001b
-     - AVCTP Browsing
-     - AVRCP browsing channel
-   * - 0x001f
-     - ATT (BR/EDR)
-     - Attribute Protocol over classic transport
-   * - 0x0027
-     - EATT
-     - Enhanced Attribute Protocol
-
-LE Credit-Based Channels
---------------------------
-
-LE connections use L2CAP signaling on CID 0x0005 for dynamic
-channels. The LE Credit Based Connection mechanism provides flow
-control::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 18   #600 [hci0] 1.824003
-          LE L2CAP: LE Connection Request (0x14) ident 1 len 10
-            PSM: 39 (0x0027)
-            Source CID: 0x0040
-            MTU: 517
-            MPS: 251
-            Credits: 10
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 18   #602 [hci0] 1.886556
-          LE L2CAP: LE Connection Response (0x15) ident 1 len 10
-            Destination CID: 0x0041
-            MTU: 517
-            MPS: 251
-            Credits: 10
-            Result: Connection successful (0x0000)
-
-EATT (Enhanced ATT) uses PSM 0x0027 over LE Credit-Based channels to
-provide multiple parallel ATT bearers.
-
-Connection Parameter Updates
------------------------------
-
-LE peripherals frequently request connection parameter changes via
-L2CAP signaling::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 16   #493 [hci0] 0.003915
-          LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
-            Min interval: 24
-            Max interval: 40
-            Peripheral latency: 0
-            Timeout multiplier: 256
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 10   #495 [hci0] 0.066003
-          LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len 2
-            Result: Connection Parameters accepted (0x0000)
-
-A result of ``Connection Parameters rejected (0x0001)`` means the
-central denied the request.
-
-Automating L2CAP Analysis
---------------------------
-
-**Find all L2CAP channel establishments**::
-
-    grep -n "Connection Request\|Connection Response\|LE Connection Request\|LE Connection Response" output.txt
-
-**Track PSM usage** (identifies which protocols are active)::
-
-    grep -n "PSM:" output.txt
-
-**Find connection parameter update issues**::
-
-    grep -n "Parameter Update Request\|Parameter Update Response\|Parameters rejected" output.txt
-
-**Find EATT channel setup**::
-
-    grep -n "PSM: 39\|Enhanced Credit" output.txt
-
-**Trace a specific L2CAP channel**: To follow traffic on a dynamic
-channel, note the Source CID and Destination CID from the Connection
-Request/Response pair. Then search for those CIDs in subsequent data
-frames.
+.. include:: btmon-l2cap.rst
 
 .. include:: btmon-le-audio.rst
 
-- 
2.53.0

