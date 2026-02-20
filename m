Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9435EDC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608699; cv=none; b=NXk1LPHm7l6xsKYHn8KFXYkKRiEv9n+jWlNYX0IHw7ZnEriZ9fb/EcAMD638iogsQO8Ag9hFITm1ihMWuwrhXm8XRZx9i6qohZAJaXFCfCh88QzXR7saQR/BYm5XMzL68u0qdZbiuc3HjxkUudcOrRluQZF1xxV/aE2znlrSIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608699; c=relaxed/simple;
	bh=rq8gA2Zi8hu3QVzF+EwZmlaUdQSIIt8EvCh3wXvGGmI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOMWv6Scez4owjGM54nWdpij62Z87S36iFyPqnvdFjF27r2REStnWMboDZGH0pTSec4wDKGIAeVM70c2HPnPPM/h2euGzjd5arIGQbUsUpYJ/fNcMWkn3/nSPoIkaqGq97gCY37uBakt9z8fAzwy2yPFec8bdlSMMaBwqWokweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhbqwTEv; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhbqwTEv"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5688b9e4e80so2148436e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608695; x=1772213495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOC0amBgOry/fS/cge6IzaEDhIf74Qzynj9rOeaTjlY=;
        b=UhbqwTEvAo4nRVp/l6NGxzyS7EA63Ic8QEPTABJM1r9Qjuwz48Y1L2z3/gxWj6nPjA
         od1OBT5RN03PDi68Rgkg0I3sE+8WFet6KtSFQncVG5XgoPUoFeYKMCOnLCu2Igry9EHS
         p9uja/7ciGuIH0qJai1wuzTXLrsBk+pE21VN9aZb58EwVnjwFnxzohuvqBjn8g7troaR
         OUJJobcqznW2M9Izu+9XeFve4mj2yJoSQY1cu+TqSlaomlWFenQeZjUR5SSot9o8vSVx
         IUhWs3FJC2TdKNjwKn7qg/VJqyDlOR4NosaO//hhYFFobHJ5LLnzW3qgCS+KhCiA/qId
         /fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608695; x=1772213495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iOC0amBgOry/fS/cge6IzaEDhIf74Qzynj9rOeaTjlY=;
        b=TluCoSXXtiyUJL0UqUTy59xgnZ0ABJ/p7Ic1fKL7xYW0hnyPPokxOmI9S6+6xSZlHb
         ZO7h47XtxYP8RzbX1SLLCLzzp/U+xlsh0qi41MBkZ9H1iSIesy0DiyUrg1Jqa3lbFGXo
         Veq1AaylinkYccjObEdoMO0cLkUvG2THhlMNMlYgN+Y+6R9Lapk83ugd+1+UiOi9IHNN
         sZ9xqW/PYrmcdNpmC7tc7mNjrquqGNQE4r5l4o4jT3ygcpCTB/y+E88mB63bIIjTmg+R
         iEkKAaOlEuHwvLPmj17Zf8pdtO7InwxRBdx9Yv8oQgHGQuNhII2TDdLnd5jdJ1PGPvVe
         fweQ==
X-Gm-Message-State: AOJu0YzbCDOhrFheu/V7W7u5bMdiWAM2EtUeJt/q1507DWfE0lAyxnKt
	Z9ucjJhjFbRp+vEb2AU+58H+PSpZQ4Ix2+pmv6ePdxfU00u3OSXo1kgEoU9RZw==
X-Gm-Gg: AZuq6aJ6Sd6o+9VpUkBvEBofB1rtAgNw67FBfVL7E9xjQ8MebW2a13eQkqQsHMVdd6J
	D3LyQ3ZHG3gisXhkrI8BL2+vJpOwzYAMhgQw+ySrizqMGHlZpIlr/6Re+1jl/5z6BD63it4R0cx
	6UC7r2/n3ehBgKK1kgJ6DfRi/kOzs2uRWKznx3SzAehZ6QXf9X183WzBOS8fkIPZYELmfF+CabM
	Bwub5XDG8zkWogv6Tf55M3LgPGTXrhA8ySqOr2msS79nSaJqsp3EdDYE+K2TknHzk2i+dd3oLLR
	DUE+psTq1muhq2SL1EdXG3MkFUDrvm74Sqc0LGrdlrBvJ5Xu9hqwuNxgcACgvsVQlRLrBm3loky
	NurJSy2f0hMJxkxcoI6tDlogX2fyNdF3JNuLt/fyELAB8vIp0BuBvrjOb80epXTjfteKyDSLC+o
	8Lgho6qEIc7W30/CnB8hxCmWzd5STtJE8A0lTsELlNnEbPv2NPiXZYzTqm8gbJ53tHwY96djtQ5
	ynDxSoIqN6BxJYUYVoes0Q385c2
