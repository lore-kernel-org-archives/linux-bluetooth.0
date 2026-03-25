Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C4324B2C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464859; cv=none; b=ZdldisxBwK9dKfayrsqNV10xmsqNT/rk0yD4tjlWx5/ulKDwQbbERtMYSN6fFRYaBzVgcqWybjmNK7oxcqzNUx2uwn9BOBBBKqmJSE78dowJADw8lV0iNOKrXVvzZ9B7SJmeDfT3qO0i0BIbHjlSdqrVt4QsaMjFbw/W0c9Cyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464859; c=relaxed/simple;
	bh=cz+GfKx8GwOXg7WlJcEp9mcRdDF7UzsthprXXxnDzvw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQBonBDiL10aj0eB7kFvMIP24u7+0iyoBiYT/F690ocT+cLV+GFZUnLqSEHqe1UPhYOsW+Rm43CebFA+uZvpNOMAHrdWaGSQXBKf8m3cj5FM9XwkNSVb/ZsXmeb30uXktnGtXVijMX4ZQhxWXS7o78nCrqS4C/RjOKCRpLVZnfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBAV9xiB; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBAV9xiB"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso236652e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464856; x=1775069656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGstBNyH+Da3AQ/QuaFssc4+IDMjL0HF6yVtYdJqWa4=;
        b=cBAV9xiBSNVlOFrYwghQuUZmHXpe0wUwnS45UpxxWzGB2I6muYfzPX7K/pDFc1h50c
         IoHhb1a5XJ2Bsi484d+sWJuy7y+Yv426e7qChQQVI0atGIaShE6gOPxfNfJIa18ScX5a
         LeKQBzST3nKi0oALS7GxFq/TqfzF1iGSKEQwfKnmAuZGjj05K9MHRVsJxuw+NkhR3JFP
         Y7IL/dU4dkZOiGRWdcUTPfC5S2SH3vIS7bguMtkt1QKQ1VC4f5goowRNuyLCneZbnF55
         FlZ0jJdFVzGWi618sSsO4KJ1FYdr+nTxWesv+T0Wirz3HDobmSJhgIkf9suz78+kzEBY
         EwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464856; x=1775069656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGstBNyH+Da3AQ/QuaFssc4+IDMjL0HF6yVtYdJqWa4=;
        b=mwbKLey2luA2vkdZZS1XvgaOkndB5dzF7lBw8pYL6wLgoqa+B0VHUyjMCbGveg4EqM
         2WreBgwyMJSnfPJ/JgcV83+AKg4FMtrG+2gl+WJhyeMPld8tq4q1v4Jzs1wDuO78ygj2
         hp7A3UgXffAz1ggeDsyvO6204Pk+iqHQFCTytetvsCSlw57mmdt5JQgmssRRJFXrxy8L
         My/DdWx4cQ0VhWVrFsA8lLhmPDGDcmBv/exTzby/RqTPVF3HUKDkdw9H2AiWNKvvI5da
         dzpbvqQ3FAEqNwWaliOX3T90JfKI7jNARID+NrF+f52Xx0qpkCjRirU5iRB58olwmIRT
         T2nA==
X-Gm-Message-State: AOJu0Yyitmq38MFl/bAQvheR6kS+QFKSGHgx3k0wqlZZKwLXyBQdmmyP
	u9AzRmVv5SatHBo4vt/usRJhuxpupS6fFvzNJWJ/GbjJZbqugE7cQRZMlVBpJJJm
X-Gm-Gg: ATEYQzy0weF4sLXs0NczC4r/8sxTexjfxVGWz5R0hxbKy4+ZzrdfJg/CaZkIMq66IoT
	nRkrxZPwZIGRXgFBeo97qnJTWwN9P062rT312VRCs0MBzKrP6hc9UcYitQvjF0jbqWs8ax15IjG
	IXijcJI4LfcGBfQ/yYBwGagzsYe+JVs2xsyzZ6eQyXe647OK1oMFKBxMFCuPOmPDr1a2isL3DZV
	Lk4VeHyEzwxEP8kBTnJe/B6hcnUoojarVtDFNXpsV4Ql5zqqir5Bl5pOpZTqsCaG1FCdigstC4s
	9iqQBbSirv1rgmD2MwzWxBKugRxO6oceCB5q4+lfEfNI6SkaPZ/3MbUGcLDibYWjgR2u09WX/PB
	FrnYYlTHDEuh0n9NsXYs/YtfNW2ctzOFvrsPVb6ansdXgwvdQBThB5W70kyU6uNmfTdWyjsINkR
	572SRkUf+8pRnN1H61haqh33qFXj6Juku4RXy8D/4lU9r1fvHVizAFEuGHImuxxU5c6q+kmtZSA
	hyzwEnJBfAhwIQR4A==
