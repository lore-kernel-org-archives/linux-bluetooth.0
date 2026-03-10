Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A843D092C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162703; cv=none; b=dfNlsB1hAzAp8iiMjtqrplL/50ap1mBNXTjwKIFWulRNjDZfnNBMlOdzoUST8B87/UXGNbtY6adSdeePcwhc6Vta3c3b6RTU2/ikRvkO65pozKvPVWeOawI8xZhwO8rW1iZjOIsLuZHdv9KjQJzRehH2o99HKK2ZhPYq3XBuv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162703; c=relaxed/simple;
	bh=3q0KeiE+LWmMVP8zqJqe1dxtXrGlDqbcbDL3Jjmc6L4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoJADofYPmvmhz4F0PtbtTYbtYfy2+58GsoKuAeq45PtnuI4cDKN4ZbDaVjh0Tvx4q3M/M8wfKY+/1XM2faW7CZf8+GSj1pJUPdcEXC0NxEITpE8Inx5lBTBTVDA8f28XPRAcwEAFbTikdwRXdyU/2EK+nIvDzR+ipRuvdaI0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu6JW37h; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu6JW37h"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79900d6dc3cso21418537b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162700; x=1773767500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3hj3ntzLagxtyiLq/POSOgVuZOwORnDNQtj4DBzdY4=;
        b=Mu6JW37hEJGN7ktNXS7d/RnP/S2GZyWb/Oxes/ff3F8vwXPx7/IM9kC4zTmBv+kbUm
         B75Iq7qO8ZgynVZh49iro+2c/EA/Rbr/iOUe1X2tPpzBiCxtWqf4oyZSEB8YSlqNOVu0
         c3MdqXy4p0IZ8kZOEcBKVlSA6hroJgL2LPz3sX0xYzyM3AmHty2OD62AjBsm4addF1Uj
         F0fPuLUHLDj/yC9jD88I1tLw9irNgkttIkCywA8R01x2fVbiY1TYbCTMf5XMdsFV6jsf
         4doEEaWfJnI2eSbNWuuuUPcygJNRyOm5wB/F7R6vCrFvwGHPbk4oowV5Cre1eEmXadCy
         8ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162700; x=1773767500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+3hj3ntzLagxtyiLq/POSOgVuZOwORnDNQtj4DBzdY4=;
        b=UAjGOuaVhO5uB5TdCC1OUDH5yN2eTfdQjR0VzbOH3Y7GRYK9WVEfwMWbrGZ8blGKQd
         VpoSJ9WDkzRlwYjB/o6/dIwQGiRtZF+BjBBE/Y/idXJLriHjqQ2e7SeqHSIa/WezlbKB
         FTnSPvxqX6CE5Jgl+bf+JiwEdOnGigs7QZFjjzPrz0K7dHq66+EzEB5a9ea8zvYm47M/
         mLD3DNMU6nX6OmDRTHZO3pu0v9BYjfCWnsS2B7+Q48xbqavVnRp9kI1U+DVNvg8VrTfm
         5fsjOm7I8n1bbqgQWvA4xPkA7/Zx3VwQZ8M59Fo5RA+RqQFEmV0OgaJKZ4GO1baaYP2s
         cWbQ==
X-Gm-Message-State: AOJu0YzLqqx4YaMQdF0/ss3ZkJBGpvn4GweYY0Ybd/AaFCbR9A3rQUG0
	GaL/ZOd3+/HKA7vtPTSM6G2L9sfdKda8Vb3yuS0VuWpMJGRVmhxqAvV5y7JZVg==
X-Gm-Gg: ATEYQzxED3mjH8PT31xV4pxrX9bWx+0nI+iqcxVBuJtRJ6IMIc7GES74yIt4ruIWMqQ
	ifxnUVi+wQR5y7MMrUX/xaqvRPwph1mD1LBE+4tWD2JY70xR8XFnpnnHWX3rjNQOiETRaVFfCl2
	c2t3uqS/1j2riAo3tJs+FPDKgcE8+kWa89D4rl9ML5+8ec2OTaaCpfEA7JDlV+HrewW8v3cIRwk
	uI05PDXgqFNabCq1AgntCW+aE4ROkmTCao7zH8NgENo4Gd3/Wdai2rDn4VWJSAZ1uhkvMic36Jl
	Iynvf6KrPsni+gEycKASHpZSp62wlw7/mioBlSyxoFFBrOXNyZr6CRZ3oYgKW5bnd0ZygZnRup6
	FhDD+4VZ+3My3ytApKm8PQFQQnw96obVri6msjBbo+xACryiSMjCqU4Jl1oGqhqpRvTOt1doXjh
	OqqiuzBcYDVIQUMcOOpUFGV+US/Lqp/GhFWCFfkb6/M/MetapNhLjG0OJJdeXRN/Zi8YvWikv27
	fw/Q1otGeWeRfeCAQ==
X-Received: by 2002:a05:690c:6107:b0:799:ad1:d755 with SMTP id 00721157ae682-7990ad1dc19mr39777057b3.41.1773162700068;
        Tue, 10 Mar 2026 10:11:40 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a51a245sm19745357b3.5.2026.03.10.10.11.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:11:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/6] doc/btmon: Add LE Audio protocol flow documentation
Date: Tue, 10 Mar 2026 13:11:17 -0400
Message-ID: <20260310171126.342447-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310171126.342447-1-luiz.dentz@gmail.com>
References: <20260310171126.342447-1-luiz.dentz@gmail.com>
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

