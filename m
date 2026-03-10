Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D42DCF57
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178414; cv=none; b=LETlkX+2Cyxa/0VdhcgdbEzyx8Qs9ProLAeRWs4YQDXyNalHemRGBsOv0qCoGCAApa47T8386WjrWKcauuNb5rhAPyYsN0V6iGAksq/z0ZwTJwWTtcuPNI9IvJwfAjpcQNjopoXWc2k3o79Rn2iZfNgIPWr28pn0xc44Vpoe6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178414; c=relaxed/simple;
	bh=paQj/6j0OecGNxqkNYd/t97rkxjfQXZjjCA3aFe0e7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcYziWmD5wluV5DuP3KWrftom4VKGMdpt7x3gbZ2XmgCjj31EslCUAR0cCOR8tdIxToq1mOHFyaFJ+k1jXc5rREYPZ7Jgq+zSbKSzkOulOLWxkih9p8qDud9B2Jyf1LoAxrjsU+LJds2G5IS8/+nZ1q9FXdHkG8ZYMjPdgZMcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8wpQQzI; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8wpQQzI"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64c9707fc11so9924341d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178412; x=1773783212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NluXy3O8AyHI7zGaWJ3nld4cJsKhrboKWd+1bvAdUNQ=;
        b=d8wpQQzIvmAHEbSR4Rjr3XGTiAqCozhlW71JUMjqpLXY+OFVPVuv2yx9QBi27fxAnf
         eFW7+gPUeviyoTFNAGMs1bxxDIecGGHEuGcNHZlORcuDANFoqnznDER6yd7HmmEdslPn
         wRQim0J1vjt2tGuUh/4EKeyhgOFQZvDUh3Z3zekBXYYVICn+bcH19qUH4CZKveaa1zDG
         7Yfe2YZA7yuy3BRFD2gR4hQmyiH85JNOpOXmfeOTt92IeChRsQoa/CLlY2c5ZdlXu8Uw
         sqxgrHV2aQP2ET6kdFdJx6JWbR5xZTa3DkSqLSC4b65/pWbVL8ZrjIj2KIV5YFVnWJEz
         8IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178412; x=1773783212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NluXy3O8AyHI7zGaWJ3nld4cJsKhrboKWd+1bvAdUNQ=;
        b=SlP+kKkE2ojzPwYcKbStXC5XzrbhsNfmRhPGYj5RgtVpuGYdE6ElN/PY4SdR8WSoU8
         oMZhIY+KyunhRpx9drP20o0i0+yrbU6sq9Y8UNXFtnuN78EXyWLysDD3UnwZkGu420vs
         luYJlT+fuaQgozUHxiKqpi0ZXFD67avGEMmW5ZhPdrV4gSGvTFo6uzkdFKz+D0Sv7szT
         og6etZ5HNTSHEoTIdaujJiaveFFMqWsDIyGMjA/UOMDdJu2nMebH4sdV58oNHOoYz7hX
         zl1qWmmOquoT5yE0fOW0Hf5wbEtPD0Y3udslePMr73vOXL1/ALuNbg9CZ1PSDJ9A9jJb
         1n8A==
X-Gm-Message-State: AOJu0YwzQRmsqYhLrOkDbhtF0Eq2V9nuu06mp+ubp7cEq6HOPJ4MIP9D
	51OdIbC779nv5r3+zV6lJPhxsjd9LpqdC7efk+TtKT5VstjbwOIEILHVSq0plLyD
X-Gm-Gg: ATEYQzxSRO2qh1MQxipDb8fn16hp4Q+Yb4VlzWXng7NlEAMx0IOpaamMRUd7W51IYUI
	qDRSCy5jljhNpAwLSdrV3EgvCZ1F5yZpPZI8hYm/Anyc6ZMob78TUiOvaPCEO0sHjICVxhU2g1Q
	vH2P23hE3lnbK9v7EKRdmIHWIUuH0yfSwOyBuEVbKVXays3DD5QEZ4txPqG+R/YFA89IGRxqQeX
	+WbFIuqsb3PeFvbZkE5CCXa86Lp/lxhF0gzFcW4WTdoyArPQmd0P91yNfDxJDMmvKegxdUxpvoZ
	aRqb6UYl0dCINPLMKL5IMVOFMZUOlNXPLs8qagT7u1mqS2LRrvWHn8X18UzCpdq8erfI5fhTeiY
	7FYZ5vM/AZOdLHbCGUroNk2AGmxpcGgW61wkmEL0XXqtPAewoIEPo3zvKwd5APprlaMwS+dADdp
	yT8UkGNJR4mwZgEVuYxgSEIJ8mBYfFALt3NEIqqlS5uMB9QGQdVAyPV88CE36kHZr7lqjjtuqBs
	/WGwJfUogVAfXIHFw==
