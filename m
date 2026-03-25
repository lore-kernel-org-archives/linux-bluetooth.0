Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EB3451BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464861; cv=none; b=cJ32TGZcgm3x359UYrhX1VwT71zDGKviT2Cc0Dxb5MhJt5a68rH5KAy4u6BtCRrhA4iABHi9Y+VhoeWcs4Nfj6HVSWPy4RQCcvbQ9IFTIHczFD78107kMpYW9y3DKQ5j67iuhekWyubpgOA8qIRVAEvtcZPm11OfIn46c/IkoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464861; c=relaxed/simple;
	bh=C9FUP7oJW+5mJA3PvA5cc2IvxVZ3yQkmuF/qIoO30aQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5lf4bGxAk0S5li3Yr1XvS55XoTwTf1BcSieeTesg079WIcE5ufvSAGm9yTUvm0RjtIax1b4noe71vqoeI0dFXZ8OZ6rGAq9Tv02Qe2jV7nH1uoD1vAADFdCfBPNyizKiSXMbe6Cv4hj+xeRlh0YgsPF7MSzkEFoNArcH6JrlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxHQZNWV; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxHQZNWV"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso147228e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464859; x=1775069659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSCf/u8PrpoKPHoR07v/5YQ21cuZzMH2WegrWXOKetw=;
        b=fxHQZNWVZfZYvNowbtJANf7iA4lNiAHHRmF8/EMdr8Tnbww8Myqd5UBEptPFUwQV3g
         8nsQRGfwcxSTCLm6b4neiBU1H50hUlQmXbQB3g0BhWRXyM0sMiSVE3dExf7m/pbXNSZS
         q8Q4TlSrIuB7bqk8FWL6m+aDsTqwJ0ug9X15i/vNqM/MkRysJQvHtYnDtuKL3GobX5y7
         qOzLByDu++x/ZcGbHBV/4lQfNilB5cKOC6R0p8iFFtbv4Z3le3Bz4W8DUmGlKiv1o0k0
         Wp2/hNs09x0tHQDl41ikr89hVs+JD2U+KDDgp/cUOG5oQG+nsO3G6zWX30dpUse/Ubb3
         dJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464859; x=1775069659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mSCf/u8PrpoKPHoR07v/5YQ21cuZzMH2WegrWXOKetw=;
        b=i8g+i4Xt6DYSZlqO2ZS4c6OIzsUIs8+3IVU8jsI94BXeKXgyCVMRs/C26M3DpMtPqd
         SqfFoFSJZbErr5WSm8s943VWGgx398tGLBj9WkqcrCdmKY0joiZartjmNxlVBoxFxIR/
         jaGByjvUefbBtCTQlal19g+nbZzX9Iddal3SZHceN+44AJa9BDMA//QBdcg3VpZDn+yE
         FDdYcQC+thnQ5iAX0TXguPF/Sv0GZX/j3rY9YG7isOf/4SmCYy739R199xm/ME8LDrg6
         U1ciRnWakdeJjXsP/B/hFNRF+UhPogq2hDncGlj2fEivef7DUPbDHdbSODxbGVJqT3E2
         d/tQ==
X-Gm-Message-State: AOJu0Yzsu1I1QMPGJQ5AO7EnZ7FfUE9LpRhXoBmaC87qYLUrPRX8z1vw
	5sEfm9BQBlIbk0djZLi/Sew7eHGpJHnBJGsyx0pzNBdhQ2CZok4NMyOCGtHMViV5
X-Gm-Gg: ATEYQzz3w7y9ZjUBcApnlw+J7z28gt1+ZHo3i2nCIBseQeMjg32uJj7pRvvNzQdavaI
	EqnBUVFMacuTC5X1rvytDgg9mJ5usBPUxVATUti58N9tfP3OhsnKSUX3/5friA2EIs2frcqN80a
	6zI3KJZ/sbvBZsdRcmuCKqSfw9Zp/rpc04Vv8c5SUTypfVQiWCranuR4ynZGZAFGRv2dPzpHM1w
	Bs/4FA5f5WEnCHfqZkYsurJnHftJ8fOFcDOg5K37diCdPMoGC3sogEI6f4ODGCxLSa1b2JmDhxv
	GZ7Xh4b4Ddr6T3Omnpx/rDPAQ7FhKsR2blMGdMjIBfD0ntzAQY7QTA8dEIwyc2DTZgSsHRfA5H9
	xwLGz91xmIl7cNE4Fqnrr7V3dLNhanHRf4mQ9sYYkSq/Knd8adR2w+/GvVG6c+fyFB2ecNk5Dbj
	IHIVDecZDU9nCn8pVrbu3Wn9cJYZ6ZbLq6uEBIfmkreBFKRnqKKKV39vzQkD+pA6h6T5ue4kH67
	4wP9ZY/629qmR5T1g==
X-Received: by 2002:a05:6122:4b06:b0:56b:84c2:2af0 with SMTP id 71dfb90a1353d-56d21f23647mr2476100e0c.3.1774464858735;
        Wed, 25 Mar 2026 11:54:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d71947sm921438e0c.14.2026.03.25.11.54.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:54:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/9] doc/btmon: Split L2CAP Channel Tracking into btmon-l2cap.rst
Date: Wed, 25 Mar 2026 14:53:59 -0400
Message-ID: <20260325185406.568078-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325185406.568078-1-luiz.dentz@gmail.com>
References: <20260325185406.568078-1-luiz.dentz@gmail.com>
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
 Makefile.am         |   2 +
 doc/btmon-l2cap.rst | 192 +++++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst       | 193 +-------------------------------------------
 3 files changed, 196 insertions(+), 191 deletions(-)
 create mode 100644 doc/btmon-l2cap.rst

diff --git a/Makefile.am b/Makefile.am
index b561b708cab5..292ef64a98d3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -542,6 +542,8 @@ EXTRA_DIST += doc/btmon-advertising.rst
 
 EXTRA_DIST += doc/btmon-le-audio.rst
 
+EXTRA_DIST += doc/btmon-l2cap.rst
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
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

