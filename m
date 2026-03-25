Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F02DC765
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464863; cv=none; b=LNdvUxulxMbsYx1vmtdLZnZQMmm8Pn+endKXYtHd5jyVTj+jczyhgwcD11WXNRSXN3ohNaFJjixAyiva6AcQcqcKlKI/E/hvIUaHXVfQFlG32ulTsHxF0syFCN+GqrcrgTKB/7AZrYLZTGOydtCeu+FA2u86vfDe29rOPCRQ6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464863; c=relaxed/simple;
	bh=c9l4IUjuLUDVspGYHzyiWezAj9Rivve7UoU+tqBw4b4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNpI6BsIcbbdysG/wCtf0FiVMgu0UpoOb9Cf4AHJIrD93PbMYPMvEGf2IVrDXVO3DPu/7FegLzl917bBRuPM6rCSu+2+Q1+KY6STURTPBf/nwlBd1PH6F7qMgO9G9/Rggx0zgrskOKZadophnFx6vscYmj5uc5Q5q066L47n1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3qtozyp; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3qtozyp"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso236706e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464860; x=1775069660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ujh0A4pJq80DrkvHjGyBk48ZcRCX7OXwfDRn66dK2OA=;
        b=E3qtozypqwhRfQaBcKf424UAzd9Zc8FUgy6M/d5ztOCR+3RQzcX6E9FkNV0n6VC7by
         zoB7oRuoEIwCbGuUft8b9bbN6mhiQedH2VCHOv2ZHNjcLph+t5cTrlbiVW+H4vTjTQrR
         ed9ZloMY1wa0pulOgM1J5oix5Oj+uY91jtdAH1m1/1luKLVHVj8X29rbWOLLvpweNF8H
         du8QfX+N3I8n/x5GTaolmVkwrK4/uxAfUXZiY60hE4NWqqKVBu7Q2f2ETqPU2bdxSdZH
         kYFExzhKqJUEMPe194Pd/Iiq85YBNLo3Pgr2OfM1t7k7v0ws0G+xygykByyoFJ+3QYV6
         bqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464860; x=1775069660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ujh0A4pJq80DrkvHjGyBk48ZcRCX7OXwfDRn66dK2OA=;
        b=j9f2ELi7EPbOMFJT/KAqRRtwT2byRWm3+80kIxSlJOkfex+7N2JYB9A45RoZaLY4bU
         5Zkt3+PtH/I5WrIbWWIqPDAtUnVZw9zrfquHHddOeDkqBwRkCk7NXDUqGCZfOqbvXMLg
         7ybT4DE0yduJIokzPnojas2g5v2rZqdyoNawT/1oJkZJwHs2ITbE6fKQlJJ7UJCbNrfM
         B8ANSb5+rhrr7jIun7czCoBDPLprEivkOJ3MeB8dabs0BpW/hfcuzZkRTJ2pK8EUA7nJ
         b0InxBuC7ysIkhWjbu2iF236i44EKK/ht35kdfmtVd3WZa0erJkf34ZiKRV4k6ozmgBc
         ErnA==
X-Gm-Message-State: AOJu0Yyk31AhiqJ8toAoWAFI5JfuOZwL9ytuP5T9M1b70xwAcD5tt5TC
	TR7npc5K8c6Yv9Lx/w3uCvwb0cEu4mzqAKGsSL1aU4yCMX7lQ7C2VJATCy4uG52g
X-Gm-Gg: ATEYQzxLGUSMotd+wHcHOUFwzgeCQ+3N21ElgU/SH9Tdy8UMcSOyd9shyz3sc81uu2O
	Rpl9kXo6Ehnvk8vTzq4uQOaYDU9TWVtodQFZ6kTF0I7H0QDNufYf0SFS3qcE6hYiAeVtkKB3LSu
	iWSrtNWI6c97GBQWQcxOFC7wBUe13Nm5Pglzuc9/xe48TvKAOEft2VXJOM75JgTKOGaiJfOP6Lq
	tqaPTWtJgsiFeNHsN1YqQaF6aYRNSHT8p6XjIJJnQunOxcMos8bKWSFpTcUHLIA5adEAoopJWCW
	AlCvp21PVzNbK9Q5ZEPJfb5B3C+r9B0rCcXMYPbblhvle4ZvEdTaBZXahmynC/LkS+SzioIVGww
	DkBQfLDiIW75gxkyrzrkELQfvCHG26o9pwvs3Sf/aPom406sG6MXHSWKatAjHlWtZMNWpVUDB5j
	uiokBaQcB32w3+Ga/hE/+yQlvOJhNa+3N00TQJkge4+cgpiambnshX/F4zexGJ5O2eFMXqvrZbR
	w3RrxApHLkFKFpmjg==
