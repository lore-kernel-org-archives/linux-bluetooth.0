Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B13148D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381797; cv=none; b=Cdf4pGW8AUaPgbsk3zlECqcmK8oWQoLcUSGDLrZF5HA1GbgbNGTlq2LxwpQV1Oo1jek8+H8ICzMCjuMh4yAyte+RfoMC0gH1CzGC/sGVI2EFWPoH2iq4zU/ktqIVOl/TpvnGo/GR+yUie+oRopf3WnpVdV10A19uJgB6j9ml6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381797; c=relaxed/simple;
	bh=bgqLvSpZReKOtSBype1fjtyXAErsiuBu4QLRi996dPI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDnk9Uxtoov7RxKRMZqDy1EvKImJthzEP0dWF4Cy/k4gRmBZB7fjkzLtdmi5VYn//Hkk68d3t+m1OJ/G0Izlw0fEfGYrZZIoEWh27sWQkT0v58LT+IMW42Ld1jDY/GMqj+Ux2vbnQ4IfnlViI5+EFDXj6gqBjQQtkMZO6wiTKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3XHUi+E; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3XHUi+E"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-60319f32a59so378393137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 12:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381795; x=1774986595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEAZStexchsEAs9ssuz5y0DiQ3zZ6dupvkZsNgK7C+k=;
        b=b3XHUi+EVcFLCu/yc54qQy7KmhGezwNejnMUSWCJjFHQAuNt6jfOPkux3UasYZ/dTP
         B1rJbV7/kGp3WJB233w0HWgJth3qlXMD6DC61WiXlXBWDAlPN67wYxvHTTo5IU7raGEW
         rksb0OXd8sPBXAuGb/y2h44rKXUYS4YE0LnHfnLUvNcpthwJ2V9mqYF9kb4bSdAvSf5Y
         nd6VL7xb1zkkKslDuyh70gYd+7luEoq4xhElBQKRMrwIPfARcZvymiKq+1YkIqQU++Xb
         ctn3X/GcQwYGFovkxjWhRphUw7zd5zLU/rv3gBu/hEVyX17fAqqJXPrchakFmAtHPCWf
         Gvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381795; x=1774986595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IEAZStexchsEAs9ssuz5y0DiQ3zZ6dupvkZsNgK7C+k=;
        b=XEiEid02ICqyc9fmBA+U6B51TnjXNv0D4WZRSEBZB5dSQlOYI10HLc/gaBiak5YA5g
         rM6gYNjONl1NzFNEd0/w4EUfMO0Wna0YPR1D+lNsih6Razyp+wf5mkszRQZI+mcHTYbn
         ZP0hLsAs0rUq/AB4byfqsTYXkK75RC8mz5/uq7AT1qhhvh+GZbNaJH86BiowCcTZk4Rk
         jF+dvc2uf1WrG63+y+s9UqAhLjPqD33nF350r1Gx3L8dVNGCLz2xvWFP67LUhV4EEYtn
         EXkA1EPXOQnpA4XtVmX3bMbwqYf3i7AgkcH/xXsbvvV+HfuP9P1qlniGjEcdtzaU+nPM
         G85Q==
X-Gm-Message-State: AOJu0YzO4O/+jUeuU6fOjk6fMWRHnjmaUoy3VWAgdat5OByWfH4i5ioo
	IcvTBVNIf9HQiRB3AzQsVQ+UEWXx7eD37UUoNKn/7lE19lDWG7ovI0nq5LkvTfC/
X-Gm-Gg: ATEYQzwsFrTXQIFslfx/FiDou3qhVQN5eEs3ApQeJGNAZGOElQvHd1oUqEO07XnoZSJ
	plJhhjk/ZqWBjmuOdaz2//FUpYqr/FEiljiDlzeggt+oEH7FXqqJ8g2/7OfBaBPWbfivcsRNzox
	0aYDm2tBE99qNKXd/Mxr1OACw1n5mtUuJ9zv7dfLQN9/+IFQ68d9WJaIWt46k+eFZIHQ2jEsPEK
	rzjXMdsQGtiW9mmWZo/2NakfPqBylCsCqaVDIF56PAO7mLRkBTIC8QLnNI9hG8BMEU3hfoEGaO+
	25Ro0jwlmErJh5frz0MKu4rHyuQkgh9sGLuGYrJnmeW24/xkcjKQsbxRtAjfJeC6Bgsm0ESops2
	zsEc/xQnVywtRAxwfp5RRG3nL0VQhczh5E2fKyit+BrKLlKvdlZx12fYw9EROcgVImbw2o0S0Cc
	x52XoT7F7BQCUzb4NWqw7xKTvCoRvndlsCIY7uN4CA98F3C6EdPB/fXI5h352UF/WNuWZ8PrTwg
	oGTGWkBaYo1DmEeuA==
X-Received: by 2002:a05:6102:2c02:b0:602:ac40:96b3 with SMTP id ada2fe7eead31-6038728ccb4mr535335137.26.1774381794431;
        Tue, 24 Mar 2026 12:49:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de3e33sm13759671241.9.2026.03.24.12.49.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:49:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/9] doc/btmon: Split L2CAP Channel Tracking into btmon-l2cap.rst
Date: Tue, 24 Mar 2026 15:49:39 -0400
Message-ID: <20260324194946.109349-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324194946.109349-1-luiz.dentz@gmail.com>
References: <20260324194946.109349-1-luiz.dentz@gmail.com>
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
 doc/btmon-l2cap.rst | 192 +++++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst       | 193 +-------------------------------------------
 2 files changed, 194 insertions(+), 191 deletions(-)
 create mode 100644 doc/btmon-l2cap.rst

diff --git a/doc/btmon-l2cap.rst b/doc/btmon-l2cap.rst
new file mode 100644
index 000000000000..e8c52c5e6c5c
--- /dev/null
+++ b/doc/btmon-l2cap.rst
@@ -0,0 +1,192 @@
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
index 66650752c490..6f283c21c490 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1376,197 +1376,6 @@ appears on reconnection, the bond was lost on one side.
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
-
 PROTOCOL ERROR CODES
 =====================
 
@@ -1751,6 +1560,8 @@ Errors often cascade across layers. Common patterns:
 PROTOCOL FLOWS
 ===============
 
+.. include:: btmon-l2cap.rst
+
 .. include:: btmon-le-audio.rst
 
 .. include:: btmon-advertising.rst
-- 
2.53.0