X-Received: by 2002:a05:690c:306:b0:794:e167:b4c0 with SMTP id 00721157ae682-79917fe9eadmr1990987b3.52.1773178411853;
        Tue, 10 Mar 2026 14:33:31 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1ecd9sm952777b3.45.2026.03.10.14.33.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:33:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/7] doc/btmon: Add BIG Sync flow documentation
Date: Tue, 10 Mar 2026 17:33:13 -0400
Message-ID: <20260310213314.729718-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310213314.729718-1-luiz.dentz@gmail.com>
References: <20260310213314.729718-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add comprehensive BIG Sync receiver flow documentation covering:
- Complete prerequisite chain (PA sync -> PA Reports -> BIG Info ->
  BIG Create Sync -> BIG Sync Established -> ISO Data Path -> ISO Data)
- BIG Info Advertising Report as the critical gate for BIG sync
- Without PAST (direct PA sync) flow with btmon output examples
- With PAST (Periodic Advertising Sync Transfer) flow via BASS
- BIG Sync teardown paths (receiver and broadcaster initiated)
- BIG Sync failure diagnosis checklist
- Updated broadcast grep patterns in Automating LE Audio Analysis
- Separate unicast (CIS) and broadcast (BIG) diagnosis patterns

The BIG Info documentation addresses a gap where trace analysis missed
that no BIG Info was received and therefore no BIG Create Sync could
be sent.
---
 doc/btmon.rst | 343 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 342 insertions(+), 1 deletion(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 0d9bbfb177b5..2299c13ca16c 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1835,6 +1835,315 @@ instead of CIS. The setup involves periodic advertising with BASE
           BIS: 0x01
           BIS: 0x02
 
+BIG Sync Receiver Flow
+~~~~~~~~~~~~~~~~~~~~~~
+
+A receiver must complete a specific sequence of steps before it can
+receive broadcast audio. The critical prerequisite chain is:
+
+1. **Synchronize to periodic advertising** -- the receiver must first
+   discover and sync to the broadcaster's periodic advertising train.
+2. **Receive PA Reports with BASE** -- the periodic advertising data
+   contains the BASE (Broadcast Audio Source Endpoint) structure
+   describing the broadcast's codec configuration.
+3. **Receive BIG Info Advertising Report** -- this event tells the
+   receiver that a BIG exists on the periodic advertising train and
+   provides its parameters (number of BIS, encryption, SDU interval,
+   etc.). **This is the critical gate**: without receiving BIG Info,
+   the receiver cannot issue ``LE BIG Create Sync``.
+4. **Issue LE BIG Create Sync** -- using the sync handle from step 1
+   and parameters from step 3.
+5. **Receive BIG Sync Established** -- the controller confirms sync
+   with BIS connection handles.
+6. **Setup ISO Data Path** -- configure the data path for each BIS.
+7. **ISO Data flows** -- broadcast audio packets arrive.
+
+If any step fails or is missing, the subsequent steps cannot proceed.
+The most common failure pattern is that **BIG Info is never received**
+(e.g., the periodic advertising data does not contain a BIG, or PA
+sync was lost before BIG Info arrived), which means ``LE BIG Create
+Sync`` is never sent.
+
+Without PAST (Direct PA Sync)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When the receiver scans for and syncs to periodic advertising
+directly (without assistance from a Broadcast Assistant):
+
+**Step 1 -- Create PA sync**::
+
+    < HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14  #100 [hci0] 0.100003
+          Options: 0x0000
+          SID: 0x01
+          Adv Address Type: Public (0x00)
+          Adv Address: XX:XX:XX:XX:XX:XX
+          Skip: 0x0000
+          Sync Timeout: 2000 msec (0x00c8)
+          Sync CTE Type: 0x0000
+
+**Step 2 -- PA Sync Established** (sync handle assigned)::
+
+    > HCI Event: LE Meta Event (0x3e) plen 16                 #105 [hci0] 0.150003
+          LE Periodic Advertising Sync Established (0x0e)
+            Status: Success (0x00)
+            Sync Handle: 0x0001
+            Advertising SID: 0x01
+            Advertiser Address Type: Public (0x00)
+            Advertiser Address: XX:XX:XX:XX:XX:XX
+            Advertiser PHY: LE 2M PHY (0x02)
+            Periodic Advertising Interval: 10.000 msec (0x0008)
+            Advertiser Clock Accuracy: 0x05
+
+**Step 3 -- PA Reports** (contain BASE data)::
+
+    > HCI Event: LE Meta Event (0x3e) plen 80                 #110 [hci0] 0.200003
+          LE Periodic Advertising Report (0x0f)
+            Sync Handle: 0x0001
+            ...
+            Service Data: Basic Audio Announcement (0x1851)
+
+**Step 4 -- BIG Info Advertising Report** (critical gate)::
+
+    > HCI Event: LE Meta Event (0x3e) plen 24                 #120 [hci0] 0.300003
+          LE BIG Info Advertising Report (0x22)
+            Sync Handle: 0x0001
+            Number BIS: 2
+            NSE: 4
+            ISO Interval: 10.000 msec (0x0008)
+            BN: 2
+            PTO: 1
+            IRC: 2
+            Maximum PDU: 120
+            SDU Interval: 10000 us
+            Maximum SDU: 120
+            PHY: LE 2M PHY (0x02)
+            Framing: Unframed (0x00)
+            Encryption: 0x00
+
+This event is generated by the controller each time it receives a
+periodic advertising packet that contains BIG Info. It provides all
+parameters the receiver needs to decide whether to sync to the BIG.
+Key fields:
+
+- ``Number BIS`` -- how many BIS streams are available.
+- ``SDU Interval`` and ``Maximum SDU`` -- audio frame timing and size.
+- ``Encryption`` -- whether a Broadcast Code is required (0x01) or
+  not (0x00). If encrypted, the receiver must supply the correct
+  Broadcast Code in ``LE BIG Create Sync``.
+- ``Sync Handle`` -- must match a currently active PA sync.
+
+**Step 5 -- BIG Create Sync** (using sync handle + BIG Info)::
+
+    < HCI Command: LE BIG Create Sync (0x08|0x006b) plen 15  #130 [hci0] 0.400003
+          BIG Handle: 0x00
+          BIG Sync Handle: 0x0001
+          Encryption: Unencrypted (0x00)
+          Broadcast Code: 00000000000000000000000000000000
+          Maximum Number Subevents: 0x00
+          Timeout: 2000 ms (0x00c8)
+          Number of BIS: 2
+          BIS: 0x01
+          BIS: 0x02
+
+**Step 6 -- BIG Sync Established**::
+
+    > HCI Event: LE Meta Event (0x3e) plen 20                 #135 [hci0] 0.450003
+          LE BIG Sync Established (0x1d)
+            Status: Success (0x00)
+            BIG Handle: 0x00
+            Transport Latency: 10000 us
+            NSE: 4
+            BN: 2
+            PTO: 1
+            IRC: 2
+            Maximum PDU: 120
+            ISO Interval: 10.000 msec (0x0008)
+            Connection Handle: 0x0010
+            Connection Handle: 0x0011
+
+On success, the controller assigns BIS connection handles (0x0010,
+0x0011 above). A non-zero Status indicates failure -- common errors:
+
+- ``0x3e`` (Connection Failed to be Established) -- BIG parameters
+  do not match or the BIG is no longer present.
+- ``0x3f`` (Limit Reached) -- controller resources exhausted.
+
+**Step 7 -- Setup ISO Data Path** (for each BIS)::
+
+    < HCI Command: LE Setup ISO Data Path (0x08|0x006e) plen 13  #140 [hci0] 0.500003
+          Connection Handle: 0x0010
+          Data Path Direction: Output (Host to Controller) (0x01)
+          Data Path ID: HCI (0x00)
+
+    < HCI Command: LE Setup ISO Data Path (0x08|0x006e) plen 13  #145 [hci0] 0.550003
+          Connection Handle: 0x0011
+          Data Path Direction: Output (Host to Controller) (0x01)
+          Data Path ID: HCI (0x00)
+
+**Step 8 -- ISO Data flows** on BIS handles::
+
+    > ISO Data: Handle 0x0010 flags 0x02 dlen 124             #150 [hci0] 0.600003
+    > ISO Data: Handle 0x0011 flags 0x02 dlen 124             #151 [hci0] 0.600003
+
+With PAST (Periodic Advertising Sync Transfer)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When a Broadcast Assistant (e.g., a phone) helps a Scan Delegator
+(e.g., a hearing aid) sync to a broadcast, it can transfer the PA
+sync via PAST over an existing ACL connection. This avoids the
+delegator having to scan for and sync to the PA train itself.
+
+The BASS (Broadcast Audio Scan Service) protocol coordinates this:
+
+1. The assistant writes an **Add Source** operation to the delegator's
+   BASS control point with ``PA Sync`` set to ``0x01``
+   (Synchronize via PAST).
+2. The delegator prepares to receive the transfer by setting PAST
+   parameters.
+3. The assistant transfers its PA sync to the delegator.
+4. The delegator receives the PAST event with a sync handle.
+5. From here, the flow continues as in the non-PAST case (PA Reports
+   → BIG Info → BIG Create Sync → etc.).
+
+**BASS Add Source** (assistant writes to delegator, seen in ATT)::
+
+    < ACL Data TX: Handle 64 flags 0x00 dlen 27               #300 [hci0] 1.000003
+          ATT: Write Command (0x52) len 22
+            Handle: 0x0025
+              Data: 04...
+              Opcode: Add Source (0x04)
+                Advertiser Address Type: Public (0x00)
+                Advertiser Address: XX:XX:XX:XX:XX:XX
+                Advertising SID: 0x01
+                PA Sync: Synchronize to PA - PAST (0x01)
+                PA Interval: 0x0008
+                Number of Subgroups: 1
+                  BIS Sync: 0x00000003
+                  Metadata Length: 0
+
+PA Sync values in the Add Source operation:
+
+- ``0x00`` -- Do not synchronize to PA
+- ``0x01`` -- Synchronize to PA, PAST available
+- ``0x02`` -- Synchronize to PA, PAST not available (delegator
+  must scan and sync directly)
+
+**PAST Parameters** (delegator prepares to receive transfer)::
+
+    < HCI Command: LE Periodic Advertising Sync Transfer Parameters (0x08|0x005c) plen 8  #310 [hci0] 1.100003
+          Connection handle: 64
+          Mode: Enabled with report events enabled (0x02)
+          Skip: 0x00
+          Sync timeout: 2000 msec (0x00c8)
+          Sync CTE Type: 0x0000
+
+**PAST Transfer** (assistant sends its PA sync)::
+
+    < HCI Command: LE Periodic Advertising Sync Transfer (0x08|0x005a) plen 6  #320 [hci0] 1.200003
+          Connection handle: 64
+          Service data: 0x0001
+          Sync handle: 1
+
+**PAST Received** (delegator gets the sync handle)::
+
+    > HCI Event: LE Meta Event (0x3e) plen 19                 #325 [hci0] 1.250003
+          LE Periodic Advertising Sync Transfer Received (0x18)
+            Status: Success (0x00)
+            Handle: 64
+            Connection handle: 64
+            Service data: 0x0001
+            Sync handle: 1
+            SID: 0x01
+            Address type: Public (0x00)
+            Address: XX:XX:XX:XX:XX:XX
+            PHY: LE 2M PHY (0x02)
+            Periodic advertising Interval: 10.000
+            Clock Accuracy: 0x05
+
+On success, the delegator now has a PA sync (``Sync handle: 1``) and
+will begin receiving PA Reports and BIG Info events, continuing from
+step 3 of the non-PAST flow above.
+
+.. note::
+
+   **Race condition**: The PAST Parameters command must be sent
+   **before** the assistant sends the PAST Transfer. In BlueZ, the
+   PA sync state in BASS is set after probing completes to avoid
+   the remote sending PAST before the kernel has enabled PAST
+   Parameters on the HCI level.
+
+BIG Sync Teardown
+^^^^^^^^^^^^^^^^^
+
+**Receiver-initiated teardown** -- the receiver terminates its BIG
+sync::
+
+    < HCI Command: LE BIG Terminate Sync (0x08|0x006c) plen 1  #500 [hci0] 5.000003
+          BIG Handle: 0x00
+
+    > HCI Event: Command Complete (0x0e) plen 5               #501 [hci0] 5.001003
+          LE BIG Terminate Sync (0x08|0x006c) ncmd 1
+            Status: Success (0x00)
+            BIG Handle: 0x00
+
+**Broadcaster-initiated teardown** -- the broadcaster terminates its
+BIG, and the receiver gets a BIG Sync Lost event::
+
+    > HCI Event: LE Meta Event (0x3e) plen 2                  #510 [hci0] 6.000003
+          LE BIG Sync Lost (0x1e)
+            BIG Handle: 0x00
+            Reason: Connection Terminated By Local Host (0x16)
+
+The ``Reason`` field indicates why sync was lost:
+
+- ``0x08`` (Connection Timeout) -- BIG packets not received within
+  the sync timeout.
+- ``0x13`` (Remote User Terminated Connection) -- broadcaster stopped
+  the BIG intentionally.
+- ``0x16`` (Connection Terminated By Local Host) -- local controller
+  terminated.
+- ``0x3e`` (Connection Failed to be Established) -- could not
+  establish sync initially.
+
+**Source-side BIG termination** (broadcaster tears down)::
+
+    < HCI Command: LE Terminate BIG (0x08|0x006a) plen 2      #520 [hci0] 7.000003
+          BIG Handle: 0x00
+          Reason: Connection Terminated By Local Host (0x16)
+
+    > HCI Event: LE Meta Event (0x3e) plen 2                  #521 [hci0] 7.001003
+          LE BIG Terminate (0x1c)
+            BIG Handle: 0x00
+            Reason: Connection Terminated By Local Host (0x16)
+
+BIG Sync Failure Diagnosis
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When analyzing a trace where BIG sync fails, check the following in
+order:
+
+1. **Is PA sync established?** -- Look for ``LE Periodic Advertising
+   Sync Established`` with ``Status: Success``. If missing, the
+   receiver never synced to the PA train.
+2. **Are PA Reports arriving?** -- Look for ``LE Periodic Advertising
+   Report`` events. If absent after PA sync, the PA train may have
+   been lost.
+3. **Is BIG Info received?** -- Look for ``LE BIG Info Advertising
+   Report``. **If this event never appears, the BIG does not exist
+   on this PA train**, or the broadcaster has not yet started it.
+   Without BIG Info, ``LE BIG Create Sync`` cannot be sent.
+4. **Is BIG Create Sync sent?** -- If BIG Info was received but
+   ``LE BIG Create Sync`` was never sent, the host-side logic failed
+   to act on the BIG Info (e.g., mismatched codec, encryption
+   mismatch, application-level issue).
+5. **Does BIG Sync Established succeed?** -- Check the ``Status``
+   field. A non-zero status means the controller could not sync to
+   the BIG.
+6. **Is ISO Data Path set up?** -- Look for ``LE Setup ISO Data Path``
+   for each BIS handle from BIG Sync Established.
+7. **Is ISO Data flowing?** -- Look for ``ISO Data`` packets on the
+   BIS handles.
+
 Automating LE Audio Analysis
 ------------------------------
 
@@ -1865,10 +2174,26 @@ Then examine the following line for ``Status:``.
 
 **Detect broadcast audio**::
 
-    grep -n "Basic Audio Announcement\|Create BIG\|BIG Complete\|BIG Create Sync\|BIG Sync" output.txt
+    grep -n "Basic Audio Announcement\|Create BIG\|BIG Complete\|BIG Create Sync\|BIG Sync\|BIG Info\|BIG Terminate\|BIG Sync Lost" output.txt
+
+**Trace BIG Sync receiver flow** -- verify each prerequisite step::
+
+    grep -n "Periodic Advertising Create Sync\|Periodic Advertising Sync Established\|BIG Info Advertising Report\|BIG Create Sync\|BIG Sync Established\|BIG Sync Lost\|BIG Terminate" output.txt
+
+**Detect PAST-based sync** -- check for Periodic Advertising Sync
+Transfer::
+
+    grep -n "Sync Transfer Parameters\|Sync Transfer (0x08\|PAST Received\|PA Sync:.*PAST\|Add Source" output.txt
+
+**Check BIG Info arrival** -- the critical gate for BIG sync. If this
+is absent, the receiver has no BIG to sync to::
+
+    grep -n "BIG Info Advertising Report" output.txt
 
 **Full LE Audio diagnosis pattern**:
 
+*Unicast (CIS) flow:*
+
 1. Find PACS reads -- verify codec compatibility between devices
 2. Find ASE Control Point writes -- trace the Config Codec → Config
    QoS → Enable sequence
@@ -1880,6 +2205,22 @@ Then examine the following line for ``Status:``.
 8. On failure, check ASE Control Point notification responses for
    error codes (Response Code and Response Reason fields)
 
+*Broadcast (BIG) receiver flow:*
+
+1. Find ``Periodic Advertising Create Sync`` or ``PAST Received`` --
+   how did PA sync start?
+2. Find ``Periodic Advertising Sync Established`` or
+   ``PAST Received`` with ``Status: Success`` -- is PA synced?
+3. Find ``Periodic Advertising Report`` with
+   ``Basic Audio Announcement`` -- is BASE data arriving?
+4. Find ``BIG Info Advertising Report`` -- **critical**: does the BIG
+   exist? If missing, the BIG cannot be synced.
+5. Find ``BIG Create Sync`` -- did the host request BIG sync?
+6. Find ``BIG Sync Established`` -- check ``Status`` for success.
+7. Find ``Setup ISO Data Path`` for each BIS handle.
+8. Find ``ISO Data`` on BIS handles -- confirm audio is flowing.
+9. On failure, check for ``BIG Sync Lost`` and examine ``Reason``.
+
 PROTOCOL ERROR CODES
 =====================
 
-- 
2.53.0

