Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF02DC765
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464869; cv=none; b=G8ji6URgwfrUk5Uluoj7vf0QE2G69fG2cK6d18dt1UKUOxj0vAjpDGV0msTGOIdveIYu8GIFKdGlhBIq39KWSv7T/0BRqXYJ+FWh7V/M8KnN5TDekG9lIEiX1OwR83u0aLlkejWhHSBg5bc0RPXH7U1EAM2oErzrNnLiNpkEWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464869; c=relaxed/simple;
	bh=B05Q5Y8ebRVKixFggMVLM95QTL68cH7bS8ktIyja60E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbrfdnqROpqPaxT/1soKYzxx1pQrzeID+sPvQG7rLISxHkvKciTtb1yAuvfzs6A5ORy/z5x5XvCpnSo7AStlh/PxC4++30t23I2yG4MPWQNdsVwb0r7xH6hFDguwD1iDsn4O8TAaqLOJiiqB//htvYY/cS3ZGzzyE6w57MWyxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gumKOOeJ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gumKOOeJ"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56cc67e01deso220702e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464866; x=1775069666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fXurI/JQepyfJv/UBhbLGv3tp/jWZHdRKYVT5X3XoE=;
        b=gumKOOeJUDG8MJ9xYBqplQLcGiRyTpLac4cF6KE4VP2h76JLt6PJH5wFQS0ATFH6t2
         yLjWUlp5ibn9WABNegjIHAjwygu+GYIUWjJKxVNtQ9FexOrNHJdVapE1ZLwBhg/3RyJy
         N0a2bSx2JrBzqsmp+EmUexwl7T+pyESGDeJfbzWjMfWYvy5Tlj/FDoE5YofJZ4lYSBNs
         JDPpLGVeaP4HrGqDvOuTJQS0xjvALUKZ/ZL2I6qHK3kyZMwp71UoMsSSOUdMsXyQeWkz
         lsaVD8zPX71/Kqmj7ldZCMdNNlMeZvUE2/RGz2X8/nBWUh3ZBu0IQTwa3p9VUFZCi9+F
         IVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464866; x=1775069666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6fXurI/JQepyfJv/UBhbLGv3tp/jWZHdRKYVT5X3XoE=;
        b=WdXMb6zyXcXxVidwJxIZmrax8DogIJmn3lQ3s7OZ7LtF6sevX6K+X4uIo8cTu+zE6K
         kVQEuScpxahG9JdlzC6D5GUZopzYsBF+sTr9d+QtVYeZyEa9Dvdv+JuHXGB6yWggvrJP
         qZTZuCSoaC58HSzvfRRvTJPk0nWSf1fqJKT14YZAhiHgKVO79trYbRI0D9BcVUt4KchW
         x2brC8b9o9pIENYfa1K8GHMGw6nb2WNd93z069xYYFEW6QzsdYwDbrT4iMIkEcADnAds
         YcC9hw9Q5N94QTd0I7Do3Y2sRvVnJYWu51xlRfEdRjK/4jw633fZu23qwTNWQHJ+Po37
         afJg==
X-Gm-Message-State: AOJu0YyP1vSJViNlXoutJQb5cFjEB+idR8yPlFzrMQFQlWphR5cXcIXO
	YhCiGByQNCUI3e7AGDJYNtPbrVbmdMtCKCJazDFiaEBmnPQ9g/eik+v0wAikCjWS
X-Gm-Gg: ATEYQzx/ejY8bA6LlHjQAxxE/FGMn1x8/0MekHIbwr+fx3gsxMxrqP16XdNXHCdCrX+
	ZMvtO8RbCL6ojn5cL/2nzS5+HjOtnjKAM3RPYNPGkLQcvpQPjP91pBAKVLOL8Dg5AWZJyGEzB51
	ZZPwQQF3tgIiZwod75zgb9YENSeDYJmEMmN/15N2auEa1yj/BVEpwlZcAKWyheO2WB1mWpcpy4d
	9NV/PcLsLrOgqdLA8nANPJSfzwf+chypktV9JBvL6PqjC9LzUWdxqkf15mm7kVNEXF5kGxEt0GC
	B5JnnAmGnY1dCSQP1fRUFkC/uKTn1oL9lhM9DUYdNdZcBf4NXb3NHkZUwEMqs7kOVifVLJ1R3Nr
	BxUouRnMlaLt8cojMg7zrBQrwCUG0KVvMoYOIgVo7H4wvFfuTHyTRQYiwJeFitm92szQTt/ldir
	AcKsNzNVdMsSnKFWrjQGqf464M2C57Fv7DmH4DR7ndJEKS6k8crT15yNiH1Q9toLG++quvKD5aj
	WCd6j9bJf7Tc5Dxbg==
