Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0B3D092C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162700; cv=none; b=B4R+szFkS9B5bVEdk90wQEJ3jjh0xUMJuT0WoNGiKDi/YzbZ7MD4YBCBLEGc05psBY19e1RolcQaWIsWrh5WlF7frsfFY3E4u/oRk0ebsBuP5OpGEDJOyCwRJ+bqmAfDmu7AhCC+uj6cPrDgQAELYijkSZuOqqziIY8ZTXvTh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162700; c=relaxed/simple;
	bh=G8YGd4hf7QOuePV4BdpRBN0B/UY3aY5cNhi9QsSYO00=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcAXGw4m/xMkJHbDN0f/JfGh/+JzsmiaxbBpR2JudYVK506fDGvZ9L9hOsK22xIZHdzYRHWFGoyJSOB3XsSuVlIWFXXFoEJ8AB8jbYTtIg9t/MFiCNV+COjZCcMjmh5TeRkzETcveisnLSfiBJ8u9LTESzkaBsqEj4my+sVnA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4B1T+6g; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4B1T+6g"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7da9so119579167b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162697; x=1773767497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXiIQM5+uW9tCc+XSCdIzld4IYzT/Zva9aH2LMWKoVU=;
        b=N4B1T+6gOBiADRwmOsIlk5tKRelbEST10UB15c8w9olrzglaXQ68SHoAImovL+Ap47
         lhmN2RFDqsNeC2Eo9VtkCTen6yMZxzG3ZYuF92MgvxBq4SbYah3KvWYYJmWlj9ESxL94
         YftOCGIJ2MW4eXgVvSUPXbi3fGvBZyEYHusP9Diu+6PVWLgCWbu+J2h7vnz89gga0Rlk
         OrWZwCnwidg8gAAckKMd3id6JAVKBymhq3R7mA1kIrXro6DZWH1/Lj/0ZtXK+SW06SlL
         6Wj9gLaOnDXYkNuXF9l27EuLceHbkIcnP51KkgcYVlajwNo1+d4BeaRPzKsor0sD1Qun
         ZvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162697; x=1773767497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gXiIQM5+uW9tCc+XSCdIzld4IYzT/Zva9aH2LMWKoVU=;
        b=Y3ObrJZ8BQPgqOY2kL5KhWYTD6AWYG4z7NrdnhXl0dMVZvRBBBtzvDmmMAaPwqKieM
         bJOGt4R4uTJjJYKypoxBd/G/ku/1IzAZGaZnmDy/S0aDwoLNRujYQDh38GY/fI+Np0aa
         cNjIuVnWOo9xftpm7Cy6FPiRhOPSc4kJYRf/gcQns2kLMej2wr3Xkwk2dKuF7BAANBof
         NpUNX4fd99nXa6AMwLptLDp/z79ih9PzGCXt+fcJOXPRaVon91dbNd2SqBfgJdN2v7cl
         mJs0wL1SmQ7//7WxSkU3xv8sBGyD2lKsE8lMAk1vXLhCRat7GzkV4Xkl6Qag42ze4t3k
         jV6Q==
X-Gm-Message-State: AOJu0Yz3AiomGmhuaEvRJyl+m/FT5ZWcib/aLjzaV4+HmfKqnRRfMYIJ
	Sj31Brn+CrzVzdJbGB9icuRioOK2Iq2wklysxxuEJJhgBM/F80ZcnvEiw7KPdA==
X-Gm-Gg: ATEYQzwHV2C3V7izWNAM7Oc2RhjlovZkIcABcRfeuotVDmc06f2FyRUV+htqRLQ4bg1
	C9DTZKCpo/yeEIOib3onakXeAw+1Uj8j+HZ+a9aMGVFW5b63bZhpyLi+PvW2dUEmr+Sk0yGAKWI
	oGnIf3guMqfKNg9Jb+caTvpHtF33gz3ASLsv1gjgUUvKUtAzcgLQtg75mJoF56k96HgGUR+5L5U
	htDHkKqFi2ROmXPv0CedTZ9GgHXCCOVnqD1wv5bOrYqSm3X0ji+2QhJB91sooIAmt9Zhs6aOZEb
	WuwiPepSxmiUPfAcnl0RXy1tSg+nVonJikVHRHrD7fFqJkxOsOiSYwebcrq+rz0Z5MOiOxrEtOn
	XdZugoirqPGNB/hcwwzHldarHKHxsNG3abfQs52KJoNJGdp43IhlkRU0yOUP/nAaIb5gsVt3/i2
	AenFoTAWVlfDgC5HctLeaJun4BAKyl5sLjkmGnXxvC67tqu0uLaAzcWbGwrcZi/EJ0HUc7gWe4i
	T4rF7d0cwpJc+mYJw==
