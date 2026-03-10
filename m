Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CD321445
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162705; cv=none; b=AF8WnTaIc6UVb98FUto5pp6SDL+taKdaGWnncN/hZfclXdv5YH/20PfsSQ7931KsM8zxxLJ71sLJ0ucVihP4b0SHBxgZs0wowtB50Ap4eShRsMW8tO60UBSd1exEmSYHAKAi0Khjhbur9k2jtfh9CZmsBpUy30VdJJpXsAxDdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162705; c=relaxed/simple;
	bh=GoQpGiMr9LHstnEK83ylH5g+AX4Z8j5yIwssBCzVZDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukQcu2O1Cq97ESRzsYbHmKMTh6m6WvuHiqKE2i1EkgBd0NQ56jM1TgeNEPA9QV8LbCAWJx+HpsHxWs2sTAIErI2C6iwKy7Iyhq73UrjZTxHIm/Qp5JZhhRBhzjNWK95ttNxmx7Q9LN/sVHlVWoW1m/P7hiIu0kElWrKst5SvAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQiZYqI/; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQiZYqI/"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79495b1aaa7so117251567b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162703; x=1773767503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdrRJfNC9HVgreEp6yj07jro8lNYMr1LI2Z9Jxf1hqE=;
        b=YQiZYqI/K+A0ea/ziW5qBnEL39Dl0GE+Wddoq8atLTU1Kfqk2eSAiUFegVfppnpfqE
         5vQXPWsvoDkudYCrR2M6gsageECliT81WQ13DwfZ5eO5fzAyF8GE4i1ZppGkWoSv4A86
         fwk2jKXoDjZGngiaAZx9GneTdgGi/TB/+IxM02AVy/qeDEKT/81ZW2ZRdAuyZJXWtG+r
         njAdA44S2uy6srLhWEo2WKZP5dRLNgokk1In8gvW81fvS03/CMrC0FT60G00706LxA0S
         NwapN3VBeN9/8d/vL2H3K5+9qr6qwjTNzJcZjTgWxyMw2xqrobmNOGs4t7tbrlh4zawx
         vTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162703; x=1773767503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdrRJfNC9HVgreEp6yj07jro8lNYMr1LI2Z9Jxf1hqE=;
        b=aH4CEZpRVoRSmcLA5B3xmWUXfp6ao7zezBlp0vRLE52KXL7Ah79XeqW8pJGyC60CQt
         CQG4NCymTdgSQla0N7UXK0CJ1Um7plgVyKZGJUyI9S1nL/eONQoBfhcGqJZe7X22eEbQ
         jcZ5gyrr09l7VcRdEMtGojEIHkJdC5k6MV0NHogmLwTgaw0JieyxH2d6ih22KGBy7xwW
         mEbp/IYXTfWI50sZ1RNAvFdiFctHJoCN7iVeTldL7w+vxXhMHzKfBGKXBIcvdI7fNZob
         JkZWIZFoNAQdZXzp731ueK10HYE+2YRLOXjp4j4qBTawNnvJ8Sr+rYBbx56y24B3TtNq
         gQZA==
X-Gm-Message-State: AOJu0Yyj+N4sMLrkOEkPdzRaEWoLhD9EX07wpSMlnkPxpTvw1ukFdBD6
	oYpEVmkmh/8wrYdchW68kb9n8usMv5dZSw69GcA39vZCv9Bgm6A9tC04C0g37g==
X-Gm-Gg: ATEYQzxPj4xp0ov8m5VvV6b2h9guNxalYFfVJP0vrzuGIyFHToZlGeW6+FAi+4GIeBz
	9RmbzKbMDcah1Ex1h2SphdaFLcPsV+/d/NpZtkfB8BbdR0XBS4jVYEHyKWt6Pid7j9aQ9wEEuUP
	5DHiGQQ6/HHmcwO8Wf5r7s3/gvpXcLEwAGF2U1oK1or+3DM1eiwxoWDQU0sNC3gCUO0e7Y9BcWr
	lObDtHxPoXMEXO4BqTGi7FJOsKN7a8odg5gxWagfd2dTNiaTWiBol2qAF+fYaxAWaVzXaqPDqoM
	bTpcEFOFkvU4eYkWFyHbi2hS+5M+2yr64t7/JjH06+cPuOBoTkDl48rS63EFKnnvSd76Yrwpw98
	ANJ/j3vcBpV382ZhJQ6CNTe7eXN5bV/eR0BpWfSenxVZkqz6caC3x0RfKOvAZc7o9WuqR2/19un
	2TSu88HR+SSCbCAj0de9UN+X5J6HB/AxvuDxLGUWk1XvGNp9A+mQf+FMKX6T5KAl+j1lSwm7f1+
	7HOj9o/zhNWoJWu4g==
