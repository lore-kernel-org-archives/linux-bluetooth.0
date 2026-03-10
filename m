Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FF72DCF57
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178411; cv=none; b=oxmJ6nc36XWsi0W7KKnMNhNrFBfS+N82UuqYh1mbzuoufoxPi5wT4bFffRDWFO13DjZDB5SzQrHuZ4okjNp6vw6aOBm6RvGmKIHA/t3c/LTFzxqT5xpKu18YtBCZdcODI1hFcJUW6NFKEDDV3A010YjpggxG3t6SowG8cW7AAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178411; c=relaxed/simple;
	bh=3q0KeiE+LWmMVP8zqJqe1dxtXrGlDqbcbDL3Jjmc6L4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G41GCQ5XY5WOo4DuN9XXNrQY3bd+q76E3HuCUW/wjrom8hyS1vUF4qVFdSH4M7htCdaXJpxO3uFqHuORvYtU2swgtKcwNGu3FCq3STxbi0BknS8zF1w0aNmZCUhFyRDWsp2WT2d+aXvqNvBCvwPiEdRqd/c/d2qfX9t9p+2MHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSXvU56+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSXvU56+"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fc4425b6bso135253437b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178408; x=1773783208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3hj3ntzLagxtyiLq/POSOgVuZOwORnDNQtj4DBzdY4=;
        b=mSXvU56+JfvH6RHCCOcVjjXXa+8N+ByiNrdZGy1A/dAeLuGjyeRoYVq+qL2X3kfuQG
         HRwI99q5ziV+hIhtLvA8emkWy/FVphdH1Zv0oQARyv5wS9cdii4glvC1UiwdwcZ9HCpQ
         UsV6ghdrm2BwAKtOj9NGsSGy03bckUYOQS+0KP919MkiLyCEC9uYU5/M9ER3v5avcSed
         iUEsmG8Q+bsDxulKk0BIhHK44zxBKEx9XPGNkJPzZ98aTEDCIy7tcGRytC8BpOHyE3Ff
         bmad1725ysRSibYf8u+Y0/wd157uljQs7mV44Y9WxsJBF8Yywytu6AMWuDryob9Qj3J7
         oDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178408; x=1773783208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+3hj3ntzLagxtyiLq/POSOgVuZOwORnDNQtj4DBzdY4=;
        b=UmnxUIhYDmswAFLOcQ/cGSasjSwB8liFx2bfQtiX74mpguXB+k6t5gZL7moKlBXZrz
         CL3xhffhiWY8XpG7GBfU/Bt0IskJFsa9ctimEKoM8n6QedsnVwAl5GYQGYNoiDNdm63/
         FhHiNpvC4KPlIdnOjgeNYH8mS3HcjyOBCfw6I1rdoLX4oNacVGK+TgMRRpGKTu1gozJj
         cp2BQ7pOMaZn/ydDQhv3dXZfdKbq3sHmdtQmgL5wCNLgdUSGZA0zvogknmWLoxPua2BP
         +KA6d+jSpDk773ydpuhzc/liAMR2RHxbEpPKw7qpAO++xN4r/2mgLHMwayFDEh2ClphW
         tmjw==
X-Gm-Message-State: AOJu0Yy336E5TYZ53mHpLUP6RAammHSNhfyAMNNwM0gf9YmcAuqExPkx
	I9HGcx2DQRBGF5tRfzgNQ9axR+Ri4gpFdmjoV71ITUXfKcDCPinynWla0wA8Uc5n
X-Gm-Gg: ATEYQzyks2K6LsuUp5HlxgborrMKrdYEDP67wvfBG8GwIz/WF7/8/PNe6XdPfR2ZA54
	jkzidrpR6cvUmB8p8jvNNK8PA22uMFOWhN0zN1V6LtQHcolEWePINjjQ8vAotx+Tsl0P1Fi2c+R
	9P7+IUInYMPmxOf32MO3dUqgUhsI7us5qufZ7H7+6ZZx9Pp0LhFb19muKCIPvLPMMzW7wLfRROy
	EhZQ6iazrBcZUBhbDlzN5KnjUO2joyjpi4F+dmH/ABYmh7ppJpGCErvfnBSX5kQ+/m66CCCDDgg
	I/bbeg2FK9A6qdchaeOeHIr7Kf425LLHc2F+ubEJMjef17WU4GkyFId1Emn/wQ7BFmGPceXw8O6
	xNSJIbZzkHYv0SXPSYgsFgIMhnzv2p2yeGRebTNRbz8VRuKEBcqauv3QO7nSiCPYKejdN0NncIH
	c5Df5XQceR22LxrtQElodBno4IKSzq7IOCjs4sqB3HYPgcW/nUDP6DfBXpxmjcCc7SLYU+52LAs
	rDQRlXVK9TYgiOA/A==
