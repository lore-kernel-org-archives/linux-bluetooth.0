Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089B34FF6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335754; cv=none; b=FpNeIWFmyEMbb+JXvtJpjVywDmJoid15cqTXLdSFYZPOhg7mrAM6fOK/398AzylVEseAcyG07MEhOwdTukYClqZdEQk15r0qgk4fGvkbMh5zK0TRkePqmO5/1Hkry9wxMv1CoiWY0PZerKYmO1pGI8QtiBMgwx6DkZCkbvH7o6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335754; c=relaxed/simple;
	bh=QWk5yD7dstoAwyGFzMiBYq3R6tqwIa+QwTadgu4HR0o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R/EK1IlCEtcu699FQS7SqhCoXK5+v3X5dBqFd4jxwFocADKL9UIuEV145+admupHzMgjMWMwnK05wsiAjJRDsUcZvFGAVe3RMWev/IqepmUNPHboElqyDEdtGVz0/RdFH3msqhiGG/jvro6YBM6VxBfjExj8EvtDf4bDJSkjMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3xcytpL; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3xcytpL"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c31ca77b4so1373206d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335750; x=1773940550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SReTW9ciyuf0siT6AZnp2d/b2vYkC0iUBinAEf6BSS4=;
        b=Q3xcytpLSgM4/EerKmFCEb1OpqvAaXnLCNrrJBk8iPzq6kzvjmC9PAPKDoRDVYDGyU
         PSLaEyl/boUXvwiLn+QFFbQASl7JZT4t6BKj+PtKH6PCVmTjAHUbFhVjCiEYHQtlvLKa
         TsHZjrfbRjEi7aGlT/5DFn/jlPrsQHOVHm4EZagA0qiS8oQv7HoGpnpoTCNr3Tdm7UYC
         ZeYEuduOpp61mp31E0wkPkov9Cop9Nr/nGMj8jXYQFfTpuBGz9pKBgljVT+PvRjlxCRG
         1cImcctsTC3GBD8NO8Hnxt/+LQsfyD3K+m6G26zSy2H1n5VXt4Qj/UHXfSdppoOpXWCy
         GDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335750; x=1773940550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SReTW9ciyuf0siT6AZnp2d/b2vYkC0iUBinAEf6BSS4=;
        b=coBjZUWO+/egdjg0TxNnzQI0J66zqc0FjM770TVNRqWqMMGuy5DfioyisgSiBSaTl2
         YDGShaZP2Y+Q8AEJktY+dFSlHbyAiXLjZlsucirHcJI8ZacMg9kDKvCTJM730M2ClvAp
         6N6X6dxawSIi0lf7z1EmLpBx0HcH/p9wYn3ttSzRWsIQcAAq6x3PyiBqAmTCTdvhK/Rx
         eUktDyr2HBDHinYlu8eYUo1nIS+ErINmg8GWSSdqy5/qERNRoj+MpfcMnDpomaoFNLYg
         EdKodL6rF9s7j0tS3qzo0LRK2E0jg1MQ+wG8TDaCoVYPwnnVIzT161KfM+JCv3h0RzEk
         lZ9Q==
X-Gm-Message-State: AOJu0YycLOq9SLzQSkJnhV84s4m15Gy7mZvm8hRiq5eitShSNOBc6iJ7
	zr/A2kwoGly4RsHGR1dZQNmy7Dz8NvGFt/cCHziQeMLQlgSr9WQV3+OUyBNyJQ==
X-Gm-Gg: ATEYQzwZiIE9piN8j1vPqLn4BEKHymV8Hwof7T81gZDF492hUid60obkWk/tAzUMe61
	dCgICkioKYOoL0ORiUsFDW5mUWRE71FA/a0BttP4TeCRFCEP6cPmeF7bvFW6li61OKZYdNi24uh
	rwL5jv8jrd7y90ZtmezTbR+0e3dlL9Zo7IJvvPjS4mw8SQ7rDROL6ZCyioXVx+Q6izMdBqgDjwN
	w8QxaYa6TQ+vGSejvm8DhKQckhJ7mJJyWiC+I/ygVIAOUd6pid9/z/MJI/6IKI/ZWUgIS+uzGwm
	fsQDewzIz4FcfTCnXXmcrS/GvqeaLa7naR0roLEa++EOx007tEKe/DJXoQU2r77FZB0pXRD7aFU
	LYZ/qdKrqGD1jbLHumt5pmG2mF3ouy4TexqidlyeVt3i609CvRhaOJ1+7M5ilx4qXGQ82S7q/Ol
	46NDx2JlgtJ11w0j6hRdpSwlhLKZABztnm2t2vZm/4t2TkG/+NEWm0HujH5m1o2URRonaG6xhMw
	dAK8bZYlc8A1faMpQ==
X-Received: by 2002:a53:a04d:0:b0:646:e648:cc7f with SMTP id 956f58d0204a3-64e62f32c10mr279196d50.10.1773335750359;
        Thu, 12 Mar 2026 10:15:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d65117a82sm3442572d50.15.2026.03.12.10.15.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:15:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/6] doc/btmon: Split Advertising and Scanning into btmon-advertising.rst
Date: Thu, 12 Mar 2026 13:15:34 -0400
Message-ID: <20260312171540.1065212-1-luiz.dentz@gmail.com>
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
 doc/btmon-advertising.rst | 159 ++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst             | 154 +-----------------------------------
 2 files changed, 160 insertions(+), 153 deletions(-)
 create mode 100644 doc/btmon-advertising.rst

diff --git a/doc/btmon-advertising.rst b/doc/btmon-advertising.rst
new file mode 100644
index 000000000000..46350f002b5f
--- /dev/null
+++ b/doc/btmon-advertising.rst
@@ -0,0 +1,159 @@
+===================================
+btmon: Advertising and Scanning
+===================================
+
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
index 2299c13ca16c..974e8e1ef002 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -2402,159 +2402,7 @@ Errors often cascade across layers. Common patterns:
 4. L2CAP ``Connection refused - security block`` → triggers SMP
    pairing
 
-ADVERTISING AND SCANNING
-==========================
-
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

