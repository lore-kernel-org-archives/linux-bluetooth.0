Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61628C035
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066877; cv=none; b=osNpcm6cYmCejzdZPm7R6iUECfJ0qnW5bQ1hRgwPFhLjTaeZ2VRXtt2R9y2rs7XN5qvofegYm1Gb8OwDcCBKhFHraSY2Bsr3vNNoG8bRFItwajVw+7u9vYv88+ChGEk/hwAsInn960PASP2NCzse9DBNwXT2dVjgo3v3q5Ojf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066877; c=relaxed/simple;
	bh=5uP55MwugtLUswx1KDVHer6go8UYbyLlYg4HskTkmsc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j9l8eAsko2WqNFTbR43rCCu9wQYwoFreLP0TIkCzC00JCavfjqxJv54/mlv2ThJY0NnP/L0P3A8daMCkCyD9E6+FozeR0UHJtPCvVjJdST+78bY4rx809J+ZvUNssTIL/teRevfpBLmeWjhtGdB2ZxNIP6hJvTrqC3u5fT7ilm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2g6JNLA; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2g6JNLA"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fff18d44fbso4561708137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775066874; x=1775671674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2ZcKmGcTF+GygtQxlosBzivqhZyzU7cGSrbQW8B0vI=;
        b=l2g6JNLAPMF15+KAC0Ll8ceYcBZt1P/YkAXluUI4QKsgs7XFdMCK7ticjNzVx0Pi2T
         2c0zj8mLVoKuP//W6yb0c9ABZj7xvxnCL0SSkQqvWFCZjqmOkhjFOXTBE6NbMRC+3KMR
         IGICAe/WF8/q+B5wf/3uYNNhFGUu48Y4cny7UCdhmD9Dy/57Ai+Y/udPiiYhXtjOpr1f
         hik3HtTZdTLyJLsH/cLJh9h5RLpoOD2rrVclu7Sb7VUhfiOhT4Fdcn2N1b1mwSWtHyRj
         DIl/8AbDlguhl8F8F83X1pEZUSZfB2DWjFHWfI7y2tD61YMPNgt/qhGsrfLVhQfbex5j
         Z3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775066874; x=1775671674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2ZcKmGcTF+GygtQxlosBzivqhZyzU7cGSrbQW8B0vI=;
        b=LE/D+DKaJFumtGah81+1EBCDew9MjnY9kZ6mNsMqcAeytsXBrvu7XUEHm4I9Ksa0Tj
         dVBLUFDmxL05IjMqVyaxII2vgYKOPKg5FDaFWslTHh5NAUvB5UrOSDzrm4rt2m7yS//+
         h6rx+LyPwPsST4kXOoWlBKMB6lf5BqrAli5DDs+LOGBsJ2NW3Y9uo9GEreuxbiFa8+QL
         kWYA/Ys+rsyefkWPMyhFuqoBDQr3zHCOmHy8mMIrWulLj0g45zo73wO6z0LB4PqhRsoj
         6DxnzhXv9uUpvlf9rCCidXMn3hAAGljpvHIOz1I7c7AbySJoYsYqhRZTOLQvUIDhoCRB
         4s0g==
X-Gm-Message-State: AOJu0YwJX2gRb8BVmlGr9O/S32h8ejZzYkI0b/Dl/itdvv9/abbd4ipW
	puXe2xkwhh3JNuFh2YmPHus9971FIpjXi7/rrwYMJNNVYNSGvYsH91iT/H7jTRsQ3cU=