X-Received: by 2002:a05:690c:a92:b0:794:7072:b311 with SMTP id 00721157ae682-79917f7e018mr1918757b3.52.1773178408069;
        Tue, 10 Mar 2026 14:33:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1ecd9sm952777b3.45.2026.03.10.14.33.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:33:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/7] doc/btmon: Add LE Audio protocol flow documentation
Date: Tue, 10 Mar 2026 17:33:10 -0400
Message-ID: <20260310213314.729718-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310213314.729718-1-luiz.dentz@gmail.com>
References: <20260310213314.729718-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add comprehensive LE Audio protocol flow documentation covering:

- PACS (Published Audio Capabilities): Sink/Source PAC reads with
  LC3 codec capability decoding (sampling frequency, frame duration,
  channel counts, frame length), audio locations, and available
  audio contexts.

- ASCS (Audio Stream Control): ASE state machine (Idle through
  Streaming and Releasing), ASE Status notifications with full
  codec config decoding, ASE Control Point operations table
  (Config Codec, Config QoS, Enable, Disable, Release, etc.).

- CIS Setup and Teardown: CIG Parameters, CIS creation, CIS
  Established event, ISO Data Path setup, and ISO data flow.

- Broadcast Audio (BIG): BASE announcements in periodic advertising,
  BIG creation (source), BIG sync (receiver).

- Automating LE Audio Analysis: grep patterns for ASE state tracking,
  codec verification, CIS establishment, and broadcast detection.
  8-step diagnosis pattern.

- Updated Automated Trace Analysis: Added LE Audio cross-reference
  in workflow step 6, LE Audio reference in connection lifecycle,
  and audio streaming failure debugging scenario.
---
 doc/btmon.rst | 328 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 326 insertions(+), 2 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index cc4f81bed2d7..3084acad7107 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1568,6 +1568,319 @@ channel, note the Source CID and Destination CID from the Connection
 Request/Response pair. Then search for those CIDs in subsequent data
 frames.
 