X-Received: by 2002:a05:6122:2529:b0:56a:ef89:3504 with SMTP id 71dfb90a1353d-56d21f0d331mr2522750e0c.4.1774464856074;
        Wed, 25 Mar 2026 11:54:16 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d71947sm921438e0c.14.2026.03.25.11.54.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:54:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/9] doc/btmon: Split Advertising and Scanning into btmon-advertising.rst
Date: Wed, 25 Mar 2026 14:53:57 -0400
Message-ID: <20260325185406.568078-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Move the ADVERTISING AND SCANNING section into a standalone file and
replace it with an RST include directive. This allows the
btsnoop-analyzer to load only the relevant documentation for
advertising/scanning focus-area analysis instead of the full btmon.rst.
---
 Makefile.am               |   2 +
 doc/btmon-advertising.rst | 155 ++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst             | 155 +-------------------------------------
 3 files changed, 160 insertions(+), 152 deletions(-)
 create mode 100644 doc/btmon-advertising.rst

diff --git a/Makefile.am b/Makefile.am
index dee6aa6d0d9b..9ab2a8231307 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -538,6 +538,8 @@ EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 
 EXTRA_DIST += doc/btsnoop-protocol.rst
 
+EXTRA_DIST += doc/btmon-advertising.rst
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
diff --git a/doc/btmon-advertising.rst b/doc/btmon-advertising.rst
new file mode 100644
index 000000000000..dfa5dbb1da66
--- /dev/null
+++ b/doc/btmon-advertising.rst
@@ -0,0 +1,155 @@
+.. This file is included by btmon.rst.
+
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
diff --git a/doc/btmon.rst b/doc/btmon.rst
index 2299c13ca16c..657f33ff19f1 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -2402,159 +2402,10 @@ Errors often cascade across layers. Common patterns:
 4. L2CAP ``Connection refused - security block`` → triggers SMP
    pairing
 
-ADVERTISING AND SCANNING
-==========================
+PROTOCOL FLOWS
+===============
 
