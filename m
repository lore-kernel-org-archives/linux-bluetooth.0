Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFE345741
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381803; cv=none; b=lQ17KTgpTEJL08CiN8kaFm1eYXvBP58L115jLkutC3Oac2vgP17TBx425BUQdFzbczdgagAxN710ACfOfhEl3XD200fXb2BVhT0Lxd/IM+EqCkpTUsKrgSG67Mj7uySxrBx7e1M1M/wxKbea3HzuoPSsREmKQEmJez+qvrnPoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381803; c=relaxed/simple;
	bh=+5EkYofi7D9N7MqIQP/TbjXfTF4QsL6dTRo8LOii8No=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq8ta3VJ0r2pf+h7rLDN7zQrKY0TPmQTQ1ALnEhFQSqtOob2YSG9Zs3Ci4g3872sBbcI5w0j637LOCaL0C1L+GQyA+hBk9OD+1EFwUDlSFje3JMfXkYHzeY2EkrdDo48BTvXtyJ70ag7zy2XHVPeSr3isoHHaB7R1wwsoeaeQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cckoQOOh; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cckoQOOh"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-602a0648aa3so1074271137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381800; x=1774986600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea/12V1RJqaeVASHiDTkqQcsX9xouLaqL0/OFWGKevU=;
        b=cckoQOOhlz16UJ64wFcHP4J32zolOcLiE1/TBRx302Info4614CZW8boHYFYFtbVGo
         AyFEL9bQ3nsbON6tP9S/wze671aOOP7zDq/acVl6aT0is7PHu4ADBUHs0KP5Wrf60HM7
         dYSIohiXDk4ZCg/ncW832kLoz3jc56mKrzF5KB/kBBRLDflIcjcOsOVhBnfL0U7p5NXW
         /02vB/MaWKuZox0eAvBHZlsmaNYPD5BB0/or0XwpG97ERU6WaxJ4aqUFwb+t6vgSaQ45
         u+tsmrjUqvlraaYhLJoNFzlDNAo6BhxqqYya8SUGJ3onNc3wrP2eilKu9SY/7wY/Phqg
         XorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381800; x=1774986600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ea/12V1RJqaeVASHiDTkqQcsX9xouLaqL0/OFWGKevU=;
        b=rqkePMINAG4VACfIGP8/eCO4Z4YP/K+4VR+lLjJ44UIICz6TfsPWfes8u5pbT4pfWx
         Zn5eWhbaQCOMLG+Q6db4yDVYHU68hdN5464noHYqECcJ1YkZrUepF88Dr2F1C6HgCWUa
         WfqwXK/iNAKwZtOUtX6hkzyoiqTJ+BmoA+Frlb8Y3KeZzzWv6f+AGIPpaBFLKF3+dTMc
         jhG86CKzMkVGQ6H6uXLFzW0sh8Y1UlurgFIh+2oChCmGhc9Pb3KmEu0V9wQGsWHmiAeg
         /m3FuR2u87tvhLaSLhlaq36nEIzUnEx+bpbVK/EQlE89If66z/K9rWq9PykGv035vuKd
         dNxg==
X-Gm-Message-State: AOJu0Yywy4zdyPEfhVkdslJ7PPW4QFhIka8t7Tg6DLHN79zbueis+OG5
	FbIi5T6EftFIR6vXh09wPo1aybtbdzuPSkL3wvZxRQ17KmuxACPn4lQA0r90S1a8
X-Gm-Gg: ATEYQzykUDFtJiAj/ykp/vVz8zkG7NABx2GqNO5LVEMuA0U4JGAAb2lzs93JJD5Pcmq
	Ubesjcr3TXn5bn8GTCLjtP/ufw0fp5F6EJ4Ie4E8sg0TU8AjW6pKx25jqU/C5kQJkwpUPWoAn44
	xVg9tJMdcLRKNQBqT6ojCuYoeKbfXFMv3tnwG6bjWPrTCC4dYGUgO5aecZyGiBu5ZmdWYIBR3xe
	3Zr6djvo6s/lXcKLPp1W9uQ7MwWMcGSkllKWk/p/CYrvystHWFy+gjI6MneswGdRucoAm/29xPO
	odbI/Z+ehPBYIC1tZXka+3rTnz1rdxwgehAKVGtk9TgoMraeusroRaFitnpIODye9HD8lOpWsed
	cve7j8cqRXafs93wPhwkEmjOxLSfPAkwxHRv896JD2GZmnoJWh1XsaC13Gvea5K5MDOdnktn39r
	ItIwFChrWGAWMWlWz+erxSDaotPLJmX78c1f67MzTeMejF793nM27DPm28KggFp4iDMQBKRjDuZ
	TkNAmegedqLGFePOA==