X-Received: by 2002:a05:6122:4b13:b0:567:4f98:fb82 with SMTP id 71dfb90a1353d-568e465dcccmr285346e0c.7.1771608695197;
        Fri, 20 Feb 2026 09:31:35 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/12] doc: add btsnoop protocol manpage
Date: Fri, 20 Feb 2026 12:31:10 -0500
Message-ID: <20260220173120.3418666-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220173120.3418666-1-luiz.dentz@gmail.com>
References: <20260220173120.3418666-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add manpage-style RST doc/btsnoop-protocol.rst and synchronize opcodes
with src/shared/btsnoop.h.
---
 Makefile.am              |   7 +-
 doc/btsnoop-protocol.rst | 221 +++++++++++++++++++++++++++++++++++++++
 doc/btsnoop.txt          | 178 -------------------------------
 3 files changed, 225 insertions(+), 181 deletions(-)
 create mode 100644 doc/btsnoop-protocol.rst
 delete mode 100644 doc/btsnoop.txt

diff --git a/Makefile.am b/Makefile.am
index 064ee91698e2..dee6aa6d0d9b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -367,7 +367,8 @@ CLEANFILES += $(builtin_files)
 
 if MANPAGES
 man_MANS += doc/bluetoothd.8
-man_MANS += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 doc/iso.7
+man_MANS += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 doc/iso.7 \
+		doc/btsnoop.7
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.Bearer.LE.5 doc/org.bluez.Bearer.BREDR.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
@@ -407,7 +408,7 @@ man_MANS += doc/org.bluez.ThermometerManager.5 \
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
-		doc/iso.7
+		doc/iso.7 doc/btsnoop.7
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.Bearer.LE.5 doc/org.bluez.Bearer.BREDR.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
@@ -535,7 +536,7 @@ EXTRA_DIST += doc/org.bluez.ThermometerManager.rst \
 EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
 		doc/pts-opp.txt
 
-EXTRA_DIST += doc/btsnoop.txt
+EXTRA_DIST += doc/btsnoop-protocol.rst
 
 EXTRA_DIST += tools/magic.btsnoop
 