X-Received: by 2002:a05:6122:340e:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-56d21f67619mr2796621e0c.8.1774464865672;
        Wed, 25 Mar 2026 11:54:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d71947sm921438e0c.14.2026.03.25.11.54.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:54:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 8/9] doc/btmon: Add A2DP/AVDTP protocol flow documentation
Date: Wed, 25 Mar 2026 14:54:04 -0400
Message-ID: <20260325185406.568078-8-luiz.dentz@gmail.com>
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

Add btmon-a2dp.rst documenting the A2DP protocol flow as seen in btmon
output, wrapped by btmon-classic-audio.rst parent file. Coverage
includes:

 - AVDTP signaling: Discover, Get Capabilities, Set Configuration,
   Open, Start, Suspend, Close
 - Codec capability/configuration decoding for SBC, AAC, aptX, aptX HD,
   aptX Low Latency, FastStream, LDAC, and Opus
 - AVDTP media transport channel setup
 - AVRCP control and browsing channel overview
 - Delay Reporting
 - Automation-friendly grep patterns
---
 Makefile.am                 |   2 +
 doc/btmon-a2dp.rst          | 418 ++++++++++++++++++++++++++++++++++++
 doc/btmon-classic-audio.rst |  12 ++
 doc/btmon.rst               |   2 +
 4 files changed, 434 insertions(+)
 create mode 100644 doc/btmon-a2dp.rst
 create mode 100644 doc/btmon-classic-audio.rst

diff --git a/Makefile.am b/Makefile.am
index e67a1f5c81e9..7bbb968f66f7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -552,6 +552,8 @@ EXTRA_DIST += doc/btmon-connections.rst
 
 EXTRA_DIST += doc/btmon-hci-init.rst
 
