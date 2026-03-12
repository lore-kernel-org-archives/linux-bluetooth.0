Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB33D16FB
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335760; cv=none; b=Zg5/lSC+VCSngc33S/hiMlS7Fi89VhNbJ2tbuketOLUxJrwHS4XUYm6vcuttVtZJmyyJwHRbHH1ie2UD1ChzwTVG74am7+qf1WxIEdXaoEvptNYmXuJ1BJI3Zbejw8uRGKUvg6A6ROLTYNfcD0IOllEv+2okAqJeqrgONRuQe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335760; c=relaxed/simple;
	bh=1apk5n0UghYlzk5vqPG7X+Jf9tZR5ccG/baAv6kxoKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhu73sCLX/9sN+7voSNb2JPVOJsgDGxGfJEyUFlgsoz8mT/OzZcvci0f/QBkn7WRTyk3lJIT7ocB4stnCsHFT+bSACfChATPCV9LilGJyZfjp+A0/S1lkPBLETqyNiQg/6+Sv9v4Nf7aA4j4aauKw+1GbCb0EAHnZb9ZCNQT5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEv4LWGm; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEv4LWGm"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so1465753d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335755; x=1773940555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8O9jDtopoxy9qVKJ0yRB03V6ckDoZukqw7wSloMZms=;
        b=PEv4LWGmJDs4PSTRa0evAI42/f8QbfE+QMm8ZDBF9vCON6jyQ2hi7cKbCjTUFXr8fW
         lFLu5Cxhxq1R1iJihUJnh8ohOahELrBdSDavnMUvzskUf+8LHnUTvt9/Bq7UBpN6onyd
         HJGYGb0j+GoY0ZTSJRfQVfTUuGCB/jGMt3Pdt29wKsN6ZfFI9Y9wL3NTa/6hXRU4pCJ7
         VtWrZmbkWSOc/FDrdNk40bVmOJXSCOujmeit2p1Vn5NLrAQgMGP9Lrdy9QnRZ1/hTZJH
         P74us1dKxpB6aYFKPYGAggZXGat7WdFA9HMpirHuIKJPzXD8+ZPjtz5pxRLD/YGFjwop
         MW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335755; x=1773940555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r8O9jDtopoxy9qVKJ0yRB03V6ckDoZukqw7wSloMZms=;
        b=ROx4A4sDRpXV8cq4bjPPf66pUtJA9iMPWyLIidnaXcdGj6UOSbf1z3MpDZLSAb+xO9
         vDKMuEEbatAcMhgD9BN/dWWoFTZt4XK9fH1qVISK3IlTjoxfKsEsxudWEX6z37ifDuJX
         aNOG849nShblEoMw6xT3Wr0bsByAjhPIj8Y6zWC230fRZOCtQ+jS/I+dRUkbzuopcxqv
         fMZGt4HQ0Y+s0xLRNP82BZ6P2R8yz+cUoffisdyQkblJT5Cf7ULsCw3mNizawRfe2F+w
         Y2Ux1AsMKr8P9yIlcXmTVvwthB+dHZJaGTiEKnKKguOfRNJyOERt8eqEnVq1724kBl6Z
         l6lw==
X-Gm-Message-State: AOJu0Yybzmbvoyo4S29OvISp2J+neOXN1hDc5rkCf0hH+QWwzr3Rjv7M
	U/dsRLmK0MaR5UZJQkynBbaDNX9H5F6KkYEyS16BS+Dl+7Kv1UkHkGa6AOHjQw==
X-Gm-Gg: ATEYQzxc+WlAf3gYXGn3eZ7Wpgf9VyH0qRhrgt1Ps/3LbepkdOrSnMGPXdb73c6VNug
	C87msgd2CnHpB8lSVUJk+bNTzaWLCPyLjJMw5fymIPJDcvTMsoKLkZRob828xjWaBcdXMtaaqLE
	83D9YtnSKmcxT3mxnfJihDsNEs6G1F3S/nAIhnPuHAfR1tdnaetToGdftV1SSP/hTiBEbpQBKd2
	tpMFZigt5UndcILflh4uUNm/eXCl0oj5K+eiWismr1DjnMahI0xcl3sCvBvp0iUjB++Gb6etZKp
	Cy5KEDptnSlOmgAVhv4V9U6sDHaLqh7zQvHnhLepryaUdOBrCPl3ybLg7zQ7mNYyAk6IEhQena/
	7ocs8rksQt1RVYohuFp7tlR99NrVyZp161h29uSKDUTOrNBtLg9rS9u7WCaUF/H0BWFSOAUBFmQ
	11YGpAwJIAlp/gpvb8D2iY+LPI4ij5aWlSA1a49JfHsI9Q8UPt9k5aQS9JqApi32KhlHoCvIhp0
	4mmvtlW4Cy9bbzjcg==
X-Received: by 2002:a05:690c:698a:b0:797:adcf:67f8 with SMTP id 00721157ae682-79a1c0fcf4cmr3944267b3.25.1773335754390;
        Thu, 12 Mar 2026 10:15:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d65117a82sm3442572d50.15.2026.03.12.10.15.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:15:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/6] doc/btmon: Split SMP Pairing Flow into btmon-smp.rst
Date: Thu, 12 Mar 2026 13:15:37 -0400
Message-ID: <20260312171540.1065212-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312171540.1065212-1-luiz.dentz@gmail.com>
References: <20260312171540.1065212-1-luiz.dentz@gmail.com>
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
 doc/btmon-smp.rst | 252 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst     | 247 +--------------------------------------------
 2 files changed, 253 insertions(+), 246 deletions(-)
 create mode 100644 doc/btmon-smp.rst

diff --git a/doc/btmon-smp.rst b/doc/btmon-smp.rst
new file mode 100644
index 000000000000..403032fbfc74
--- /dev/null
+++ b/doc/btmon-smp.rst
@@ -0,0 +1,252 @@
+===========================
+btmon: SMP Pairing Flow
+===========================
+
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
index 84b9f29df95d..799066e83e74 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1129,252 +1129,7 @@ The CCC descriptor at handle 0x000d belongs to the Service Changed
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
+.. include:: btmon-smp.rst
 
 .. include:: btmon-l2cap.rst
 
-- 
2.53.0