X-Gm-Gg: ATEYQzzBB4CwHDVJDyGkyp70nHdRCOLsjYCjkbslxwqSti1UCG0vbtaoa3UWOV7VGz0
	+g+6TQLm+bGVO7aTb/xw8iSM1sv8ukiV+lRrsT9bPN3zrsU3K9n/pJwGHOglcOhBYxLQWxkSqLp
	oQzYe+t/sehr5jX+i2aeYfcQasLIBfqAv7udiQaPZo/S3hh+Vke9X9CzDLHKbxkpeXq3PInSOk3
	lTzRRr2euhww2EKOPGAFisNjAJkLxecEowFYi9Y9c3AI6kWFdY8VWvYIzsn80aEXNHLNqtSyxrb
	a7wLfgV32t6ufqyuHb6mg2bxeCJU+NRhmnRseffxKNt74wN26sQJundzR7aVfJcR02NCOqN7/b7
	Xe+y30W/AAVxk8IzO6Gac87KWjCO36I48EKajGoKIwMQf1GwZPQYu2kFieOIUAyZ3pyycIbBP6P
	H71xmYZK7KKgPm/jXWLP9eXxOTuQ1+yxEmrKwQYzECqFnWXY0bDDx38ZJsEok3OEoH8cAeE6hh0
	CLX1GtmlG7crLKjkg==
X-Received: by 2002:a05:6102:14aa:b0:5ff:e39d:9f93 with SMTP id ada2fe7eead31-60583e15afbmr249725137.11.1775066873430;
        Wed, 01 Apr 2026 11:07:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605830999f2sm593187137.12.2026.04.01.11.07.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:07:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: add btmon-mgmt.rst
Date: Wed,  1 Apr 2026 14:07:46 -0400
Message-ID: <20260401180746.2074659-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add a new btmon sub-document doc/btmon-mgmt.rst describing Management
(MGMT) protocol flows as seen in btmon output; include it from
doc/btmon.rst and list it in EXTRA_DIST in Makefile.am.
---
 Makefile.am        |   2 +
 doc/btmon-mgmt.rst | 526 +++++++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst      |   2 +
 3 files changed, 530 insertions(+)
 create mode 100644 doc/btmon-mgmt.rst

diff --git a/Makefile.am b/Makefile.am
index 2cfb884f1851..8fdf8d7fe207 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -556,6 +556,8 @@ EXTRA_DIST += doc/btmon-classic-audio.rst doc/btmon-a2dp.rst
 
 EXTRA_DIST += doc/btmon-hfp.rst
 
