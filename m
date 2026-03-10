Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3533148DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178409; cv=none; b=Jm2dH6PYxaE3OPYRNi+jKhSM9W7fYaSidP6SO+jNXU3bvT5/zJVC73zjVsXamcmc0UYBQv/ULpGNTGW6Z8GmZzTfTHc0lC7zcnO8DwDs9CLC89VqvXxlCnQ/aqIiuVZAzfocYeOaw+a/6qfmBFNo2okOgp6Lw7Nu66/RGtSVTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178409; c=relaxed/simple;
	bh=kBoNMK7vN3RapcMGNmFCvPyiZ90GlojTtxbEE13kh90=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tihNlZsN968R/3cCtECvhED5cVx8ydjlAvPzUIzUOTJhC8GfzWtRSvYBl5ZuEaHsLsMuwEI40blmrikKZH74dJjhqBGJZHhqLvD1K8HWN63dhr+AyVUbWAL9zR+o77i6wY8BJdDUwhB+0GATAyxX0uXEpgk9+lEgFqCaSVGbAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYhNmiJZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYhNmiJZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-798374d0f44so5952057b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178407; x=1773783207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ+XFwyZjMvlD2nEnm+7UckMZVq0fQ0t9u4T5vWGunY=;
        b=LYhNmiJZKp2d5vSZB6HL248k9iYTEMXKsTk19xfI8DQDcqdWggeGhRsoLpS+aLGEXE
         1AHw6iZ6tmdoBFGLNhefNTb9qpmxR8P8rmhmC0ZB5cntpYPmP7f2izYqbQ3aFbSQLBUA
         CR7LC9L2QqUlkps13bVwzUIeZJ/d+WBmB02HWFMGhgk45+U7hRQVr31XOc8QQeXhMiVU
         TJff+iGd1AsB+RYSLX7cLmh1hxejyTzwdfEpz5A3p06+a3yJ83vLGdOQaj1rlNlHd4Ul
         RHn3HZZO+RMp87vpXM56Du7KeKYoLgZ8ZXBVJp9urYJdXxaCT3kLOR2LCj9FUFE+Cabw
         aIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178407; x=1773783207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lJ+XFwyZjMvlD2nEnm+7UckMZVq0fQ0t9u4T5vWGunY=;
        b=myMwrP4l5mCKCKPgjSeJuaFlHvY52U7/Z1Mvd9I7Wl00IgMrRx9NmPURtjWn3SlfDG
         gzBpFJdWjAsc+fmxzQOjkR15AZCMOVvqc1IpvcsW0q6qVCNMGmzLTHhvTHsh9985oOOC
         dmdmylkVsqSyps2AxBuua4KYdBYhoOIryQpBQKkCxZ2kNPDY3msPE7ZIx6YZQlUe8Yoa
         ZXVbGemHU3s0BtMoPlIeRzf1vA1HNLGyXxaJNIFamJ5yJpnjXXI3G/wKdYLSnKm1z2y7
         rDLaKqq7Jb0uRhBjNTLgkvv/+LzNwZxBoYYkhU2AdVUFHWiCMPC+1ayjhY1w93E5VqxV
         Uwtg==
X-Gm-Message-State: AOJu0YwpvkcgePJxoD4RXtVGsBGcoCeby8UaXUW9j6JMKuPRID0gB4fE
	51lPfQf+KJ4iwz+U4YxgTxsKe+m1TtqXza+yv7h6wkmJd/2wCeBJrQGobBLkaiWa
X-Gm-Gg: ATEYQzzf3TW6QYFsyQPKfhtI4ZyUT2PyaDeHV6UV4Bnhzb2z0133bBWLojwOPLTZnaA
	PWioMzEkyEVxSbnQgUGDjwU0ss5GyWRGjjqUkA1UrLZPEfDMbIZAxAsv039Lc6LDO/wqoh453YX
	nWKfhQIS8TGhIGT/v9CSfmu6qs6P8dtytmzxnNlhlDVtqHpqxXEq12CeRq5hUTg1HjH5X35FjLJ
	eyduPuFgdCEgIK50EkndaxInmB7CYujNVGCgJZziQdKmw2xdZI1GQktcrP96ay8cwyjFPMICtMU
	f/P0i4GDUH12lOlo1UoCRhYhxvuSzUX7sbptBDWi8njOcW/03laBlJi6aIh/vFnU20ElPTUdFM2
	LWRel3Fq4BfqORJ6E94/4+i3VVuLyfOT/GTu15l04fueODN53mBaDPi73dTqk2dT2l2wy4tOfP9
	2Q4l5O3cIPkMexf4M05Vl8pRuFvTKPy55UEYSEe5iT2My9nVjgqBkMRiabteyOltoczDQmz7va/
	gc2sGl96tosMYUWoA==