X-Received: by 2002:a05:6102:3a0e:b0:5ff:c510:b7e8 with SMTP id ada2fe7eead31-60387228693mr633360137.14.1774381799581;
        Tue, 24 Mar 2026 12:49:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de3e33sm13759671241.9.2026.03.24.12.49.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:49:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 9/9] doc/btmon: Add HFP protocol flow documentation
Date: Tue, 24 Mar 2026 15:49:45 -0400
Message-ID: <20260324194946.109349-9-luiz.dentz@gmail.com>
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

Add btmon-hfp.rst documenting the HFP protocol flow as seen in btmon
output. Coverage includes:

 - SDP service discovery for Handsfree/AG UUIDs
 - RFCOMM channel setup over L2CAP PSM 3 (SABM/UA, Parameter
   Negotiation, Modem Status Command)
 - AT command exchange for SLC setup (noted as hex dump only -- btmon
   does not parse AT commands within RFCOMM UIH data frames)
 - Codec negotiation via AT+BAC/AT+BCS
 - SCO/eSCO synchronous connection setup (voice setting, coding format)
 - Codec summary tables (AT-level vs HCI-level codec IDs)
 - Automation-friendly grep patterns
---
 doc/btmon-classic-audio.rst |   2 +
 doc/btmon-hfp.rst           | 476 ++++++++++++++++++++++++++++++++++++
 2 files changed, 478 insertions(+)
 create mode 100644 doc/btmon-hfp.rst

diff --git a/doc/btmon-classic-audio.rst b/doc/btmon-classic-audio.rst
index 11943c3a54bf..3e7c5384be87 100644
--- a/doc/btmon-classic-audio.rst
+++ b/doc/btmon-classic-audio.rst
@@ -10,3 +10,5 @@ A2DP uses L2CAP-based AVDTP media channels while HFP uses SCO/eSCO
 synchronous connections.
 
 .. include:: btmon-a2dp.rst
