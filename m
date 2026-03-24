Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D92F693B
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381795; cv=none; b=jcfOVEqzQNs7eRw/1GhAOkwFnw7jk1uIqFRt/D+ccydzkhnYYs5wPF62fXt8pwrra523ZTgPrZ/v31t0/0ZKIA12hKi3nH+4KYdiLooZYGHonfwLfC0qZj6btRPzXtgGQtYdnCKkMkfN9p2hxAsqvu2I1cyPWbpYBjoeb/eFPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381795; c=relaxed/simple;
	bh=XDFDA9fVRvZrngHiBR8tWQxx+NTXCe8OV4v6kJPsthY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sd8rvSkJ8aQq76s6NSjKCBkh9084ymN8iX+NI31j5+IwjJ50CKXD5NTqIkUp+YmvqnTLszmTUPsO/mWRZaxJA5m4+OZgZJgfQw0yI2/3szMgTtnmTijkHMae5q/oOLsMtxjYVhnF5wKft8Xlhb57DqlJfRMYpLUE8p+2Po7Llhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHdfVy0O; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHdfVy0O"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56a9076813bso2622713e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381793; x=1774986593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=geXhid+ObUxdODvoUvcKqgdoFUIwOaeaDzThI9FvmSQ=;
        b=HHdfVy0O4i2KucjZ8ZWDcjbDaAR1QMDCusKRes+llQLSgRypTbkOJ/3kfRfZkirk06
         O9JvqTE2R5pRnHbW/bcNpY2m1NryaJLvhdi21CV7WSj42QzB6Wnn7MBzkSojklq1DXAr
         pvca/dJ7ATEDDpdaKpGGiULJwfIMkll+n9gEyUb3m3RBpdp4xIU5j8Nkck4aXIP9B50c
         UIDNAJJw0skUR5XAG7ugRD/JYPF/bGpvDTQnzEDcqoe0X293HS9ezUT943QVjp4zsrh3
         +zo2bOcn5ZumcGu8Elv8J5laERXCXWB7jIMq2EmJPfpwJ5iLnn+rtP/mNCoChiu9bNGC
         TJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381793; x=1774986593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geXhid+ObUxdODvoUvcKqgdoFUIwOaeaDzThI9FvmSQ=;
        b=FEns/vgh/cUfbBkfI3/sDgMtvJsmLvagcfnl3u4/Z9ILyfvsfXJROuRj9W5sI1xIFy
         QBRrSHfW3LDLTv0/a7p2y7AqmimC7SgSaL25ZoJhr1tfsU/xhWG7Uu10nmbTY9Fazssn
         S5FWJsWiB6XGT1haOisk95d4fT0hOKuef4TW5SJTwVPjuOAijPRSWy4906ciXtRScIY2
         W6/VIDFDaCU4EKMrQrvdv3t9/M+9hO7yUpgjPSAr3peIxllpuL+QqpijhmqjB4g3Qx1b
         Usi1DkDchNnz1kAftSJI3AKED3WxM74/CEs9fLWSUUk1KtUBxeIHeGF/om76bfZN1c58
         pWTg==
X-Gm-Message-State: AOJu0Yz493nin3SVeYlrNWvu/arhwPzKdQ14eg02oOkgWqb0lsuYHDWm
	q3A6g8eWJkYFS4QiDASc5ka0IK/4dD2LdNoWxYSu6dWBQ6Tyf6tUlXXrQP3WmfQx
X-Gm-Gg: ATEYQzwctFRgRWSkZIAMNEl2tlnfTOe8jFWeY69MdaqamCfRDaLoFeigP7jFaaYyrWV
	54HSNbPVT4RlBSLOoYwdKOfiaadGcgncwaiksnONOjdmDjEQ2Urti6xNa3P5dloZHkU/hsaBXzK
	KSdG6FnWcCTxkI0PNETHbXJTQjKqEXXItPyU9p8PaHyNoYoyoPLKuF88Kvv7nFYlej19oCHTgRn
	wtI6A53mDDB6PbTsDebb9I0PRq/1O4tuIT2ggYq77qETWuhw69SD0WiMyac5VzHPyOQMOAeuxcv
	c3DTBgQSbzXv+Zmdu7uE7R2lMZS5ZoDi3HU9DtqWNzXJqQu/AUTefGMusZCmMTYjoTnlQsz15dJ
	+NoiEvdb1qzc4IPqtXsc72UYJicfRTT0RtLjy5WBNMeXEPciTV78DQPJTrAJoig5mAE7+K4Frxh
	BwdFE7ET7DzEWqa2fENMKgrNUgu+TcxJgm4xvwawNusnotOrYbBK4epfZQi1VthJCRJeapfPGDc
	iX4GVfbZJyWfi7GiA==
X-Received: by 2002:a05:6102:9d8:b0:5ff:d1c8:a85e with SMTP id ada2fe7eead31-6038753a6c0mr625223137.32.1774381792558;
        Tue, 24 Mar 2026 12:49:52 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de3e33sm13759671241.9.2026.03.24.12.49.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:49:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/9] doc/btmon: Split Advertising and Scanning into btmon-advertising.rst
Date: Tue, 24 Mar 2026 15:49:37 -0400
Message-ID: <20260324194946.109349-1-luiz.dentz@gmail.com>
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
 doc/btmon-advertising.rst | 155 ++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst             | 155 +-------------------------------------
 2 files changed, 158 insertions(+), 152 deletions(-)
 create mode 100644 doc/btmon-advertising.rst

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