-btmon decodes advertising data structures automatically. Advertising
-and scan response data appears in HCI LE advertising report events
-and in advertising command parameters.
-
-Advertising Reports
---------------------
-
-When the controller reports received advertisements::
-
-    > HCI Event: LE Meta Event (0x3e) plen 43              #120 [hci0] 0.500003
-          LE Extended Advertising Report (0x0d)
-            Event type: 0x0013
-              Props: 0x0013
-                Connectable
-                Scannable
-                Complete
-            Address type: Random (0x01)
-            Address: 00:11:22:33:44:55
-            Primary PHY: LE 1M
-            Secondary PHY: LE 2M
-            SID: 0x01
-            TX power: 0 dBm
-            RSSI: -55 dBm (0xc9)
-            Data length: 18
-
-The advertising data (AD) structures within the report are decoded
-as typed fields:
-
-**Common AD types btmon decodes**:
-
-.. list-table::
-   :header-rows: 1
-   :widths: 10 30 60
-
-   * - AD Type
-     - Name
-     - Example in btmon output
-   * - 0x01
-     - Flags
-     - ``Flags: 0x06`` with decoded bits (LE General Discoverable,
-       BR/EDR Not Supported)
-   * - 0x02/0x03
-     - Incomplete/Complete 16-bit UUIDs
-     - ``16-bit Service UUIDs (complete): 2 entries``
-       followed by UUID list
-   * - 0x06/0x07
-     - Incomplete/Complete 128-bit UUIDs
-     - ``128-bit Service UUIDs (complete): 1 entry``
-   * - 0x08/0x09
-     - Shortened/Complete Local Name
-     - ``Name (complete): MyDevice``
-   * - 0x0a
-     - TX Power Level
-     - ``TX power: 4 dBm``
-   * - 0x16
-     - Service Data (16-bit UUID)
-     - ``Service Data (UUID 0x184e): ...`` with protocol-specific
-       decoding
-   * - 0xff
-     - Manufacturer Specific Data
-     - ``Company: Apple, Inc. (76)`` followed by hex data
-
-**Typical advertising report**::
-
-    > HCI Event: LE Meta Event (0x3e) plen 38              #120 [hci0] 0.500003
-          LE Extended Advertising Report (0x0d)
-            Address: 00:11:22:33:44:55
-            RSSI: -62 dBm (0xc2)
-            Flags: 0x06
-              LE General Discoverable Mode
-              BR/EDR Not Supported
-            Name (complete): LE-Audio-Left
-            16-bit Service UUIDs (complete): 3 entries
-              Published Audio Capabilities (0x1850)
-              Audio Stream Control (0x184e)
-              Common Audio (0x1853)
-            Service Data (UUID 0x1852): 01a2b3
-            Appearance: Earbud (0x0941)
-
-Extended Advertising
----------------------
-
-Modern controllers use extended advertising commands and events.
-The setup sequence in btmon::
-
-    < HCI Command: LE Set Extended Adv Parameters (0x08|0x0036) plen 25  #50 [hci0] 0.100003
-          Handle: 0x01
-          Properties: 0x0000
-          Min advertising interval: 160.000 msec (0x0100)
-          Max advertising interval: 160.000 msec (0x0100)
-          Channel map: 37, 38, 39 (0x07)
-          Own address type: Random (0x01)
-          Peer address type: Public (0x00)
-          PHY: LE 1M, LE 2M
-          SID: 0x01
-          TX power: 7 dBm
-
-    < HCI Command: LE Set Extended Adv Data (0x08|0x0037) plen 35  #52 [hci0] 0.101003
-          Handle: 0x01
-          Operation: Complete extended advertising data (0x01)
-          Fragment preference: No fragmentation (0x01)
-
-Periodic Advertising (LE Audio)
---------------------------------
-
-LE Audio broadcast sources use periodic advertising to transmit
-BASE announcements containing codec configuration::
-
-    > HCI Event: LE Meta Event (0x3e) plen 80              #200 [hci0] 0.500003
-          LE Periodic Advertising Report (0x0f)
-            Sync handle: 0x0001
-            TX power: 0 dBm
-            RSSI: -45 dBm
-            CTE Type: No CTE (0xff)
-            Data status: Complete (0x00)
-            Data length: 60
-            Service Data: Basic Audio Announcement (0x1851)
-              Presentation Delay: 40000 us
-              Number of Subgroups: 1
-                Codec: LC3 (0x06)
-                  Sampling Frequency: 48000 Hz
-                  Frame Duration: 10 ms
-                  Frame Length: 120
-
-Automating Advertising Analysis
----------------------------------
-
-**Find all advertising reports** (devices seen)::
-
-    grep -n "Advertising Report\|Address:.*RSSI:" output.txt
-
-**Extract device names**::
-
-    grep -n "Name (complete):\|Name (short):" output.txt
-
-**Find LE Audio devices** (by service UUIDs in advertising)::
-
-    grep -n "Audio Stream Control\|Published Audio Capabilities\|Common Audio\|Basic Audio Announcement\|Broadcast Audio" output.txt
-
-**Track advertising setup** (local device configuring advertising)::
-
-    grep -n "Set Extended Adv\|Set Advertising\|Set Scan Response\|Adv Enable" output.txt
-
-**Find periodic advertising** (broadcast audio)::
-
-    grep -n "Periodic Advertising\|PA Sync\|PA Report\|Basic Audio Announcement\|Broadcast.*Announcement" output.txt
-
-**Identify devices by appearance**::
-
-    grep -n "Appearance:" output.txt
+.. include:: btmon-advertising.rst
 
 EXAMPLES
 ========
-- 
2.53.0