X-Received: by 2002:a05:690c:e3cc:b0:799:ba1:b950 with SMTP id 00721157ae682-7990ba1b99amr32343447b3.0.1773162697313;
        Tue, 10 Mar 2026 10:11:37 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a51a245sm19745357b3.5.2026.03.10.10.11.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:11:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/6] doc/btmon: Add SMP pairing flow documentation
Date: Tue, 10 Mar 2026 13:11:15 -0400
Message-ID: <20260310171126.342447-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310171126.342447-1-luiz.dentz@gmail.com>
References: <20260310171126.342447-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add comprehensive SMP pairing documentation covering:

- Pairing Phases 1-3: Feature exchange (IO capabilities, auth
  requirements, key distribution), authentication for both Secure
  Connections (public key, DHKey check) and Legacy pairing
  (confirm/random only), and key distribution (IRK, LTK, CSRK).

- Pairing Failure: Failure reason code table (0x01-0x0e) with
  diagnostic meanings for each code.

- Automating Pairing Analysis: grep patterns for identifying pairing
  attempts, detecting SC vs Legacy, finding failures, and correlating
  with encryption.

- Updated Automated Trace Analysis: Added pairing/security check step
  in the recommended workflow, SMP cross-reference in connection
  lifecycle patterns, and pairing failure debugging scenario.
---
 doc/btmon.rst | 280 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 275 insertions(+), 5 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index f769a7af6e8b..bddbd07d3c35 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1129,6 +1129,254 @@ The CCC descriptor at handle 0x000d belongs to the Service Changed
 characteristic (0x000c), because it falls between that value handle
 and the next characteristic declaration at 0x000e.
 
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
+
 EXAMPLES
 ========
 
@@ -1186,17 +1434,23 @@ Recommended Workflow
        grep -n "Disconnect Complete" output.txt
 
    Then examine the lines following each match for the ``Reason:``
-   field.
+   field. See `HCI ERROR AND DISCONNECT REASON CODES`_ for
+   interpretation.
 
-5. **Identify LE Audio**: Search for ASCS and CIS activity::
+5. **Check pairing/security**: Search for SMP activity (see
+   `SMP PAIRING FLOW`_)::
+
+       grep -n "Pairing Request\|Pairing Response\|Pairing Failed\|Encryption Change" output.txt
+
+6. **Identify LE Audio**: Search for ASCS and CIS activity::
 
        grep -n "ASE Control Point\|CIG Parameters\|Create Connected Isochronous\|CIS Established\|Setup ISO Data Path" output.txt
 
-6. **Check for errors**: Search for non-success status codes::
+7. **Check for errors**: Search for non-success status codes::
 
        grep -n "Status:" output.txt | grep -v "Success"
 
-7. **Extract GATT discovery**: Filter the GATT service/characteristic
+8. **Extract GATT discovery**: Filter the GATT service/characteristic
    discovery traffic (see `RECONSTRUCTING A GATT DATABASE FROM SNOOP
    TRACES`_)::
 
@@ -1223,7 +1477,8 @@ pattern in the trace:
 2. ``LE Connection Update Complete`` -- connection parameters changed
    (may occur zero or more times)
 3. ``Encryption Change`` -- link encrypted (may show encryption
-   algorithm)
+   algorithm). See `SMP PAIRING FLOW`_ for the SMP exchange that
+   precedes this.
 4. ACL Data with ATT/SMP/L2CAP -- service discovery and data exchange
 5. ``Disconnect Complete`` -- connection ended, check Reason field
 
@@ -1238,6 +1493,21 @@ For LE Audio connections, additional steps appear between 3 and 5:
 - ``Disconnect Complete`` on CIS handle (stream ended)
 - ``LE Remove CIG`` (group removed)
 
+Common Debugging Scenarios
+---------------------------
+
+**Pairing failure diagnosis**:
+
+1. Find ``Pairing Request`` -- note IO capabilities and auth
+   requirements
+2. Find ``Pairing Response`` -- compare to determine association model
+3. If ``Pairing Failed`` appears, the reason code identifies the
+   failure (see `SMP PAIRING FLOW`_)
+4. If ``Encryption Change`` shows ``Status: Success``, pairing
+   succeeded
+5. If no SMP traffic on reconnect but ``Encryption Change`` fails,
+   the bond was lost on one side
+
 Vendor-Specific Events
 ----------------------
 
-- 
2.53.0