X-Received: by 2002:a05:690c:298:b0:796:3c39:eb58 with SMTP id 00721157ae682-798dd50d58fmr144996137b3.0.1773162702794;
        Tue, 10 Mar 2026 10:11:42 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a51a245sm19745357b3.5.2026.03.10.10.11.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:11:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/6] doc/btmon: Add advertising and scanning documentation
Date: Tue, 10 Mar 2026 13:11:19 -0400
Message-ID: <20260310171126.342447-6-luiz.dentz@gmail.com>
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

Add advertising and scanning documentation covering:

- Advertising Reports: LE Extended Advertising Report decoding with
  event type properties, address, PHY, RSSI, and advertising data.

- Common AD Types: Table of AD types btmon decodes (Flags, 16/128-bit
  UUIDs, Local Name, TX Power, Service Data, Manufacturer Specific).

- Extended Advertising: Extended advertising parameter setup and
  data commands.

- Periodic Advertising (LE Audio): Periodic advertising reports
  carrying BASE announcements for broadcast audio.

- Automating Advertising Analysis: grep patterns for finding
  advertising reports, device names, LE Audio devices by service
  UUID, advertising setup, periodic advertising, and device
  appearance.

- Updated Automated Trace Analysis: Added advertising check step
  in the recommended workflow and updated introduction text with
  cross-references.
---
 doc/btmon.rst | 163 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index fdd54148daab..0d9bbfb177b5 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1129,7 +1129,6 @@ The CCC descriptor at handle 0x000d belongs to the Service Changed
 characteristic (0x000c), because it falls between that value handle
 and the next characteristic declaration at 0x000e.
 
-
 SMP PAIRING FLOW
 ================
 
@@ -2062,6 +2061,160 @@ Errors often cascade across layers. Common patterns:
 4. L2CAP ``Connection refused - security block`` → triggers SMP
    pairing
 