X-Received: by 2002:a05:6122:d1c:b0:56b:7252:cbbe with SMTP id 71dfb90a1353d-56d220ba66fmr2744038e0c.15.1774464860030;
        Wed, 25 Mar 2026 11:54:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d71947sm921438e0c.14.2026.03.25.11.54.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:54:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/9] doc/btmon: Split SMP Pairing Flow into btmon-smp.rst
Date: Wed, 25 Mar 2026 14:54:00 -0400
Message-ID: <20260325185406.568078-4-luiz.dentz@gmail.com>
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

Move the SMP PAIRING FLOW section into a standalone file and replace
it with an RST include directive.
---
 Makefile.am       |   2 +
 doc/btmon-smp.rst | 248 +++++++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst     | 249 +---------------------------------------------
 3 files changed, 252 insertions(+), 247 deletions(-)
 create mode 100644 doc/btmon-smp.rst

diff --git a/Makefile.am b/Makefile.am
index 292ef64a98d3..5f2ce6a2d0f8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -544,6 +544,8 @@ EXTRA_DIST += doc/btmon-le-audio.rst
 
 EXTRA_DIST += doc/btmon-l2cap.rst
 
+EXTRA_DIST += doc/btmon-smp.rst
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
diff --git a/doc/btmon-smp.rst b/doc/btmon-smp.rst
new file mode 100644
index 000000000000..00b0b34fe1bb
--- /dev/null
+++ b/doc/btmon-smp.rst
@@ -0,0 +1,248 @@
+.. This file is included by btmon.rst.
+
+SMP PAIRING FLOW
+================
+
+The Security Manager Protocol (SMP) handles pairing, key generation,
+and key distribution between Bluetooth devices. SMP traffic appears
+inside L2CAP on fixed CID 0x0006 (LE) or CID 0x0007 (BR/EDR). btmon
+decodes all SMP operations automatically.
+
+Pairing Phases
+--------------
+
+SMP pairing proceeds in three phases. Each phase produces a distinct
+pattern in the btmon output.
+
+**Phase 1: Feature Exchange**
+
+Pairing begins when one device sends a Security Request (peripheral)
+or the host initiates pairing directly. The initiator sends a Pairing
+Request and the responder replies with a Pairing Response::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #497 [hci0] 0.026107
+          SMP: Pairing Request (0x01) len 6
+            IO capability: NoInputNoOutput (0x03)
+            OOB data: Authentication data not present (0x00)
+            Authentication requirement: Bonding, MITM, SC, CT2 (0x2d)
+            Max encryption key size: 16
+            Initiator key distribution: IdKey Sign (0x06)
+            Responder key distribution: IdKey Sign (0x06)
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #499 [hci0] 0.026894
+          SMP: Pairing Response (0x02) len 6
+            IO capability: KeyboardDisplay (0x04)
+            OOB data: Authentication data not present (0x00)
+            Authentication requirement: Bonding, SC, CT2 (0x29)
+            Max encryption key size: 16
+            Initiator key distribution: IdKey (0x02)
+            Responder key distribution: IdKey (0x02)
+
+Key fields to check:
+
+- **Authentication requirement** -- The ``SC`` flag indicates Secure
+  Connections. Its absence means Legacy Pairing.
+- **IO capability** -- Determines the association model (Just Works,
+  Passkey Entry, Numeric Comparison, OOB).
+- **Key distribution** -- Which keys each side will send after
+  encryption is established. ``IdKey`` = Identity Resolving Key (IRK),
+  ``EncKey`` = Long Term Key (legacy only), ``Sign`` = CSRK.
+
+**Phase 2: Authentication (Secure Connections)**
+
+For Secure Connections pairing (``SC`` flag set), both devices exchange
+public keys, then perform confirm/random value exchange::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 69       #501 [hci0] 0.098224
+          SMP: Pairing Public Key (0x0c) len 64
+            X: 1a2b3c4d...
+            Y: 5e6f7a8b...
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 69       #503 [hci0] 0.148556
+          SMP: Pairing Public Key (0x0c) len 64
+            X: 9c8d7e6f...
+            Y: 0a1b2c3d...
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #505 [hci0] 0.149003
+          SMP: Pairing Confirm (0x03) len 16
+            Confirm value: a1b2c3d4e5f6...
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #507 [hci0] 0.212884
+          SMP: Pairing Random (0x04) len 16
+            Random value: 1122334455...
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #509 [hci0] 0.213100
+          SMP: Pairing Random (0x04) len 16
+            Random value: 6677889900...
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #511 [hci0] 0.278003
+          SMP: Pairing DHKey Check (0x0d) len 16
+            E: aabbccddee...
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #513 [hci0] 0.278450
+          SMP: Pairing DHKey Check (0x0d) len 16
+            E: ffeeddccbb...
+
+After DHKey Check, the initiator starts encryption at the HCI level::
+
+    < HCI Command: LE Start Encryption (0x08|0x0019) plen 28  #515 [hci0] 0.279002
+    > HCI Event: Encryption Change (0x08) plen 4              #517 [hci0] 0.342556
+          Status: Success (0x00)
+          Handle: 2048
+          Encryption: Enabled with AES-CCM (0x01)
+
+**Phase 2: Authentication (Legacy Pairing)**
+
+Legacy pairing (no ``SC`` flag) skips the Public Key and DHKey Check
+exchanges. Only Confirm and Random values are exchanged::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #501 [hci0] 0.098224
+          SMP: Pairing Confirm (0x03) len 16
+            Confirm value: ...
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #503 [hci0] 0.162556
+          SMP: Pairing Confirm (0x03) len 16
+            Confirm value: ...
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #505 [hci0] 0.163003
+          SMP: Pairing Random (0x04) len 16
+            Random value: ...
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #507 [hci0] 0.228884
+          SMP: Pairing Random (0x04) len 16
+            Random value: ...
+
+**Phase 3: Key Distribution**
+
+After encryption is established, each device distributes keys as
+negotiated in Phase 1::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #519 [hci0] 0.343002
+          SMP: Identity Information (0x08) len 16
+            Identity resolving key: 00112233445566778899aabbccddeeff
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 12       #521 [hci0] 0.343556
+          SMP: Identity Address Information (0x09) len 7
+            Address type: Public (0x00)
+            Address: 00:11:22:33:44:55
+
+The Identity Address Information reveals the device's true public or
+static random address (as opposed to a Resolvable Private Address used
+during connection).
+
+For Legacy Pairing, LTK distribution also appears::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #519 [hci0] 0.343002
+          SMP: Encryption Information (0x06) len 16
+            Long term key: 00112233...
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 15       #521 [hci0] 0.343556
+          SMP: Central Identification (0x07) len 10
+            EDIV: 0x1234
+            Rand: 0x0123456789abcdef
+
+Pairing Failure
+---------------
+
+When pairing fails, one device sends a Pairing Failed PDU::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 6        #505 [hci0] 0.213002
+          SMP: Pairing Failed (0x05) len 1
+            Reason: Authentication requirements (0x03)
+
+SMP failure reasons:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 8 35 57
+
+   * - Code
+     - Reason
+     - Diagnostic Meaning
+   * - 0x01
+     - Passkey Entry Failed
+     - User cancelled or entered wrong passkey
+   * - 0x02
+     - OOB Not Available
+     - OOB data expected but not provided
+   * - 0x03
+     - Authentication Requirements
+     - Devices cannot agree on security level (e.g.,
+       one requires MITM but IO caps only allow Just Works)
+   * - 0x04
+     - Confirm Value Failed
+     - Cryptographic check failed; possible MITM attack
+   * - 0x05
+     - Pairing Not Supported
+     - Remote does not support pairing
+   * - 0x06
+     - Encryption Key Size
+     - Cannot agree on key size
+   * - 0x07
+     - Command Not Supported
+     - Received unrecognized SMP command
+   * - 0x08
+     - Unspecified Reason
+     - Generic failure
+   * - 0x09
+     - Repeated Attempts
+     - Pairing rate-limited; wait before retry
+   * - 0x0a
+     - Invalid Parameters
+     - Invalid fields in SMP command
+   * - 0x0b
+     - DHKey Check Failed
+     - ECDH key agreement failed (SC only)
+   * - 0x0c
+     - Numeric Comparison Failed
+     - User rejected numeric comparison
+   * - 0x0d
+     - BR/EDR Pairing In Progress
+     - Classic pairing already active
+   * - 0x0e
+     - Cross-Transport Key Derivation Not Allowed
+     - CTKD rejected by policy
+
+Automating Pairing Analysis
+----------------------------
+
+**Identify all pairing attempts**::
+
+    grep -n "Pairing Request\|Pairing Response\|Pairing Failed\|Pairing Public Key\|DHKey Check" output.txt
+
+**Check pairing method (Secure Connections vs Legacy)**:
+
+- If ``Pairing Public Key`` appears between Request/Response and
+  Confirm: Secure Connections.
+- If only Confirm/Random follow Request/Response: Legacy Pairing.
+- Check the ``Authentication requirement`` line for the ``SC`` flag.
+
+**Detect pairing failures**::
+
+    grep -n "Pairing Failed" output.txt
+
+**Correlate pairing with encryption**:
+
+After successful pairing, expect ``Encryption Change`` with
+``Status: Success``. Search for::
+
+    grep -n "Encryption Change\|Encryption:" output.txt
+
+**Identify re-pairing on reconnect**:
+
+Reconnections to a bonded device should show ``Encryption Change``
+without SMP traffic (using stored keys). If SMP Pairing Request
+appears on reconnection, the bond was lost on one side.
+
+**Full pairing diagnosis pattern**:
+
+1. Find ``Pairing Request`` -- note the handle, IO capabilities,
+   auth requirements
+2. Find ``Pairing Response`` -- compare IO capabilities to determine
+   association model
+3. Check for ``Pairing Failed`` -- if present, the reason code
+   identifies the failure
+4. Check for ``Encryption Change`` with ``Status: Success`` -- confirms
+   pairing completed
+5. Check for ``Identity Address Information`` -- reveals the device's
+   true address
diff --git a/doc/btmon.rst b/doc/btmon.rst
index 6f283c21c490..a9b08bdfab01 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1129,253 +1129,6 @@ The CCC descriptor at handle 0x000d belongs to the Service Changed
 characteristic (0x000c), because it falls between that value handle
 and the next characteristic declaration at 0x000e.
 