+LE AUDIO PROTOCOL FLOW
+=======================
+
+LE Audio uses a multi-layer protocol stack visible in btmon traces.
+The setup sequence involves ATT operations on specific GATT
+characteristics (PACS, ASCS) followed by HCI-level CIS/BIG
+management. btmon fully decodes all layers.
+
+PACS: Published Audio Capabilities
+------------------------------------
+
+Before audio streaming begins, devices exchange codec capabilities
+via the Published Audio Capabilities Service (PACS). The client reads
+PACS characteristics to learn what the remote device supports.
+
+**Sink PAC read** (remote device's receive capabilities)::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 7    #550 [hci0] 0.824003
+          ATT: Read Request (0x0a) len 2
+            Handle: 0x0075
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 30   #552 [hci0] 0.886556
+          ATT: Read Response (0x0b) len 25
+            Handle: 0x0075
+              Number of PAC(s): 1
+              Codec: LC3 (0x06)
+              Codec Specific Capabilities: #0
+                Sampling Frequency: 8000 Hz 16000 Hz 24000 Hz 32000 Hz 48000 Hz
+                Frame Duration: 7.5 ms 10 ms
+                Audio Channel Counts: 1
+                Frame Length: 26 - 240
+
+The PAC record shows codec capabilities using LTV (Length-Type-Value)
+encoding. Key fields:
+
+- **Codec** -- ``LC3 (0x06)`` is the mandatory LE Audio codec
+- **Sampling Frequency** -- Supported sample rates (bitmask)
+- **Frame Duration** -- Supported frame durations (7.5 ms and/or 10 ms)
+- **Audio Channel Counts** -- Supported channel counts
+- **Frame Length** -- Min and max octets per codec frame
+
+**Audio Locations** (channel assignment)::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 9    #554 [hci0] 0.948003
+          ATT: Read Response (0x0b) len 4
+            Handle: 0x0077
+              Location: Front Left
+
+**Available Audio Contexts** (current use cases)::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 9    #558 [hci0] 1.012556
+          ATT: Read Response (0x0b) len 4
+            Handle: 0x007b
+              Sink Context: Media Conversational
+              Source Context: Unspecified
+
+ASCS: Audio Stream Control
+----------------------------
+
+The Audio Stream Control Service (ASCS) manages the ASE (Audio Stream
+Endpoint) state machine. Each ASE transitions through a defined set
+of states as streaming is set up and torn down.
+
+**ASE State Machine**::
+
+    Idle ──► Codec Configured ──► QoS Configured ──► Enabling ──► Streaming
+                                                                      │
+    Idle ◄── Releasing ◄──────── Disabling ◄─────────────────────────┘
+
+**ASE Status notification** (state change)::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 20   #580 [hci0] 1.456003
+          ATT: Handle Value Notification (0x1b) len 15
+            Handle: 0x0088
+              ASE ID: 0x01
+              State: Codec Configured (0x01)
+                Framing: Unframed PDUs supported (0x00)
+                PHY: 0x02
+                  LE 2M PHY (0x02)
+                RTN: 2
+                Max Transport Latency: 10
+                Presentation Delay Min: 20000 us
+                Presentation Delay Max: 40000 us
+                Preferred Presentation Delay Min: 20000 us
+                Preferred Presentation Delay Max: 40000 us
+                Codec: LC3 (0x06)
+                  Sampling Frequency: 48000 Hz
+                  Frame Duration: 10 ms
+                  Audio Channel Allocation: Front Left
+                  Frame Length: 120
+
+**ASE Control Point operations** drive state transitions. The client
+writes to the ASE Control Point characteristic to issue commands::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 25   #582 [hci0] 1.518003
+          ATT: Write Request (0x12) len 20
+            Handle: 0x008b
+              ASE Control Point: Config Codec (0x01)
+                ASE ID: 0x01
+                Target Latency: Low Latency (0x01)
+                PHY: LE 2M PHY
+                Codec: LC3 (0x06)
+                  Sampling Frequency: 48000 Hz
+                  Frame Duration: 10 ms
+                  Audio Channel Allocation: Front Left
+                  Frame Length: 120
+
+ASE Control Point commands:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 25 65
+
+   * - Opcode
+     - Command
+     - Purpose
+   * - 0x01
+     - Config Codec
+     - Select codec and parameters (Idle → Codec Configured)
+   * - 0x02
+     - Config QoS
+     - Set CIG/CIS IDs and QoS params (Codec Configured → QoS Configured)
+   * - 0x03
+     - Enable
+     - Start ASE with metadata (QoS Configured → Enabling)
+   * - 0x04
+     - Receiver Start Ready
+     - Signal receiver readiness (Enabling → Streaming, server-side)
+   * - 0x05
+     - Disable
+     - Stop streaming (Streaming → Disabling)
+   * - 0x06
+     - Receiver Stop Ready
+     - Signal receiver stopped
+   * - 0x07
+     - Update Metadata
+     - Change metadata during streaming
+   * - 0x08
+     - Release
+     - Tear down ASE (any → Releasing → Idle)
+
+CIS Setup and Teardown
+------------------------
+
+After ASE QoS Configuration, the host creates Connected Isochronous
+Streams (CIS) at the HCI level.
+
+**CIG Parameters** (configure the CIS group)::
+
+    < HCI Command: LE Set CIG Parameters (0x08|0x0062) plen 26  #590 [hci0] 1.624003
+          CIG ID: 0x00
+          Central to Peripheral SDU Interval: 10000 us
+          Peripheral to Central SDU Interval: 10000 us
+          SCA: 0x00
+          Packing: Sequential (0x00)
+          Framing: Unframed (0x00)
+          Central to Peripheral Max Latency: 10 ms
+          Peripheral to Central Max Latency: 10 ms
+          Number of CIS: 1
+          CIS ID: 0x00
+          Central to Peripheral Max SDU: 120
+          Peripheral to Central Max SDU: 0
+          Central to Peripheral PHY: LE 2M PHY
+          Peripheral to Central PHY: LE 2M PHY
+          Central to Peripheral RTN: 2
+          Peripheral to Central RTN: 2
+
+    > HCI Event: Command Complete (0x0e) plen 8              #592 [hci0] 1.624556
+          LE Set CIG Parameters (0x08|0x0062) ncmd 1
+            Status: Success (0x00)
+            CIG ID: 0x00
+            Number of Handles: 1
+            Connection Handle: 2064
+
+**CIS Creation**::
+
+    < HCI Command: LE Create CIS (0x08|0x0064) plen 9       #594 [hci0] 1.688003
+          Number of CIS: 1
+          CIS Handle: 2064
+          ACL Handle: 2048
+
+    > HCI Event: LE Meta Event (0x3e) plen 29                #596 [hci0] 1.756556
+          LE CIS Established (0x19)
+            Status: Success (0x00)
+            Connection Handle: 2064
+            CIG Sync Delay: 5000 us
+            CIS Sync Delay: 5000 us
+            Central to Peripheral Latency: 10000 us
+            Peripheral to Central Latency: 10000 us
+            Central to Peripheral PHY: LE 2M PHY
+            Peripheral to Central PHY: LE 2M PHY
+            NSE: 3
+            Central to Peripheral BN: 1
+            Peripheral to Central BN: 0
+            Central to Peripheral FT: 2
+            Peripheral to Central FT: 2
+            Max PDU C to P: 120
+            Max PDU P to C: 0
+            ISO Interval: 10.00 msec (0x0008)
+
+Note that the CIS Handle (2064) is different from the ACL Handle
+(2048). CIS data packets use the CIS handle.
+
+**ISO Data Path Setup**::
+
+    < HCI Command: LE Setup ISO Data Path (0x08|0x006e) plen 13  #598 [hci0] 1.820003
+          Handle: 2064
+          Data Path Direction: Input (Host to Controller) (0x00)
+          Data Path ID: HCI (0x00)
+          Coding Format: LC3 (0x06)
+          Company ID: 0x0000
+          Vendor Codec ID: 0x0000
+          Controller Delay: 0 us
+
+After this, ISO data packets flow on the CIS handle::
+
+    < ISO Data TS: Handle 2064 flags 0x02 dlen 124  #600 [hci0] 1.884003
+
+Broadcast Audio (BIG)
+----------------------
+
+Broadcast Isochronous Streams use BIG (Broadcast Isochronous Group)
+instead of CIS. The setup involves periodic advertising with BASE
+(Broadcast Audio Source Endpoint) announcements.
+
+**BASE announcement** (in periodic advertising data)::
+
+    > HCI Event: LE Meta Event (0x3e) plen 80                #200 [hci0] 0.500003
+          LE Periodic Advertising Report (0x0f)
+            ...
+            Service Data: Basic Audio Announcement (0x1851)
+              Presentation Delay: 40000 us
+              Number of Subgroups: 1
+                Number of BIS: 2
+                Codec: LC3 (0x06)
+                  Sampling Frequency: 48000 Hz
+                  Frame Duration: 10 ms
+                  Frame Length: 120
+                BIS #1
+                  Audio Channel Allocation: Front Left
+                BIS #2
+                  Audio Channel Allocation: Front Right
+
+**BIG creation** (source side)::
+
+    < HCI Command: LE Create BIG (0x08|0x0068) plen 31      #210 [hci0] 0.600003
+          BIG Handle: 0x00
+          Advertising Handle: 0x01
+          Number of BIS: 2
+          SDU Interval: 10000 us
+          Max SDU: 120
+          Max Latency: 10 ms
+          RTN: 2
+          PHY: LE 2M PHY
+          Packing: Sequential (0x00)
+          Framing: Unframed (0x00)
+          Encryption: Unencrypted (0x00)
+
+**BIG sync** (receiver side)::
+
+    < HCI Command: LE BIG Create Sync (0x08|0x006b) plen 15  #220 [hci0] 0.700003
+          BIG Handle: 0x00
+          Sync Handle: 0x0001
+          Encryption: Unencrypted (0x00)
+          Number of BIS: 2
+          BIS: 0x01
+          BIS: 0x02
+
+Automating LE Audio Analysis
+------------------------------
+
+**Identify LE Audio activity**::
+
+    grep -n "ASE Control Point\|ASE ID\|State:.*Codec Configured\|State:.*QoS Configured\|State:.*Enabling\|State:.*Streaming\|State:.*Releasing" output.txt
+
+**Track ASE state transitions** for a specific ASE::
+
+    grep -n "ASE ID:" output.txt
+
+Then examine the ``State:`` line following each ASE ID match.
+
+**Check codec configuration**::
+
+    grep -n "Codec: LC3\|Sampling Frequency:\|Frame Duration:\|Frame Length:\|Audio Channel" output.txt
+
+**Verify CIS establishment**::
+
+    grep -n "Set CIG Parameters\|Create CIS\|CIS Established\|Setup ISO Data Path" output.txt
+
+**Detect CIS failures** -- check the Status field after
+``CIS Established``::
+
+    grep -n "CIS Established" output.txt
+
+Then examine the following line for ``Status:``.
+
+**Detect broadcast audio**::
+
+    grep -n "Basic Audio Announcement\|Create BIG\|BIG Complete\|BIG Create Sync\|BIG Sync" output.txt
+
+**Full LE Audio diagnosis pattern**:
+
+1. Find PACS reads -- verify codec compatibility between devices
+2. Find ASE Control Point writes -- trace the Config Codec → Config
+   QoS → Enable sequence
+3. Find ASE state notifications -- verify each transition succeeds
+4. Find CIG Parameters and CIS creation -- verify HCI-level setup
+5. Find ``CIS Established`` -- check Status for success
+6. Find ``Setup ISO Data Path`` -- verify data path configuration
+7. Find ISO Data packets -- confirm audio is flowing
+8. On failure, check ASE Control Point notification responses for
+   error codes (Response Code and Response Reason fields)
+
 EXAMPLES
 ========
 
@@ -1633,7 +1946,8 @@ Recommended Workflow
 
        grep -n "Pairing Request\|Pairing Response\|Pairing Failed\|Encryption Change" output.txt
 
-6. **Identify LE Audio**: Search for ASCS and CIS activity::
+6. **Identify LE Audio**: Search for ASCS and CIS activity (see
+   `LE AUDIO PROTOCOL FLOW`_)::
 
        grep -n "ASE Control Point\|CIG Parameters\|Create Connected Isochronous\|CIS Established\|Setup ISO Data Path" output.txt
 
@@ -1680,7 +1994,8 @@ pattern in the trace:
    `L2CAP CHANNEL TRACKING`_ for channel setup.
 5. ``Disconnect Complete`` -- connection ended, check Reason field
 
-For LE Audio connections, additional steps appear between 3 and 5:
+For LE Audio connections, additional steps appear between 3 and 5
+(see `LE AUDIO PROTOCOL FLOW`_ for full details):
 
 - ATT operations on PACS/ASCS characteristics (codec negotiation)
 - ``LE Set CIG Parameters`` command and response
@@ -1706,6 +2021,15 @@ Common Debugging Scenarios
 5. If no SMP traffic on reconnect but ``Encryption Change`` fails,
    the bond was lost on one side
 
+**Audio streaming failure diagnosis** (see `LE AUDIO PROTOCOL FLOW`_):
+
+1. Check PACS reads -- do both devices support compatible codecs?
+2. Check ASE Control Point Config Codec -- was it accepted?
+3. Check ASE state notifications -- did the ASE reach Streaming?
+4. Check ``CIS Established`` -- was Status Success?
+5. Check ``Setup ISO Data Path`` -- was it configured?
+6. Check for ISO Data packets -- is audio actually flowing?
+
 **Connection parameter negotiation failure**:
 
 1. Find ``Connection Parameter Update Request`` (L2CAP level)
-- 
2.53.0