X-Received: by 2002:a05:690c:30e:b0:799:266:83e5 with SMTP id 00721157ae682-79917f182bamr1991037b3.21.1773178406814;
        Tue, 10 Mar 2026 14:33:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1ecd9sm952777b3.45.2026.03.10.14.33.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:33:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/7] doc/btmon: Add L2CAP channel tracking documentation
Date: Tue, 10 Mar 2026 17:33:09 -0400
Message-ID: <20260310213314.729718-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310213314.729718-1-luiz.dentz@gmail.com>
References: <20260310213314.729718-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add comprehensive L2CAP channel tracking documentation covering:

- Fixed Channels: CID table (0x0001-0x0007) mapping to protocols
  (L2CAP Signaling, ATT, SMP, AMP Manager).

- Dynamic Channels (BR/EDR): Connection Request/Response flow,
  Configure Request/Response, and PSM-to-protocol mapping table
  (SDP, RFCOMM, BNEP, AVCTP, AVDTP, ATT, EATT).

- LE Credit-Based Channels: LE Connection Request/Response with
  MTU, MPS, and credits for flow control. EATT over PSM 0x0027.

- Connection Parameter Updates: LE peripheral parameter change
  requests via L2CAP signaling with accept/reject handling.

- Automating L2CAP Analysis: grep patterns for channel establishments,
  PSM tracking, parameter updates, and EATT setup.

- Updated Automated Trace Analysis: Added L2CAP channel check step
  in the recommended workflow, L2CAP cross-reference in connection
  lifecycle, and connection parameter negotiation debugging scenario.
---
 doc/btmon.rst | 207 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 1 deletion(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index bddbd07d3c35..cc4f81bed2d7 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1377,6 +1377,197 @@ appears on reconnection, the bond was lost on one side.
 5. Check for ``Identity Address Information`` -- reveals the device's
    true address
 
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
+
 EXAMPLES
 ========
 
@@ -1466,6 +1657,11 @@ Recommended Workflow
        # Find targeted service searches
        grep -n "Find By Type Value" output.txt
 
+9. **Check L2CAP channels**: Identify protocol usage and channel
+   issues (see `L2CAP CHANNEL TRACKING`_)::
+
+       grep -n "PSM:\|Connection Request\|Connection Response\|Parameter Update" output.txt
+
 Key Patterns for Connection Lifecycle
 -------------------------------------
 
@@ -1479,7 +1675,9 @@ pattern in the trace:
 3. ``Encryption Change`` -- link encrypted (may show encryption
    algorithm). See `SMP PAIRING FLOW`_ for the SMP exchange that
    precedes this.
-4. ACL Data with ATT/SMP/L2CAP -- service discovery and data exchange
+4. ACL Data with ATT/SMP/L2CAP -- service discovery and data exchange.
+   See `RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES`_ for GATT,
+   `L2CAP CHANNEL TRACKING`_ for channel setup.
 5. ``Disconnect Complete`` -- connection ended, check Reason field
 
 For LE Audio connections, additional steps appear between 3 and 5:
@@ -1508,6 +1706,13 @@ Common Debugging Scenarios
 5. If no SMP traffic on reconnect but ``Encryption Change`` fails,
    the bond was lost on one side
 
+**Connection parameter negotiation failure**:
+
+1. Find ``Connection Parameter Update Request`` (L2CAP level)
+2. Check the Response -- ``rejected`` means the central denied it
+3. Alternatively, find ``LE Connection Update Complete`` (HCI level)
+4. Check Status -- non-zero means the controller rejected the update
+
 Vendor-Specific Events
 ----------------------
 
-- 
2.53.0