+
+.. include:: btmon-hfp.rst
diff --git a/doc/btmon-hfp.rst b/doc/btmon-hfp.rst
new file mode 100644
index 000000000000..c81c0df3feb3
--- /dev/null
+++ b/doc/btmon-hfp.rst
@@ -0,0 +1,476 @@
+.. This file is included by btmon-classic-audio.rst.
+
+HFP: Hands-Free Profile
+-------------------------
+
+HFP carries voice audio over SCO/eSCO connections with call control
+over RFCOMM. btmon decodes RFCOMM framing and SCO/eSCO connection
+setup. AT commands (the HFP control protocol) appear as raw hex dumps
+within RFCOMM data frames -- btmon does not parse AT command syntax.
+
+SDP Discovery
+~~~~~~~~~~~~~~
+
+HFP uses SDP to discover the remote device's Hands-Free or Audio
+Gateway service record and its RFCOMM channel number::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 25
+          Channel: 64 len 21 [PSM 1 mode Basic (0x00)] {chan 0}
+            SDP: Service Search Attribute Request (0x06) tid 1 len 16
+              Search pattern: [len 5]
+                Sequence (6) with 3 byte(s) [8 extra bits] len 5
+                  UUID (3) with 2 byte(s) [0 extra bits] len 3
+                    Handsfree Audio Gateway (0x111f)
+              Max record count: 65535
+              Attribute list: [len 5]
+                Sequence (6) with 3 byte(s) [8 extra bits] len 5
+                  Unsigned Integer (1) with 4 byte(s) [0 extra bits] len 5
+                    0x0000ffff
+              Continuation state: 0
+
+The response contains the service record with the RFCOMM channel::
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 89
+          Channel: 64 len 85 [PSM 1 mode Basic (0x00)] {chan 0}
+            SDP: Service Search Attribute Response (0x07) tid 1 len 80
+              Attribute bytes: 77
+                Attribute list: [len 75] {position 0}
+                  Attribute: Service Class ID List (0x0001) [len 2]
+                    Handsfree Audio Gateway (0x111f)
+                  Attribute: Protocol Descriptor List (0x0004) [len 2]
+                    L2CAP (0x0100)
+                    RFCOMM (0x0003)
+                      Channel: 1
+                  Attribute: Bluetooth Profile Descriptor List (0x0009) [len 2]
+                    Handsfree (0x111e)
+                      Version: 0x0108
+              Continuation state: 0
+
+Key fields to extract:
+
+- **Service Class** -- ``Handsfree (0x111e)`` for HF role,
+  ``Handsfree Audio Gateway (0x111f)`` for AG role
+- **RFCOMM Channel** -- The channel number under ``RFCOMM (0x0003)``
+  in the Protocol Descriptor List (e.g., channel 1)
+- **Profile Version** -- Under the Bluetooth Profile Descriptor List
+  (e.g., ``0x0108`` = HFP 1.8, ``0x0109`` = HFP 1.9)
+
+RFCOMM Connection Setup
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+RFCOMM runs over L2CAP PSM 3. The connection proceeds in stages:
+multiplexer session on DLCI 0, parameter negotiation, then the data
+channel on the target DLCI.
+
+**L2CAP connection for RFCOMM**::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 12
+          L2CAP: Connection Request (0x02) ident 2 len 4
+            PSM: 3 (0x0003)
+            Source CID: 65
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 16
+          L2CAP: Connection Response (0x03) ident 2 len 8
+            Destination CID: 65
+            Source CID: 65
+            Result: Connection successful (0x0000)
+            Status: No further information available (0x0000)
+
+**SABM/UA on DLCI 0** (multiplexer session)::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 12
+          Channel: 65 len 4 [PSM 3 mode Basic (0x00)] {chan 1}
+            RFCOMM: Set Async Balance Mode (SABM) (0x2f)
+             Address: 0x03 cr 1 dlci 0x00
+             Control: 0x3f poll/final 1
+             Length: 0
+             FCS: 0x1c
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 12
+          Channel: 65 len 4 [PSM 3 mode Basic (0x00)] {chan 1}
+            RFCOMM: Unnumbered Ack (UA) (0x63)
+             Address: 0x03 cr 1 dlci 0x00
+             Control: 0x73 poll/final 1
+             Length: 0
+             FCS: 0xd7
+
+**Parameter Negotiation** (MCC on DLCI 0)::
+
+    Channel: 65 len 14 [PSM 3 mode Basic (0x00)] {chan 1}
+      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
+       Address: 0x03 cr 1 dlci 0x00
+       Control: 0xef poll/final 0
+       Length: 10
+       FCS: 0x70
+       MCC Message type: DLC Parameter Negotiation CMD (0x20)
+         Length: 8
+         dlci 2 frame_type 0 credit_flow 15 pri 7
+         ack_timer 0 frame_size 127 max_retrans 0 credits 7
+
+The DLCI in the PN command identifies the target channel. For RFCOMM
+channel N, DLCI = N * 2 (or N * 2 + 1 depending on the initiator
+role).
+
+**SABM/UA on target DLCI** (data channel)::
+
+    Channel: 65 len 4 [PSM 3 mode Basic (0x00)] {chan 1}
+      RFCOMM: Set Async Balance Mode (SABM) (0x2f)
+       Address: 0x0b cr 1 dlci 0x02
+       Control: 0x3f poll/final 1
+       Length: 0
+       FCS: 0x59
+
+    Channel: 65 len 4 [PSM 3 mode Basic (0x00)] {chan 1}
+      RFCOMM: Unnumbered Ack (UA) (0x63)
+       Address: 0x0b cr 1 dlci 0x02
+       Control: 0x73 poll/final 1
+       Length: 0
+       FCS: 0x92
+
+**Modem Status Command** (signals readiness)::
+
+    Channel: 65 len 8 [PSM 3 mode Basic (0x00)] {chan 1}
+      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
+       Address: 0x03 cr 1 dlci 0x00
+       Control: 0xef poll/final 0
+       Length: 4
+       FCS: 0x70
+       MCC Message type: Modem Status Command CMD (0x38)
+         Length: 2
+         dlci 2
+         fc 0 rtc 1 rtr 1 ic 0 dv 1
+
+AT Command Exchange (SLC Setup)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+HFP uses AT commands over RFCOMM for call control and feature
+negotiation. btmon shows these as RFCOMM UIH frames with the AT
+command text visible in the hex dump.
+
+**AT command in RFCOMM UIH frame**::
+
+    Channel: 65 len 21 [PSM 3 mode Basic (0x00)] {chan 1}
+      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
+       Address: 0x09 cr 0 dlci 0x02
+       Control: 0xff poll/final 1
+       Length: 14
+       FCS: 0x86
+       Credits: 1
+        41 54 2b 42 52 53 46 3d 32 30 35 35 0d         AT+BRSF=2055.
+
+The AT command text is readable in the ASCII column of the hex dump
+(right side). The Service Level Connection (SLC) setup sequence
+exchanges device features and capabilities:
+
+1. ``AT+BRSF=<features>`` / ``+BRSF:<features>`` -- Supported
+   features bitmask exchange
+2. ``AT+BAC=1,2`` -- Available codecs (if codec negotiation supported).
+   Codec IDs: 1 = CVSD, 2 = mSBC, 3 = LC3-SWB
+3. ``AT+CIND=?`` / ``+CIND:(...)`` -- Indicator mapping query
+4. ``AT+CIND?`` / ``+CIND:values`` -- Current indicator values
+5. ``AT+CMER=3,0,0,1`` -- Enable indicator status reporting
+6. ``AT+CHLD=?`` / ``+CHLD:(0,1,2,3,4)`` -- Three-way calling support
+
+Key HFP feature bits (from ``AT+BRSF``):
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 25 25
+
+   * - Bit
+     - HF Feature
+     - AG Feature
+   * - 0
+     - EC/NR
+     - Three-way calling
+   * - 1
+     - Three-way calling
+     - EC/NR
+   * - 2
+     - CLI presentation
+     - Voice recognition
+   * - 3
+     - Voice recognition
+     - In-band ring tone
+   * - 4
+     - Remote volume
+     - Voice tag
+   * - 5
+     - Enhanced call status
+     - Reject call
+   * - 6
+     - Enhanced call control
+     - Enhanced call status
+   * - 7
+     - Codec negotiation
+     - Enhanced call control
+   * - 8
+     - HF indicators
+     - Extended error codes
+   * - 9
+     - eSCO S4 (T2)
+     - Codec negotiation
+   * - 11
+     -
+     - eSCO S4 (T2)
+
+Codec Connection Setup
+~~~~~~~~~~~~~~~~~~~~~~~
+
+When both sides support codec negotiation (feature bit 7 on HF, bit 9
+on AG), the AG selects a codec before establishing the audio link.
+This appears as AT commands in RFCOMM UIH frames::
+
+    AG -> HF:  +BCS:2      (select mSBC)
+    HF -> AG:  AT+BCS=2    (confirm mSBC)
+    AG -> HF:  OK
+
+HFP codec IDs (used in ``AT+BAC`` and ``AT+BCS``):
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 20 30
+
+   * - ID
+     - Codec
+     - Description
+   * - 1
+     - CVSD
+     - Narrow band (8 kHz), mandatory
+   * - 2
+     - mSBC
+     - Wide band speech (16 kHz)
+   * - 3
+     - LC3-SWB
+     - Super wide band (32 kHz), HFP 1.9+
+
+These HFP-level codec IDs differ from HCI codec IDs.
+
+Voice Setting
+~~~~~~~~~~~~~~
+
+Before SCO/eSCO setup, the host configures the voice setting. For
+CVSD, the air coding format is CVSD; for mSBC or LC3-SWB, it must be
+set to Transparent Data::
+
+    < HCI Command: Write Voice Setting (0x0c|0x0026) plen 2
+          Setting: 0x0063
+            Input Coding: Linear
+            Input Data Format: 2's complement
+            Input Sample Size: 16-bit
+            # of bits padding at MSB: 0
+            Air Coding Format: Transparent Data
+
+For CVSD::
+
+    < HCI Command: Write Voice Setting (0x0c|0x0026) plen 2
+          Setting: 0x0060
+            Input Coding: Linear
+            Input Data Format: 2's complement
+            Input Sample Size: 16-bit
+            # of bits padding at MSB: 0
+            Air Coding Format: CVSD
+
+SCO/eSCO Connection Setup
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+After codec negotiation, the host establishes a synchronous connection
+for voice audio.
+
+**Setup Synchronous Connection** (basic)::
+
+    < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
+          Handle: 1
+          Transmit bandwidth: 8000
+          Receive bandwidth: 8000
+          Max latency: 13
+          Setting: 0x0063
+            Input Coding: Linear
+            Input Data Format: 2's complement
+            Input Sample Size: 16-bit
+            # of bits padding at MSB: 0
+            Air Coding Format: Transparent Data
+          Retransmission effort: Optimize for link quality (0x02)
+          Packet type: 0x0008
+            EV3 may be used
+
+**Enhanced Setup Synchronous Connection** (codec-aware)::
+
+    < HCI Command: Enhanced Setup Synchronous Connection (0x01|0x003d) plen 59
+          Handle: 1
+          Transmit bandwidth: 8000
+          Receive bandwidth: 8000
+          Transmit Coding Format:
+            Codec: mSBC (0x05)
+          Receive Coding Format:
+            Codec: mSBC (0x05)
+          Transmit Codec Frame Size: 60
+          Receive Codec Frame Size: 60
+          Input Coding Format:
+            Codec: mSBC (0x05)
+          Output Coding Format:
+            Codec: mSBC (0x05)
+          Input Coded Data Size: 16
+          Output Coded Data Size: 16
+          Input PCM Data Format: 2's complement
+          Output PCM Data Format: 2's complement
+          Input PCM Sample Payload MSB Position: 0
+          Output PCM Sample Payload MSB Position: 0
+          Input Data Path: HCI
+          Output Data Path: HCI
+          Input Transport Unit Size: 60
+          Output Transport Unit Size: 60
+          Max latency: 13
+          Packet type: 0x0008
+            EV3 may be used
+          Retransmission effort: Optimize for link quality (0x02)
+
+HCI codec IDs displayed by btmon:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 20 30
+
+   * - ID
+     - btmon Name
+     - Used For
+   * - 0x02
+     - CVSD
+     - Narrow band voice
+   * - 0x03
+     - Transparent
+     - Transparent data mode
+   * - 0x04
+     - Linear PCM
+     - Uncompressed PCM input/output
+   * - 0x05
+     - mSBC
+     - Wide band speech
+   * - 0x06
+     - LC3
+     - Super wide band (LC3-SWB)
+
+**Synchronous Connection Complete** (result)::
+
+    > HCI Event: Synchronous Connection Complete (0x2c) plen 17
+          Status: Success (0x00)
+          Handle: 257
+          Address: 11:22:33:44:55:66 (OUI 11-22-33)
+          Link type: eSCO (0x02)
+          Transmission interval: 0x0c
+          Retransmission window: 0x06
+          RX packet length: 60
+          TX packet length: 60
+          Air mode: Transparent (0x03)
+
+Key fields:
+
+- **Link type** -- ``SCO (0x00)`` for legacy, ``eSCO (0x02)`` for
+  enhanced (used by mSBC and LC3-SWB)
+- **Air mode** -- ``CVSD (0x02)`` for narrow band,
+  ``Transparent (0x03)`` for mSBC or LC3-SWB
+- **RX/TX packet length** -- 60 bytes typical for mSBC T2 settings
+
+SCO Data Packets
+~~~~~~~~~~~~~~~~~
+
+After the synchronous connection is established, voice data flows as
+SCO/eSCO data packets::
+
+    > BR-ESCO: Handle 257 flags 0x00 dlen 60
+    < BR-ESCO: Handle 257 flags 0x00 dlen 60
+
+btmon labels packets based on the connection type established in
+Synchronous Connection Complete:
+
+- ``BR-SCO`` -- Legacy SCO connection
+- ``BR-ESCO`` -- Enhanced SCO connection (mSBC, LC3-SWB, or eSCO CVSD)
+
+SCO data payload is **not displayed by default**. It requires the
+``--show-sco-data`` filter to see the hex dump of voice data.
+
+Codec-Specific Connection Summary
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**CVSD (narrow band)**:
+
+- HFP codec ID: 1
+- HCI codec: CVSD (0x02)
+- Voice setting: 0x0060 (Air Coding Format: CVSD)
+- Air mode: CVSD (0x02)
+- Link type: SCO or eSCO
+- Typical packet size: 48 bytes (HV3) or 60 bytes (EV3)
+
+**mSBC (wide band speech)**:
+
+- HFP codec ID: 2
+- HCI codec: mSBC (0x05)
+- Voice setting: 0x0063 (Air Coding Format: Transparent Data)
+- Air mode: Transparent (0x03)
+- Link type: eSCO
+- Typical packet size: 60 bytes (EV3, T2 settings)
+
+**LC3-SWB (super wide band)**:
+
+- HFP codec ID: 3
+- HCI codec: LC3 (0x06)
+- Voice setting: 0x0063 (Air Coding Format: Transparent Data)
+- Air mode: Transparent (0x03)
+- Link type: eSCO
+- Note: btmon displays ``LC3``, not ``LC3-SWB``
+
+Automating HFP Analysis
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**Identify HFP activity** -- look for RFCOMM on PSM 3::
+
+    grep -n "PSM: 3\|RFCOMM:" output.txt
+
+**Read AT commands** -- search hex dump ASCII for AT command patterns::
+
+    grep -n "AT+B\|AT+C\|+BRSF\|+CIND\|+CHLD\|+BCS" output.txt
+
+**Check codec negotiation** -- look for BCS (Bluetooth Codec
+Selection)::
+
+    grep -n "+BCS\|AT+BAC\|AT+BCS" output.txt
+
+**Verify SCO/eSCO setup**::
+
+    grep -n "Setup Synchronous\|Enhanced Setup Synchronous\|Synchronous Connection Complete\|Write Voice Setting" output.txt
+
+**Check voice codec** -- confirm air mode and coding format::
+
+    grep -n "Air mode:\|Air Coding Format:\|Codec:" output.txt
+
+**Detect SCO failures** -- check Synchronous Connection Complete
+status::
+
+    grep -n "Synchronous Connection Complete" output.txt
+
+Then examine the next line for ``Status:``. Common failures:
+
+- ``Connection Rejected due to Limited Resources (0x0d)`` -- controller
+  cannot allocate bandwidth
+- ``SCO Offset Rejected (0x2b)`` -- timing parameters rejected
+- ``SCO Interval Rejected (0x2c)`` -- interval parameters rejected
+
+**Track call state** -- look for CIEV indicator updates::
+
+    grep -n "+CIEV\|AT+CHUP\|ATD\|ATA\|AT+CLCC\|RING" output.txt
+
+**Full HFP diagnosis pattern**:
+
+1. Find SDP query for UUID 0x111e/0x111f -- confirms HFP discovery
+2. Find L2CAP Connection Request for PSM 3 -- RFCOMM channel setup
+3. Find RFCOMM SABM/UA on DLCI 0 then target DLCI -- multiplexer and
+   data channel
+4. Find AT+BRSF in hex dumps -- feature exchange, check codec
+   negotiation bit
+5. Find AT+BAC in hex dumps -- available codecs reported
+6. Find +BCS/AT+BCS in hex dumps -- codec selected for audio
+7. Find Write Voice Setting -- verify air coding format matches codec
+8. Find Setup Synchronous Connection or Enhanced variant -- SCO setup
+9. Find Synchronous Connection Complete -- check Status, Link type,
+   Air mode
+10. Find BR-SCO or BR-ESCO packets -- voice data flowing
-- 
2.53.0