diff --git a/doc/btsnoop-protocol.rst b/doc/btsnoop-protocol.rst
new file mode 100644
index 000000000000..a875db63a9dd
--- /dev/null
+++ b/doc/btsnoop-protocol.rst
@@ -0,0 +1,221 @@
+=======
+btsnoop
+=======
+
+-------------------------------------------
+BTSnoop/Monitor protocol documentation
+-------------------------------------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under the terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: February 2026
+:Manual section: 7
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+This document describes the BTSnoop/Monitor formats used to record and
+transport HCI/PHY traffic. The formats are used by tools such as btmon and the
+BlueZ btsnoop implementation.
+
+DESCRIPTION
+===========
+
+Opcode definitions
+------------------
+
+The following opcodes are used by the BTSnoop/Monitor formats. The numeric
+values match the definitions in ``src/shared/btsnoop.h``.
+
+.. list-table:: BTSnoop opcodes
+   :header-rows: 1
+
+   * - Name
+     - Code (dec)
+     - Code (hex)
+     - Meaning
+   * - BTSNOOP_OPCODE_NEW_INDEX
+     - 0
+     - 0x0000
+     - New controller index (parameters: type, bus, bdaddr, name)
+   * - BTSNOOP_OPCODE_DEL_INDEX
+     - 1
+     - 0x0001
+     - Deleted controller index
+   * - BTSNOOP_OPCODE_COMMAND_PKT
+     - 2
+     - 0x0002
+     - HCI Command packet
+   * - BTSNOOP_OPCODE_EVENT_PKT
+     - 3
+     - 0x0003
+     - HCI Event packet
+   * - BTSNOOP_OPCODE_ACL_TX_PKT
+     - 4
+     - 0x0004
+     - Outgoing ACL packet
+   * - BTSNOOP_OPCODE_ACL_RX_PKT
+     - 5
+     - 0x0005
+     - Incoming ACL packet
+   * - BTSNOOP_OPCODE_SCO_TX_PKT
+     - 6
+     - 0x0006
+     - Outgoing SCO packet
+   * - BTSNOOP_OPCODE_SCO_RX_PKT
+     - 7
+     - 0x0007
+     - Incoming SCO packet
+   * - BTSNOOP_OPCODE_OPEN_INDEX
+     - 8
+     - 0x0008
+     - HCI transport for the specified controller opened
+   * - BTSNOOP_OPCODE_CLOSE_INDEX
+     - 9
+     - 0x0009
+     - HCI transport for the specified controller closed
+   * - BTSNOOP_OPCODE_INDEX_INFO
+     - 10
+     - 0x000a
+     - Index information (parameters: bdaddr, manufacturer)
+   * - BTSNOOP_OPCODE_VENDOR_DIAG
+     - 11
+     - 0x000b
+     - Vendor diagnostic information
+   * - BTSNOOP_OPCODE_SYSTEM_NOTE
+     - 12
+     - 0x000c
+     - System note
+   * - BTSNOOP_OPCODE_USER_LOGGING
+     - 13
+     - 0x000d
+     - User logging (parameters: priority, ident_len, ident)
+   * - BTSNOOP_OPCODE_CTRL_OPEN
+     - 14
+     - 0x000e
+     - Control channel opened
+   * - BTSNOOP_OPCODE_CTRL_CLOSE
+     - 15
+     - 0x000f
+     - Control channel closed
+   * - BTSNOOP_OPCODE_CTRL_COMMAND
+     - 16
+     - 0x0010
+     - Control command packet
+   * - BTSNOOP_OPCODE_CTRL_EVENT
+     - 17
+     - 0x0011
+     - Control event packet
+   * - BTSNOOP_OPCODE_ISO_TX_PKT
+     - 18
+     - 0x0012
+     - Outgoing ISO packet
+   * - BTSNOOP_OPCODE_ISO_RX_PKT
+     - 19
+     - 0x0013
+     - Incoming ISO packet
+
+New Index
+---------
+
+Code: 0x0000
+
+Parameters:
+
+- Type (1 octet)
+- Bus (1 octet)
+- BD_Addr (6 octets)
+- Name (8 octets)
+
+This opcode indicates that a new controller instance with a given index was
+added. With some transports (for example a single TTY device) the index is
+implicitly 0.
+
+Deleted Index
+-------------
+
+Code: 0x0001
+
+Indicates that the controller with a specific index was removed.
+
+TTY-based protocol
+------------------
+
+The TTY protocol used by btmon with the ``--tty`` option is a little-endian
+packet format. Each packet uses this header::
+
+    struct tty_hdr {
+        uint16_t data_len;
+        uint16_t opcode;
+        uint8_t  flags;
+        uint8_t  hdr_len;
+        uint8_t  ext_hdr[0];
+    } __attribute__ ((packed));
+
+The payload starts at ``ext_hdr + hdr_len`` and has length
+``data_len - 4 - hdr_len``.
+
+Extended header format
+----------------------
+
+Each extension field is encoded as::
+
+    struct {
+        uint8_t type;
+        uint8_t value[length];
+    };
+
+Defined types:
+
+.. list-table:: Extended header types
+   :header-rows: 1
+
+   * - Type
+     - Length
+     - Meaning
+   * - 1
+     - 1 byte
+     - Command drops (dropped HCI command packets)
+   * - 2
+     - 1 byte
+     - Event drops (dropped HCI event packets)
+   * - 3
+     - 1 byte
+     - ACL TX drops
+   * - 4
+     - 1 byte
+     - ACL RX drops
+   * - 5
+     - 1 byte
+     - SCO TX drops
+   * - 6
+     - 1 byte
+     - SCO RX drops
+   * - 7
+     - 1 byte
+     - Other drops
+   * - 8
+     - 4 bytes
+     - 32-bit timestamp (1/10th ms)
+
+The drops fields contain the number of packets the implementation had to drop
+since the last reported drop count. Extension fields must be sorted by
+increasing ``type`` so unknown types can be skipped and the payload location
+discovered.
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
+
+SEE ALSO
+========
+
+btmon(1)
diff --git a/doc/btsnoop.txt b/doc/btsnoop.txt
deleted file mode 100644
index 975a53f6dd44..000000000000
--- a/doc/btsnoop.txt
+++ /dev/null
@@ -1,178 +0,0 @@
-BTSnoop/Monitor protocol formats
-********************************
-
-Opcode definitions
-==================
-
-New Index
----------
-
-	Code:        0x0000
-	Parameters:  Type (1 Octet
-		     Bus (1 Octet)
-		     BD_Addr (6 Octets)
-		     Name (8 Octets)
-
-	This opcode indicates that a new controller instance with a
-	given index was added. With some protocols, like the TTY-based
-	one there is only a single supported controller, meaning the
-	index is implicitly 0.
-
-Deleted Index
--------------
-
-	Code:        0x0001
-
-	This opcode indicates that the controller with a specific index
-	was removed.
-
-Command Packet
---------------
-
-	Code:        0x0002
-
-	HCI command packet.
-
-Event Packet
-------------
-
-	Code:        0x0003
-
-	HCI event packet.
-
-ACL TX Packet
--------------
-
-	Code:        0x0004
-
-	Outgoing ACL packet.
-
-ACL RX Packet
--------------
-
-	Code:        0x0005
-
-	Incoming ACL packet.
-
-SCO TX Packet
---------------
-
-	Code:        0x0006
-
-	Outgoing SCO packet.
-
-SCO RX Packet
--------------
-
-	Code:        0x0007
-
-	Incomnig SCO packet.
-
-Open Index
-----------
-
-	Code:        0x0008
-
-	The HCI transport for the specified controller has been opened.
-
-Close Index
------------
-
-	Code:        0x0009
-
-	The HCI transport for the specified controller has been closed.
-
-Index Information
------------------
-
-	Code:        0x000a
-	Parameters:  BD_Addr (6 Octets)
-		     Manufacturer (2 Octets)
-
-	Information about a specific controller.
-
-Vendor Diagnostics
-------------------
-
-	Code:        0x000b
-
-	Vendor diagnostic information.
-
-System Note
------------
-
-	Code:        0x000c
-
-	System note.
-
-User Logging
-------------
-
-	Code:        0x000d
-	Parameters:  Priority (1 Octet)
-		     Ident_Length (1 Octet)
-		     Ident (Ident_Length Octets)
-
-	User logging information.
-
-
-TTY-based protocol
-==================
-
-This section covers the protocol that can be parsed by btmon when
-passing it the --tty parameter. The protocol is little endian, packet
-based, and has the following header for each packet:
-
-struct tty_hdr {
-	uint16_t data_len;
-	uint16_t opcode;
-	uint8_t  flags;
-	uint8_t  hdr_len;
-	uint8_t  ext_hdr[0];
-} __attribute__ ((packed));
-
-The actual payload starts at ext_hdr + hdr_len and has the length of
-data_len - 4 - hdr_len. Each field of the header is defined as follows:
-
-data_len:
-	This is the total length of the entire packet, excuding the
-	data_len field itself.
-
-opcode:
-	The BTSnoop opcode
-
-flags:
-	Special flags for the packet. Currently no flags are defined.
-
-hdr_len:
-	Length of the extended header.
-
-ext_hdr:
-	This is a sequence of header extension fields formatted as:
-
-	struct {
-		uint8_t type;
-		uint8_t value[length];
-	}
-
-	The length of the value is dependent on the type. Currently the
-	following types are defined:
-
-	Type                 Length    Meaning
-	----------------------------------------------------------------
-	1  Command drops     1 byte    Dropped HCI command packets
-	2  Event drops       1 byte    Dropped HCI event packets
-	3  ACL TX drops      1 byte    Dropped ACL TX packets
-	4  ACL RX drops      1 byte    Dropped ACL RX packets
-	5  SCO TX drops      1 byte    Dropped SCO TX packets
-	6  SCO RX drops      1 byte    Dropped SCO RX packets
-	7  Other drops       1 byte    Dropped other packets
-	8  32-bit timestamp  4 bytes   Timestamp in 1/10th ms
-
-	The drops fields indicate the number of packets that the
-	implementation had to drop (e.g. due to lack of buffers) since
-	the last reported drop count.
-
-	The fields of the extended header must be sorted by increasing
-	type. This is essential so that unknown types can be ignored and
-	the parser can jump to processing the payload.
-- 
2.52.0