-SMP PAIRING FLOW
-================
-
-The Security Manager Protocol (SMP) handles pairing, key generation,
-and key distribution between Bluetooth devices. SMP traffic appears
-inside L2CAP on fixed CID 0x0006 (LE) or CID 0x0007 (BR/EDR). btmon
-decodes all SMP operations automatically.
-
-Pairing Phases
---------------
-
-SMP pairing proceeds in three phases. Each phase produces a distinct
-pattern in the btmon output.
-
-**Phase 1: Feature Exchange**
-
-Pairing begins when one device sends a Security Request (peripheral)
-or the host initiates pairing directly. The initiator sends a Pairing
-Request and the responder replies with a Pairing Response::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #497 [hci0] 0.026107
-          SMP: Pairing Request (0x01) len 6
-            IO capability: NoInputNoOutput (0x03)
-            OOB data: Authentication data not present (0x00)
-            Authentication requirement: Bonding, MITM, SC, CT2 (0x2d)
-            Max encryption key size: 16
-            Initiator key distribution: IdKey Sign (0x06)
-            Responder key distribution: IdKey Sign (0x06)
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #499 [hci0] 0.026894
-          SMP: Pairing Response (0x02) len 6
-            IO capability: KeyboardDisplay (0x04)
-            OOB data: Authentication data not present (0x00)
-            Authentication requirement: Bonding, SC, CT2 (0x29)
-            Max encryption key size: 16
-            Initiator key distribution: IdKey (0x02)
-            Responder key distribution: IdKey (0x02)
-
-Key fields to check:
-
-- **Authentication requirement** -- The ``SC`` flag indicates Secure
-  Connections. Its absence means Legacy Pairing.
-- **IO capability** -- Determines the association model (Just Works,
-  Passkey Entry, Numeric Comparison, OOB).
-- **Key distribution** -- Which keys each side will send after
-  encryption is established. ``IdKey`` = Identity Resolving Key (IRK),
-  ``EncKey`` = Long Term Key (legacy only), ``Sign`` = CSRK.
-
-**Phase 2: Authentication (Secure Connections)**
-
-For Secure Connections pairing (``SC`` flag set), both devices exchange
-public keys, then perform confirm/random value exchange::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 69       #501 [hci0] 0.098224
-          SMP: Pairing Public Key (0x0c) len 64
-            X: 1a2b3c4d...
-            Y: 5e6f7a8b...
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 69       #503 [hci0] 0.148556
-          SMP: Pairing Public Key (0x0c) len 64
-            X: 9c8d7e6f...
-            Y: 0a1b2c3d...
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #505 [hci0] 0.149003
-          SMP: Pairing Confirm (0x03) len 16
-            Confirm value: a1b2c3d4e5f6...
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #507 [hci0] 0.212884
-          SMP: Pairing Random (0x04) len 16
-            Random value: 1122334455...
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #509 [hci0] 0.213100
-          SMP: Pairing Random (0x04) len 16
-            Random value: 6677889900...
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #511 [hci0] 0.278003
-          SMP: Pairing DHKey Check (0x0d) len 16
-            E: aabbccddee...
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #513 [hci0] 0.278450
-          SMP: Pairing DHKey Check (0x0d) len 16
-            E: ffeeddccbb...
-
-After DHKey Check, the initiator starts encryption at the HCI level::
-
-    < HCI Command: LE Start Encryption (0x08|0x0019) plen 28  #515 [hci0] 0.279002
-    > HCI Event: Encryption Change (0x08) plen 4              #517 [hci0] 0.342556
-          Status: Success (0x00)
-          Handle: 2048
-          Encryption: Enabled with AES-CCM (0x01)
-
-**Phase 2: Authentication (Legacy Pairing)**
-
-Legacy pairing (no ``SC`` flag) skips the Public Key and DHKey Check
-exchanges. Only Confirm and Random values are exchanged::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #501 [hci0] 0.098224
-          SMP: Pairing Confirm (0x03) len 16
-            Confirm value: ...
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #503 [hci0] 0.162556
-          SMP: Pairing Confirm (0x03) len 16
-            Confirm value: ...
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #505 [hci0] 0.163003
-          SMP: Pairing Random (0x04) len 16
-            Random value: ...
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #507 [hci0] 0.228884
-          SMP: Pairing Random (0x04) len 16
-            Random value: ...
-
-**Phase 3: Key Distribution**
-
-After encryption is established, each device distributes keys as
-negotiated in Phase 1::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #519 [hci0] 0.343002
-          SMP: Identity Information (0x08) len 16
-            Identity resolving key: 00112233445566778899aabbccddeeff
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 12       #521 [hci0] 0.343556
-          SMP: Identity Address Information (0x09) len 7
-            Address type: Public (0x00)
-            Address: 00:11:22:33:44:55
-
-The Identity Address Information reveals the device's true public or
-static random address (as opposed to a Resolvable Private Address used
-during connection).
-
-For Legacy Pairing, LTK distribution also appears::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 21       #519 [hci0] 0.343002
-          SMP: Encryption Information (0x06) len 16
-            Long term key: 00112233...
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 15       #521 [hci0] 0.343556
-          SMP: Central Identification (0x07) len 10
-            EDIV: 0x1234
-            Rand: 0x0123456789abcdef
-
-Pairing Failure
----------------
-
-When pairing fails, one device sends a Pairing Failed PDU::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 6        #505 [hci0] 0.213002
-          SMP: Pairing Failed (0x05) len 1
-            Reason: Authentication requirements (0x03)
-
-SMP failure reasons:
-
-.. list-table::
-   :header-rows: 1
-   :widths: 8 35 57
-
-   * - Code
-     - Reason
-     - Diagnostic Meaning
-   * - 0x01
-     - Passkey Entry Failed
-     - User cancelled or entered wrong passkey
-   * - 0x02
-     - OOB Not Available
-     - OOB data expected but not provided
-   * - 0x03
-     - Authentication Requirements
-     - Devices cannot agree on security level (e.g.,
-       one requires MITM but IO caps only allow Just Works)
-   * - 0x04
-     - Confirm Value Failed
-     - Cryptographic check failed; possible MITM attack
-   * - 0x05
-     - Pairing Not Supported
-     - Remote does not support pairing
-   * - 0x06
-     - Encryption Key Size
-     - Cannot agree on key size
-   * - 0x07
-     - Command Not Supported
-     - Received unrecognized SMP command
-   * - 0x08
-     - Unspecified Reason
-     - Generic failure
-   * - 0x09
-     - Repeated Attempts
-     - Pairing rate-limited; wait before retry
-   * - 0x0a
-     - Invalid Parameters
-     - Invalid fields in SMP command
-   * - 0x0b
-     - DHKey Check Failed
-     - ECDH key agreement failed (SC only)
-   * - 0x0c
-     - Numeric Comparison Failed
-     - User rejected numeric comparison
-   * - 0x0d
-     - BR/EDR Pairing In Progress
-     - Classic pairing already active
-   * - 0x0e
-     - Cross-Transport Key Derivation Not Allowed
-     - CTKD rejected by policy
-
-Automating Pairing Analysis
-----------------------------
-
-**Identify all pairing attempts**::
-
-    grep -n "Pairing Request\|Pairing Response\|Pairing Failed\|Pairing Public Key\|DHKey Check" output.txt
-
-**Check pairing method (Secure Connections vs Legacy)**:
-
-- If ``Pairing Public Key`` appears between Request/Response and
-  Confirm: Secure Connections.
-- If only Confirm/Random follow Request/Response: Legacy Pairing.
-- Check the ``Authentication requirement`` line for the ``SC`` flag.
-
-**Detect pairing failures**::
-
-    grep -n "Pairing Failed" output.txt
-
-**Correlate pairing with encryption**:
-
-After successful pairing, expect ``Encryption Change`` with
-``Status: Success``. Search for::
-
-    grep -n "Encryption Change\|Encryption:" output.txt
-
-**Identify re-pairing on reconnect**:
-
-Reconnections to a bonded device should show ``Encryption Change``
-without SMP traffic (using stored keys). If SMP Pairing Request
-appears on reconnection, the bond was lost on one side.
-
-**Full pairing diagnosis pattern**:
-
-1. Find ``Pairing Request`` -- note the handle, IO capabilities,
-   auth requirements
-2. Find ``Pairing Response`` -- compare IO capabilities to determine
-   association model
-3. Check for ``Pairing Failed`` -- if present, the reason code
-   identifies the failure
-4. Check for ``Encryption Change`` with ``Status: Success`` -- confirms
-   pairing completed
-5. Check for ``Identity Address Information`` -- reveals the device's
-   true address
-
 PROTOCOL ERROR CODES
 =====================
 
@@ -1560,6 +1313,8 @@ Errors often cascade across layers. Common patterns:
 PROTOCOL FLOWS
 ===============
 
+.. include:: btmon-smp.rst
+
 .. include:: btmon-l2cap.rst
 
 .. include:: btmon-le-audio.rst
-- 
2.53.0