+EXTRA_DIST += doc/btmon-classic-audio.rst doc/btmon-a2dp.rst
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
diff --git a/doc/btmon-a2dp.rst b/doc/btmon-a2dp.rst
new file mode 100644
index 000000000000..516410e4e283
--- /dev/null
+++ b/doc/btmon-a2dp.rst
@@ -0,0 +1,418 @@
+.. This file is included by btmon-classic-audio.rst.
+
+A2DP: Advanced Audio Distribution
+-----------------------------------
+
+A2DP uses AVDTP (Audio/Video Distribution Transport Protocol) over
+L2CAP to negotiate codec parameters and stream high-quality audio.
+btmon fully decodes AVDTP signaling, codec capabilities, and AVRCP
+remote control messages.
+
+AVDTP Signaling Channel
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+A2DP begins with an L2CAP connection on PSM 25 (0x0019). The first
+L2CAP connection on this PSM carries AVDTP signaling; a second
+connection on the same PSM carries media transport data::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 12
+          L2CAP: Connection Request (0x02) ident 1 len 4
+            PSM: 25 (0x0019)
+            Source CID: 64
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 16
+          L2CAP: Connection Response (0x03) ident 1 len 8
+            Destination CID: 64
+            Source CID: 64
+            Result: Connection successful (0x0000)
+            Status: No further information available (0x0000)
+
+After L2CAP configuration completes, AVDTP signaling begins on this
+channel.
+
+Stream Endpoint Discovery
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The initiator discovers available Stream Endpoints (SEPs) on the
+remote device::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 6
+          Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 10
+          Channel: 64 len 6 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
+              ACP SEID: 1
+                Media Type: Audio (0x00)
+                SEP Type: SNK (0x01)
+                In use: No
+
+Each SEP has a SEID (Stream Endpoint Identifier), media type, and
+role (Source or Sink). ``In use: Yes`` means the endpoint is already
+streaming.
+
+Codec Capability Discovery
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+After discovering SEIDs, the initiator queries each endpoint's
+capabilities::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 7
+          Channel: 64 len 3 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Get All Capabilities (0x0c) Command (0x00) type 0x00 label 1 nosp 0
+              ACP SEID: 1
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 30
+          Channel: 64 len 26 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 1 nosp 0
+              Service Category: Media Transport (0x01)
+              Service Category: Media Codec (0x07)
+                Media Type: Audio (0x00)
+                Media Codec: SBC (0x00)
+                  Frequency: 0xf0
+                    16000
+                    32000
+                    44100
+                    48000
+                  Channel Mode: 0x0f
+                    Mono
+                    Dual Channel
+                    Stereo
+                    Joint Stereo
+                  Block Length: 0xf0
+                    4
+                    8
+                    12
+                    16
+                  Subbands: 0x0c
+                    4
+                    8
+                  Allocation Method: 0x03
+                    SNR
+                    Loudness
+                  Minimum Bitpool: 2
+                  Maximum Bitpool: 53
+              Service Category: Content Protection (0x04)
+                Content Protection Type: SCMS-T (0x0002)
+              Service Category: Delay Reporting (0x08)
+
+Capability responses list all supported values as bitmasks. Key
+service categories:
+
+- **Media Transport** (0x01) -- Always present, indicates the endpoint
+  supports a media transport channel
+- **Media Codec** (0x07) -- Codec type and supported parameters
+- **Content Protection** (0x04) -- Copy protection (SCMS-T or DTCP)
+- **Delay Reporting** (0x08) -- Endpoint supports delay reporting
+
+Supported Codecs
+~~~~~~~~~~~~~~~~~
+
+btmon decodes several A2DP codecs. Each has a different parameter
+format.
+
+**SBC** (mandatory A2DP codec)::
+
+    Media Codec: SBC (0x00)
+      Frequency: 44100 (0x20)
+      Channel Mode: Joint Stereo (0x01)
+      Block Length: 16 (0x10)
+      Subbands: 8 (0x04)
+      Allocation Method: Loudness (0x01)
+      Minimum Bitpool: 2
+      Maximum Bitpool: 53
+
+**AAC** (MPEG-2,4)::
+
+    Media Codec: MPEG-2,4 AAC (0x02)
+      Object Type: MPEG-4 AAC LC (0x40)
+      Frequency: 44100 (0x0100)
+      Channels: 2 (0x04)
+      Bitrate: 256000bps
+      VBR: No
+
+**aptX** (Qualcomm, vendor-specific)::
+
+    Media Codec: Non-A2DP (0xff)
+      Vendor ID: Qualcomm Technologies International, Ltd. (APT) (0x0000004f)
+      Vendor Specific Codec ID: aptX (0x0001)
+        Frequency: 44100 (0x20)
+        Channel Mode: Stereo (0x02)
+
+**aptX HD** (Qualcomm, vendor-specific)::
+
+    Media Codec: Non-A2DP (0xff)
+      Vendor ID: Qualcomm Technologies, Inc. (0x000000d7)
+      Vendor Specific Codec ID: aptX HD (0x0024)
+        Frequency: 44100 (0x20)
+        Channel Mode: Stereo (0x02)
+
+**LDAC** (Sony, vendor-specific)::
+
+    Media Codec: Non-A2DP (0xff)
+      Vendor ID: Sony Corporation (0x0000012d)
+      Vendor Specific Codec ID: LDAC (0x00aa)
+
+Vendor codecs appear as ``Non-A2DP (0xff)`` with decoded Vendor ID
+and Codec ID. Capability responses list all supported values as
+bitmasks; configuration responses show the single selected value.
+
+Stream Configuration
+~~~~~~~~~~~~~~~~~~~~~
+
+After selecting a codec and parameters, the initiator sends Set
+Configuration::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 20
+          Channel: 64 len 16 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 2 nosp 0
+              ACP SEID: 1
+              INT SEID: 1
+              Service Category: Media Transport (0x01)
+              Service Category: Media Codec (0x07)
+                Media Type: Audio (0x00)
+                Media Codec: SBC (0x00)
+                  Frequency: 44100 (0x20)
+                  Channel Mode: Joint Stereo (0x01)
+                  Block Length: 16 (0x10)
+                  Subbands: 8 (0x04)
+                  Allocation Method: Loudness (0x01)
+                  Minimum Bitpool: 2
+                  Maximum Bitpool: 53
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 6
+          Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 2 nosp 0
+
+Configuration responses show single selected values instead of
+bitmask lists. ``ACP SEID`` is the remote endpoint, ``INT SEID`` is
+the local endpoint.
+
+If configuration is rejected::
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 8
+          Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 2 nosp 0
+              Service Category: Media Codec (0x07)
+              Error code: Unsupported Configuration (0x29)
+
+Common AVDTP error codes:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 30 60
+
+   * - Code
+     - Name
+     - Meaning
+   * - 0x01
+     - Bad Header Format
+     - Malformed AVDTP header
+   * - 0x11
+     - Bad ACP SEID
+     - Unknown endpoint ID
+   * - 0x12
+     - SEP In Use
+     - Endpoint already streaming
+   * - 0x13
+     - SEP Not In Use
+     - Endpoint not configured
+   * - 0x29
+     - Unsupported Configuration
+     - Requested parameters not supported
+   * - 0x31
+     - Bad State
+     - Command not valid in current state
+
+Open and Start
+~~~~~~~~~~~~~~~
+
+After configuration, the stream is opened and then started::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 7
+          Channel: 64 len 3 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Open (0x06) Command (0x00) type 0x00 label 3 nosp 0
+              ACP SEID: 1
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 6
+          Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 3 nosp 0
+
+After Open succeeds, a **second L2CAP connection** on PSM 25 is
+established for the media transport channel. Then Start begins
+streaming::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 7
+          Channel: 64 len 3 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Start (0x07) Command (0x00) type 0x00 label 4 nosp 0
+              ACP SEID: 1
+
+    > ACL Data RX: Handle 1 flags 0x02 dlen 6
+          Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
+            AVDTP: Start (0x07) Response Accept (0x02) type 0x00 label 4 nosp 0
+
+Media Data
+~~~~~~~~~~~
+
+After Start, encoded audio flows on the media transport channel
+(second L2CAP connection on PSM 25). btmon does **not** decode media
+packet contents by default -- media data is suppressed. Only the
+L2CAP channel header is visible when the ``--show-a2dp-stream``
+filter is enabled, with the payload shown as a raw hex dump.
+
+The AVDTP state machine visible in the trace:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 20 30 50
+
+   * - State
+     - Triggered By
+     - Description
+   * - Idle
+     - Initial / Abort response
+     - No stream configured
+   * - Configured
+     - Set Configuration accept
+     - Codec and parameters selected
+   * - Open
+     - Open accept / Suspend accept
+     - Transport channel ready, not streaming
+   * - Streaming
+     - Start accept
+     - Audio data flowing
+   * - Closing
+     - Close command sent
+     - Tearing down stream
+   * - Aborting
+     - Abort command sent
+     - Forced teardown
+
+Suspend, Close, and Abort
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**Suspend** pauses streaming without tearing down the transport::
+
+    AVDTP: Suspend (0x09) Command (0x00) type 0x00 label 5 nosp 0
+      ACP SEID: 1
+    AVDTP: Suspend (0x09) Response Accept (0x02) type 0x00 label 5 nosp 0
+
+**Close** tears down the stream (returns to Idle)::
+
+    AVDTP: Close (0x08) Command (0x00) type 0x00 label 6 nosp 0
+      ACP SEID: 1
+    AVDTP: Close (0x08) Response Accept (0x02) type 0x00 label 6 nosp 0
+
+**Abort** forces immediate teardown::
+
+    AVDTP: Abort (0x0a) Command (0x00) type 0x00 label 7 nosp 0
+      ACP SEID: 1
+    AVDTP: Abort (0x0a) Response Accept (0x02) type 0x00 label 7 nosp 0
+
+Delay Reporting
+~~~~~~~~~~~~~~~~
+
+When the sink supports delay reporting, it sends a Delay Report to
+inform the source of its rendering delay::
+
+    AVDTP: Delay Report (0x0d) Command (0x00) type 0x00 label 8 nosp 0
+      ACP SEID: 1
+      Delay: 15.0ms
+    AVDTP: Delay Report (0x0d) Response Accept (0x02) type 0x00 label 8 nosp 0
+
+AVRCP Remote Control
+~~~~~~~~~~~~~~~~~~~~~
+
+AVRCP (Audio/Video Remote Control Profile) uses L2CAP PSM 23
+(control) and PSM 27 (browsing). btmon decodes AVCTP framing and
+AVRCP PDUs.
+
+**Volume control**::
+
+    < ACL Data TX: Handle 1 flags 0x00 dlen 17
+          Channel: 66 len 13 [PSM 23 mode Basic (0x00)] {chan 2}
+            AVCTP Control: Response: type 0x00 label 0 PID 0x110e
+              AV/C: Accepted: address 0x48 opcode 0x00
+                Subunit: Panel
+                Opcode: Vendor Dependent
+                Company ID: 0x001958
+                  AVRCP: SetAbsoluteVolume pt Single len 0x0001
+                    Volume: 50.39% (64/127)
+
+**Playback status**::
+
+    AVRCP: GetPlayStatus pt Single len 0x0009
+      SongLength: 0x00038270 (230000 milliseconds)
+      SongPosition: 0x00000000 (0 milliseconds)
+      PlayStatus: 0x01 (PLAYING)
+
+**Track metadata** (GetElementAttributes response)::
+
+    AVRCP: GetElementAttributes pt Single len 0x0050
+      AttributeCount: 0x02
+      Attribute: 0x00000001 (Title)
+      CharsetID: 0x006a (UTF-8)
+      AttributeValueLength: 0x000c
+      AttributeValue: My Song Name
+      Attribute: 0x00000002 (Artist)
+      CharsetID: 0x006a (UTF-8)
+      AttributeValueLength: 0x000b
+      AttributeValue: The Artist
+
+**Passthrough commands** (play, pause, skip)::
+
+    AVCTP Control: Command: type 0x00 label 1 PID 0x110e
+      AV/C: Control: address 0x48 opcode 0x7c
+        Subunit: Panel
+        Opcode: Passthrough
+        Operation: 0x44 (PLAY Pressed)
+        Length: 0x00
+
+**Event notifications** (volume change, track change)::
+
+    AVRCP: RegisterNotification pt Single len 0x0005
+      EventID: 0x0d (EVENT_VOLUME_CHANGED)
+      Volume: 50.39% (64/127)
+
+Automating A2DP Analysis
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**Identify A2DP activity**::
+
+    grep -n "AVDTP:\|Media Codec:" output.txt
+
+**Track AVDTP state transitions**::
+
+    grep -n "AVDTP:.*Command\|AVDTP:.*Response" output.txt
+
+**Check codec negotiation** (what was selected)::
+
+    grep -n "Set Configuration\|Media Codec:" output.txt
+
+**Verify stream is flowing** -- look for Start accept followed by
+media data::
+
+    grep -n "AVDTP: Start\|PSM 25.*chan 1" output.txt
+
+**Detect codec mismatch** -- look for Set Configuration reject::
+
+    grep -n "Response Reject\|Error code:" output.txt
+
+**Track AVRCP volume and playback**::
+
+    grep -n "SetAbsoluteVolume\|Volume:\|GetPlayStatus\|PlayStatus:" output.txt
+
+**Full A2DP diagnosis pattern**:
+
+1. Find L2CAP Connection Request for PSM 25 -- confirms AVDTP channel
+   setup
+2. Find Discover response -- shows available endpoints and whether any
+   are already in use
+3. Find Get All Capabilities response -- verify codec support overlap
+4. Find Set Configuration -- verify agreed codec and parameters
+5. Find Open and Start -- confirm stream setup succeeded
+6. Find second L2CAP connection on PSM 25 -- media transport channel
+7. On failure, check for Response Reject with error code
+8. If audio cuts out, look for Suspend or Close, or check for ACL
+   disconnection
diff --git a/doc/btmon-classic-audio.rst b/doc/btmon-classic-audio.rst
new file mode 100644
index 000000000000..11943c3a54bf
--- /dev/null
+++ b/doc/btmon-classic-audio.rst
@@ -0,0 +1,12 @@
+.. This file is included by btmon.rst.
+
+CLASSIC AUDIO PROTOCOL FLOW
+=============================
+
+Classic Bluetooth audio uses two main profiles: A2DP for high-quality
+stereo streaming and HFP for voice calls. Both run over BR/EDR ACL
+connections and use different transport mechanisms for audio data --
+A2DP uses L2CAP-based AVDTP media channels while HFP uses SCO/eSCO
+synchronous connections.
+
+.. include:: btmon-a2dp.rst
diff --git a/doc/btmon.rst b/doc/btmon.rst
index 6ecadf3f260d..8a02edce8e6a 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -767,6 +767,8 @@ PROTOCOL FLOWS
 
 .. include:: btmon-le-audio.rst
 
+.. include:: btmon-classic-audio.rst
+
 .. include:: btmon-advertising.rst
 
 EXAMPLES
-- 
2.53.0