+ADVERTISING AND SCANNING
+==========================
+
+btmon decodes advertising data structures automatically. Advertising
+and scan response data appears in HCI LE advertising report events
+and in advertising command parameters.
+
+Advertising Reports
+--------------------
+
+When the controller reports received advertisements::
+
+    > HCI Event: LE Meta Event (0x3e) plen 43              #120 [hci0] 0.500003
+          LE Extended Advertising Report (0x0d)
+            Event type: 0x0013
+              Props: 0x0013
+                Connectable
+                Scannable
+                Complete
+            Address type: Random (0x01)
+            Address: 00:11:22:33:44:55
+            Primary PHY: LE 1M
+            Secondary PHY: LE 2M
+            SID: 0x01
+            TX power: 0 dBm
+            RSSI: -55 dBm (0xc9)
+            Data length: 18
+
+The advertising data (AD) structures within the report are decoded
+as typed fields:
+
+**Common AD types btmon decodes**:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 30 60
+
+   * - AD Type
+     - Name
+     - Example in btmon output
+   * - 0x01
+     - Flags
+     - ``Flags: 0x06`` with decoded bits (LE General Discoverable,
+       BR/EDR Not Supported)
+   * - 0x02/0x03
+     - Incomplete/Complete 16-bit UUIDs
+     - ``16-bit Service UUIDs (complete): 2 entries``
+       followed by UUID list
+   * - 0x06/0x07
+     - Incomplete/Complete 128-bit UUIDs
+     - ``128-bit Service UUIDs (complete): 1 entry``
+   * - 0x08/0x09
+     - Shortened/Complete Local Name
+     - ``Name (complete): MyDevice``
+   * - 0x0a
+     - TX Power Level
+     - ``TX power: 4 dBm``
+   * - 0x16
+     - Service Data (16-bit UUID)
+     - ``Service Data (UUID 0x184e): ...`` with protocol-specific
+       decoding
+   * - 0xff
+     - Manufacturer Specific Data
+     - ``Company: Apple, Inc. (76)`` followed by hex data
+
+**Typical advertising report**::
+
+    > HCI Event: LE Meta Event (0x3e) plen 38              #120 [hci0] 0.500003
+          LE Extended Advertising Report (0x0d)
+            Address: 00:11:22:33:44:55
+            RSSI: -62 dBm (0xc2)
+            Flags: 0x06
+              LE General Discoverable Mode
+              BR/EDR Not Supported
+            Name (complete): LE-Audio-Left
+            16-bit Service UUIDs (complete): 3 entries
+              Published Audio Capabilities (0x1850)
+              Audio Stream Control (0x184e)
+              Common Audio (0x1853)
+            Service Data (UUID 0x1852): 01a2b3
+            Appearance: Earbud (0x0941)
+
+Extended Advertising
+---------------------
+
+Modern controllers use extended advertising commands and events.
+The setup sequence in btmon::
+
+    < HCI Command: LE Set Extended Adv Parameters (0x08|0x0036) plen 25  #50 [hci0] 0.100003
+          Handle: 0x01
+          Properties: 0x0000
+          Min advertising interval: 160.000 msec (0x0100)
+          Max advertising interval: 160.000 msec (0x0100)
+          Channel map: 37, 38, 39 (0x07)
+          Own address type: Random (0x01)
+          Peer address type: Public (0x00)
+          PHY: LE 1M, LE 2M
+          SID: 0x01
+          TX power: 7 dBm
+
+    < HCI Command: LE Set Extended Adv Data (0x08|0x0037) plen 35  #52 [hci0] 0.101003
+          Handle: 0x01
+          Operation: Complete extended advertising data (0x01)
+          Fragment preference: No fragmentation (0x01)
+
+Periodic Advertising (LE Audio)
+--------------------------------
+
+LE Audio broadcast sources use periodic advertising to transmit
+BASE announcements containing codec configuration::
+
+    > HCI Event: LE Meta Event (0x3e) plen 80              #200 [hci0] 0.500003
+          LE Periodic Advertising Report (0x0f)
+            Sync handle: 0x0001
+            TX power: 0 dBm
+            RSSI: -45 dBm
+            CTE Type: No CTE (0xff)
+            Data status: Complete (0x00)
+            Data length: 60
+            Service Data: Basic Audio Announcement (0x1851)
+              Presentation Delay: 40000 us
+              Number of Subgroups: 1
+                Codec: LC3 (0x06)
+                  Sampling Frequency: 48000 Hz
+                  Frame Duration: 10 ms
+                  Frame Length: 120
+
+Automating Advertising Analysis
+---------------------------------
+
+**Find all advertising reports** (devices seen)::
+
+    grep -n "Advertising Report\|Address:.*RSSI:" output.txt
+
+**Extract device names**::
+
+    grep -n "Name (complete):\|Name (short):" output.txt
+
+**Find LE Audio devices** (by service UUIDs in advertising)::
+
+    grep -n "Audio Stream Control\|Published Audio Capabilities\|Common Audio\|Basic Audio Announcement\|Broadcast Audio" output.txt
+
+**Track advertising setup** (local device configuring advertising)::
+
+    grep -n "Set Extended Adv\|Set Advertising\|Set Scan Response\|Adv Enable" output.txt
+
+**Find periodic advertising** (broadcast audio)::
+
+    grep -n "Periodic Advertising\|PA Sync\|PA Report\|Basic Audio Announcement\|Broadcast.*Announcement" output.txt
+
+**Identify devices by appearance**::
+
+    grep -n "Appearance:" output.txt
+
 EXAMPLES
 ========
 
@@ -2097,7 +2250,8 @@ AUTOMATED TRACE ANALYSIS
 =========================
 
 This section provides guidance for analyzing btmon traces
-programmatically or with AI assistance.
+programmatically or with AI assistance. Each topic references
+the detailed protocol section earlier in this document.
 
 Recommended Workflow
 --------------------
@@ -2168,6 +2322,11 @@ Recommended Workflow
 
        grep -n "PSM:\|Connection Request\|Connection Response\|Parameter Update" output.txt
 
+10. **Check advertising**: See what devices are visible and what
+    they advertise (see `ADVERTISING AND SCANNING`_)::
+
+        grep -n "Advertising Report\|Name (complete):\|Appearance:" output.txt
+
 Key Patterns for Connection Lifecycle
 -------------------------------------
 
-- 
2.53.0