+EXTRA_DIST += doc/btmon-mgmt.rst
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
diff --git a/doc/btmon-mgmt.rst b/doc/btmon-mgmt.rst
new file mode 100644
index 000000000000..3a3a9ae7c0cd
--- /dev/null
+++ b/doc/btmon-mgmt.rst
@@ -0,0 +1,526 @@
+.. This file is included by btmon.rst.
+
+MGMT PROTOCOL FLOWS
+=====================
+
+The Management Interface (MGMT) is the structured command/event protocol
+between userspace (typically ``bluetoothd``) and the kernel Bluetooth
+subsystem. In btmon output, MGMT traffic is prefixed with ``@`` and
+provides insight into adapter configuration, device discovery, pairing,
+and connection management at a higher level than raw HCI. This section
+covers common MGMT protocol flows as seen through btmon.
+
+For MGMT output format basics (line anatomy, Open/Close, parameters,
+events), see the "Management Traffic" subsection in READING THE OUTPUT
+above.
+
+Initialization and Version Handshake
+--------------------------------------
+
+When ``bluetoothd`` starts, it opens a management socket and queries
+the kernel for protocol version and supported features. This handshake
+must succeed before any controller operations::
+
+    @ MGMT Open: bluetoothd (privileged) version 1.23      {0x0001} 12:34:49.881936
+    @ MGMT Command: Read Management Ver.. (0x0001) plen 0  {0x0001} 12:34:49.882003
+    @ MGMT Event: Command Complete (0x0001) plen 6         {0x0001} 12:34:49.882010
+          Read Management Version Information (0x0001) plen 3
+            Status: Success (0x00)
+            Version: 1.23
+    @ MGMT Command: Read Management Sup.. (0x0002) plen 0  {0x0001} 12:34:49.882050
+    @ MGMT Event: Command Complete (0x0001) plen 58        {0x0001} 12:34:49.882055
+          Read Supported Commands (0x0002) plen 55
+            Status: Success (0x00)
+            Num of commands: 120
+            Num of events: 38
+
+After the version check, ``bluetoothd`` reads the controller list and
+queries each controller's information::
+
+    @ MGMT Command: Read Controller Index List (0x0003) plen 0  {0x0001} 12:34:49.882100
+    @ MGMT Event: Command Complete (0x0001) plen 7              {0x0001} 12:34:49.882105
+          Read Controller Index List (0x0003) plen 4
+            Status: Success (0x00)
+            Num controllers: 1
+            Controller: hci0
+
+    @ MGMT Command: Read Controller Inf.. (0x0004) plen 0  {0x0001} [hci0] 12:34:49.882200
+    @ MGMT Event: Command Complete (0x0001) plen 283       {0x0001} [hci0] 12:34:49.882210
+          Read Controller Information (0x0004) plen 280
+            Status: Success (0x00)
+            Address: 00:11:22:33:44:55
+            Bluetooth version: 5.4
+            Manufacturer: Intel (2)
+            Supported settings: 0x003effff
+            Current settings: 0x00000080
+
+Key things to check in the initialization flow:
+
+- **MGMT Open** -- Confirms ``bluetoothd`` connected. If missing, the
+  daemon did not start or crashed before reaching MGMT setup.
+- **Version mismatch** -- If ``bluetoothd`` expects a newer MGMT version
+  than the kernel provides, some features may be unavailable.
+- **Num controllers: 0** -- No Bluetooth hardware detected. Check
+  ``dmesg`` for driver issues.
+- **Current settings** -- The bitmask shows what is currently enabled on
+  the controller (Powered, LE, BR/EDR, SSP, etc.).
+
+Adapter Configuration
+----------------------
+
+After reading controller info, ``bluetoothd`` configures the adapter
+with a series of MGMT commands before powering it on. The exact
+sequence depends on ``main.conf`` settings and adapter capabilities.
+
+**Loading stored keys**::
+
+    @ MGMT Command: Load Link Keys (0x0012) plen 3  {0x0001} [hci0] 12:34:50.001200
+          Debug keys: Disabled (0x00)
+          Key count: 0
+    @ MGMT Event: Command Complete (0x0001) plen 4   {0x0001} [hci0] 12:34:50.001220
+          Load Link Keys (0x0012) plen 1
+            Status: Success (0x00)
+
+    @ MGMT Command: Load Long Term Keys (0x0013) plen 2  {0x0001} [hci0] 12:34:50.001300
+          Key count: 0
+    @ MGMT Event: Command Complete (0x0001) plen 4        {0x0001} [hci0] 12:34:50.001315
+          Load Long Term Keys (0x0013) plen 1
+            Status: Success (0x00)
+
+    @ MGMT Command: Load Identity Resolving Keys (0x0030) plen 2  {0x0001} [hci0] 12:34:50.001400
+          Key count: 0
+    @ MGMT Event: Command Complete (0x0001) plen 4                {0x0001} [hci0] 12:34:50.001415
+          Load Identity Resolving Keys (0x0030) plen 1
+            Status: Success (0x00)
+
+When bonded devices exist, the Key count will be non-zero and btmon
+will list each key entry. A large number of keys can indicate many
+paired devices; this is normal.
+
+**Setting adapter properties**::
+
+    @ MGMT Command: Set Secure Connections (0x002d) plen 1  {0x0001} [hci0] 12:34:50.002100
+          Secure connections: Enabled (0x01)
+    @ MGMT Event: Command Complete (0x0001) plen 7          {0x0001} [hci0] 12:34:50.002120
+          Set Secure Connections (0x002d) plen 4
+            Status: Success (0x00)
+            Current settings: 0x004e0a81
+
+    @ MGMT Command: Set Bondable (0x0009) plen 1            {0x0001} [hci0] 12:34:50.002200
+          Bondable: Enabled (0x01)
+    @ MGMT Event: Command Complete (0x0001) plen 7          {0x0001} [hci0] 12:34:50.002220
+          Set Bondable (0x0009) plen 4
+            Status: Success (0x00)
+            Current settings: 0x004e0a91
+
+**Powering on**::
+
+    @ MGMT Command: Set Powered (0x0005) plen 1     {0x0001} [hci0] 12:35:04.033564
+          Powered: Enabled (0x01)
+    @ MGMT Event: Command Complete (0x0001) plen 7   {0x0001} [hci0] 12:35:04.114789
+          Set Powered (0x0005) plen 4
+            Status: Success (0x00)
+            Current settings: 0x004e0ac1
+
+Between the ``Set Powered`` command and its response, btmon will show
+the HCI commands the kernel sends to initialize the radio (see
+`HCI INITIALIZATION SEQUENCE`_).
+
+Discovery
+----------
+
+Device discovery is initiated through MGMT rather than raw HCI commands.
+``bluetoothd`` (or ``btmgmt``) sends a Start Discovery command
+specifying which transport types to scan.
+
+**Starting discovery**::
+
+    @ MGMT Command: Start Discovery (0x0023) plen 1  {0x0001} [hci0] 12:36:00.100200
+          Address type: 0x07
+            BR/EDR
+            LE Public
+            LE Random
+    @ MGMT Event: Command Complete (0x0001) plen 5   {0x0001} [hci0] 12:36:00.100500
+          Start Discovery (0x0023) plen 2
+            Status: Success (0x00)
+            Address type: 0x07
+
+After this, btmon shows the HCI-level scan commands the kernel issues
+(``LE Set Scan Parameters``, ``LE Set Scan Enable``, and/or
+``Inquiry`` for BR/EDR). Discovered devices appear as MGMT events::
+
+    @ MGMT Event: Device Found (0x0012) plen 38      {0x0001} [hci0] 12:36:00.250003
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          RSSI: -62
+          Flags: 0x0000
+          EIR Data:
+            Name (complete): My Device
+            TX power: 0
+
+**Service discovery** uses a filtered variant::
+
+    @ MGMT Command: Start Service Discovery (0x003a) plen 19  {0x0001} [hci0] 12:36:10.100200
+          Address type: 0x06
+            LE Public
+            LE Random
+          RSSI threshold: -127
+          UUIDs: 1
+            UUID: Heart Rate (0x180d)
+    @ MGMT Event: Command Complete (0x0001) plen 5            {0x0001} [hci0] 12:36:10.100500
+          Start Service Discovery (0x003a) plen 2
+            Status: Success (0x00)
+
+**Stopping discovery**::
+
+    @ MGMT Command: Stop Discovery (0x0024) plen 1   {0x0001} [hci0] 12:36:15.200100
+          Address type: 0x07
+    @ MGMT Event: Command Complete (0x0001) plen 5    {0x0001} [hci0] 12:36:15.200400
+          Stop Discovery (0x0024) plen 2
+            Status: Success (0x00)
+
+    @ MGMT Event: Discovering (0x0013) plen 2         {0x0001} [hci0] 12:36:15.200500
+          Address type: 0x07
+          Discovery: Disabled (0x00)
+
+Discovery problems to look for:
+
+- **Status: Busy (0x0a)** on Start Discovery -- Another discovery
+  session is already active.
+- **Status: Not Powered (0x0f)** -- The adapter is not powered on.
+- **Status: RFKilled (0x12)** -- The radio is blocked by rfkill.
+- **No Device Found events** -- The remote device may not be
+  advertising, or address type filtering may be wrong.
+
+Pairing and Bonding via MGMT
+------------------------------
+
+MGMT provides a high-level pairing interface. The host sends a
+``Pair Device`` command; the kernel coordinates SMP or SSP as
+appropriate and reports the result.
+
+**Initiating pairing**::
+
+    @ MGMT Command: Pair Device (0x0019) plen 8      {0x0001} [hci0] 12:37:00.500200
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          Capability: KeyboardDisplay (0x04)
+
+After this command, btmon shows the underlying SMP or SSP exchange
+(see `SMP PAIRING FLOW`_ and `HCI INITIALIZATION SEQUENCE`_ for
+details). User interaction events may appear::
+
+    @ MGMT Event: User Confirmation Request (0x000f) plen 12  {0x0001} [hci0] 12:37:01.200100
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          Value: 123456
+
+    @ MGMT Command: User Confirmation Reply (0x001e) plen 6   {0x0001} [hci0] 12:37:03.800200
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+    @ MGMT Event: Command Complete (0x0001) plen 10            {0x0001} [hci0] 12:37:03.800350
+          User Confirmation Reply (0x001e) plen 7
+            Status: Success (0x00)
+
+Or for passkey entry::
+
+    @ MGMT Event: User Passkey Request (0x0010) plen 6        {0x0001} [hci0] 12:37:01.200100
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+
+    @ MGMT Command: User Passkey Reply (0x0020) plen 10       {0x0001} [hci0] 12:37:05.100200
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          Passkey: 123456
+
+**Pairing success**::
+
+    @ MGMT Event: New Long Term Key (0x000a) plen 37   {0x0001} [hci0] 12:37:06.100200
+          Store hint: Yes (0x01)
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          Key type: Authenticated P-256 (0x03)
+          Central: 0x00
+          Encryption size: 16
+
+    @ MGMT Event: New Identity Resolving Key (0x0018) plen 30  {0x0001} [hci0] 12:37:06.100300
+          Store hint: Yes (0x01)
+          Random address: AA:BB:CC:DD:EE:FF
+          LE Address: 11:22:33:44:55:66 (Public)
+          Key: 00112233445566778899aabbccddeeff
+
+    @ MGMT Event: Command Complete (0x0001) plen 10   {0x0001} [hci0] 12:37:06.100500
+          Pair Device (0x0019) plen 7
+            Status: Success (0x00)
+            LE Address: AA:BB:CC:DD:EE:FF (Random)
+
+Key events to check after pairing:
+
+- **New Long Term Key** with ``Store hint: Yes`` -- The kernel is
+  telling userspace to persist this key for future reconnections.
+- **New Identity Resolving Key** -- Reveals the device's real address
+  behind an RPA. This is essential for address resolution on reconnect.
+- **Key type** -- ``Authenticated P-256`` indicates Secure Connections
+  with MITM protection. ``Unauthenticated P-256`` means Just Works SC.
+  ``Authenticated`` (no P-256) means Legacy with MITM.
+
+**Pairing failure**::
+
+    @ MGMT Event: Command Complete (0x0001) plen 10   {0x0001} [hci0] 12:37:06.100500
+          Pair Device (0x0019) plen 7
+            Status: Authentication Failed (0x05)
+            LE Address: AA:BB:CC:DD:EE:FF (Random)
+
+MGMT pairing error codes:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 8 30 62
+
+   * - Code
+     - Status
+     - Diagnostic Meaning
+   * - 0x03
+     - Failed
+     - Generic failure; check SMP or HCI errors preceding this
+   * - 0x04
+     - Connect Failed
+     - Could not establish connection before pairing
+   * - 0x05
+     - Authentication Failed
+     - SMP or SSP authentication did not succeed; check SMP Pairing
+       Failed reason or HCI Authentication Failure event
+   * - 0x08
+     - Timeout
+     - Pairing timed out; remote device may have gone out of range
+   * - 0x0b
+     - Rejected
+     - Remote device rejected the pairing request
+   * - 0x0d
+     - Invalid Parameters
+     - Bad address type or capability value in the Pair Device command
+
+Device Connection and Disconnection
+--------------------------------------
+
+MGMT reports connection lifecycle events that complement the HCI-level
+events shown elsewhere in the trace.
+
+**Device connected**::
+
+    @ MGMT Event: Device Connected (0x000b) plen 13   {0x0001} [hci0] 12:36:18.974319
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          Flags: 0x0000
+          EIR Data Length: 0
+
+This event follows the HCI ``LE (Enhanced) Connection Complete`` event.
+It tells userspace that a new connection is ready.
+
+**Device disconnected**::
+
+    @ MGMT Event: Device Disconnected (0x000c) plen 8  {0x0001} [hci0] 12:38:20.500200
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          Reason: Connection timeout (0x01)
+
+Disconnect reasons reported by MGMT:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 8 30 62
+
+   * - Code
+     - Reason
+     - Diagnostic Meaning
+   * - 0x00
+     - Unspecified
+     - No reason provided; typically a local disconnect
+   * - 0x01
+     - Connection timeout
+     - Link supervision timeout expired; device may be out of range
+   * - 0x02
+     - Connection terminated by local host
+     - Local side initiated the disconnection
+   * - 0x03
+     - Connection terminated by remote host
+     - Remote device initiated the disconnection
+
+**Unpair Device** removes stored keys and optionally disconnects::
+
+    @ MGMT Command: Unpair Device (0x001a) plen 7     {0x0001} [hci0] 12:39:00.100200
+          LE Address: AA:BB:CC:DD:EE:FF (Random)
+          Disconnect: Enabled (0x01)
+    @ MGMT Event: Command Complete (0x0001) plen 10    {0x0001} [hci0] 12:39:00.100500
+          Unpair Device (0x001a) plen 7
+            Status: Success (0x00)
+
+Advertising via MGMT
+---------------------
+
+Modern BlueZ configures advertising through MGMT commands rather than
+sending HCI LE advertising commands directly. This provides a
+multi-client advertising infrastructure.
+
+**Adding an advertisement**::
+
+    @ MGMT Command: Add Advertising (0x003e) plen 22   {0x0001} [hci0] 12:40:00.100200
+          Instance: 1
+          Flags: 0x0006
+            The connectable flag will be managed
+            The limited discoverable flag will be managed
+          Duration: 0
+          Timeout: 0
+          Advertising data length: 6
+          Scan response length: 0
+    @ MGMT Event: Command Complete (0x0001) plen 5      {0x0001} [hci0] 12:40:00.100500
+          Add Advertising (0x003e) plen 2
+            Status: Success (0x00)
+            Instance: 1
+
+**Removing an advertisement**::
+
+    @ MGMT Command: Remove Advertising (0x003f) plen 1  {0x0001} [hci0] 12:41:00.100200
+          Instance: 1
+    @ MGMT Event: Command Complete (0x0001) plen 5       {0x0001} [hci0] 12:41:00.100500
+          Remove Advertising (0x003f) plen 2
+            Status: Success (0x00)
+            Instance: 1
+
+For the HCI-level advertising commands that result from these MGMT
+operations, see `ADVERTISING AND SCANNING`_.
+
+Error Diagnosis
+----------------
+
+MGMT Command Status and Command Complete events carry error codes that
+are distinct from HCI error codes. When diagnosing failures, check
+both layers.
+
+**MGMT error in Command Complete**::
+
+    @ MGMT Event: Command Complete (0x0001) plen 4    {0x0001} [hci0] 12:42:00.100200
+          Set Powered (0x0005) plen 1
+            Status: RFKilled (0x12)
+
+**MGMT Command Status** (asynchronous command accepted or rejected)::
+
+    @ MGMT Event: Command Status (0x0002) plen 3     {0x0001} [hci0] 12:42:01.100200
+          Start Discovery (0x0023) plen 0
+            Status: Busy (0x0a)
+
+MGMT error codes:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 8 30 62
+
+   * - Code
+     - Status
+     - Diagnostic Meaning
+   * - 0x00
+     - Success
+     - Command completed successfully
+   * - 0x01
+     - Unknown Command
+     - Kernel does not recognize the command; MGMT version may be
+       too old
+   * - 0x02
+     - Not Connected
+     - Operation requires an active connection that does not exist
+   * - 0x03
+     - Failed
+     - Generic failure; check HCI events for root cause
+   * - 0x04
+     - Connect Failed
+     - Connection attempt failed at HCI level
+   * - 0x05
+     - Authentication Failed
+     - Pairing or authentication procedure failed
+   * - 0x06
+     - Not Paired
+     - Operation requires an existing bond; device not paired
+   * - 0x07
+     - No Resources
+     - Kernel ran out of resources (memory, handles, etc.)
+   * - 0x08
+     - Timeout
+     - Operation timed out
+   * - 0x09
+     - Already Connected
+     - Connection already exists to target device
+   * - 0x0a
+     - Busy
+     - Another operation is in progress (e.g., discovery running)
+   * - 0x0b
+     - Rejected
+     - Operation rejected by remote device or policy
+   * - 0x0c
+     - Not Supported
+     - Feature not supported by this controller or kernel version
+   * - 0x0d
+     - Invalid Parameters
+     - Bad parameters in the command
+   * - 0x0e
+     - Disconnected
+     - Connection was lost during the operation
+   * - 0x0f
+     - Not Powered
+     - Controller is not powered on; call Set Powered first
+   * - 0x10
+     - Cancelled
+     - Operation was cancelled by the user or another command
+   * - 0x11
+     - Invalid Index
+     - Controller index does not exist
+   * - 0x12
+     - RFKilled
+     - Radio is disabled by rfkill; unblock with ``rfkill unblock bluetooth``
+   * - 0x13
+     - Already Paired
+     - Device is already paired; unpair first if re-pairing is needed
+   * - 0x14
+     - Permission Denied
+     - Process lacks required privileges (CAP_NET_ADMIN)
+
+**Correlating MGMT and HCI errors**: When MGMT reports ``Failed``
+(0x03) or ``Authentication Failed`` (0x05), look at the HCI events
+immediately preceding the MGMT response. The HCI-level error
+(e.g., ``Authentication Failure (0x05)``, ``Connection Timeout
+(0x08)``) provides the specific hardware-level cause.
+
+Automating MGMT Analysis
+--------------------------
+
+**List all MGMT commands and events**::
+
+    grep -n "@ MGMT" output.txt
+
+**Find MGMT errors (non-zero status)**::
+
+    grep -n "@ MGMT" output.txt | grep -v "Status: Success"
+
+**Track adapter power state changes**::
+
+    grep -n "Set Powered\|RFKilled\|Not Powered" output.txt
+
+**Find all discovery activity**::
+
+    grep -n "Start Discovery\|Stop Discovery\|Device Found\|Discovering" output.txt
+
+**Find pairing activity via MGMT**::
+
+    grep -n "Pair Device\|User Confirmation\|User Passkey\|New Long Term Key\|New Identity Resolving Key\|Authentication Failed" output.txt
+
+**Find connection lifecycle events**::
+
+    grep -n "Device Connected\|Device Disconnected\|Unpair Device" output.txt
+
+**Identify which MGMT clients are active**::
+
+    grep -n "@ MGMT Open\|@ MGMT Close" output.txt
+
+**Full MGMT diagnosis pattern**:
+
+1. Find ``MGMT Open`` -- confirm ``bluetoothd`` connected and note
+   socket ID
+2. Check ``Read Controller Information`` -- verify address, version,
+   and current settings
+3. Find ``Set Powered`` -- confirm the adapter was powered on
+   successfully
+4. Search for non-Success status codes -- these indicate failures
+5. For pairing issues, find ``Pair Device`` and trace forward to its
+   ``Command Complete`` response
+6. For connection issues, find ``Device Connected``/``Device
+   Disconnected`` and check the disconnect reason
diff --git a/doc/btmon.rst b/doc/btmon.rst
index 8a02edce8e6a..cd08ed3d5424 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -771,6 +771,8 @@ PROTOCOL FLOWS
 
 .. include:: btmon-advertising.rst
 
+.. include:: btmon-mgmt.rst
+
 EXAMPLES
 ========
 
-- 
2.53.0

