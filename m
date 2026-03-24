Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7D313E36
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381800; cv=none; b=Bvr5Pi3eEK1ufKZFtU+NKePLKT/syKoVY4F5bD9a1WFnWLJ1emxwawQt9IgSvX7VJVRZIoGTxEfueCiG5l9c7nxnxG280+af/o8LoVUXyoFyVdEeXfL1mJkhoSgR5C6mqcKQVJHZ/RK0zr9195iT5Awm6LzxoKjedqryuEw1B7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381800; c=relaxed/simple;
	bh=d907Zebgs0RJ0e9xq2GT209ayjEdvU3hLG3Xnj6nwB8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av5MKosJusnrEXCWJpy1xGspZondKxl/PfMsDPZmbVb0ZtjfIxmoqn1DL6ud98N0ZUrUYWNpNrqCd4BeXbvJMP0U8jo+YqKGbI8EBuPbiZxWnUnVKKKsT9jquKjfzH7++bHkklSbGRlY+zRFlKVitE9PCLF1DDV9QWqiW8FH8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2cAoy82; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2cAoy82"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso857974241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381797; x=1774986597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugmutQn6Y+cg6jMPJEJG2Rb8TRcpT0toxPg0bPVeVjw=;
        b=I2cAoy82FlqT9i7In0Z0nH4tLY7M+wByGkFJJPfQesNLKY6eX0tr8P0GPF6ryRJg0Z
         kKVKK2LpDWVLhOibpuWjD1yvRq3XrDMCK4zkPauNCxKEuq89cqAc+BkW+J2msH0jTcol
         7lI+mp4+5m86hYbEn06PirTJTYemAFP5EI6t1SN48SBhSXG++dhdxN+XN2rwwi+IRnnF
         OaALqL/UJNex3V8Ujd4nZdq9Sr0KU1c5wLlo6989sFcZmYSrId9UzBSzfOx5vdqPeTH1
         j/4vVVfjCfSaGlJrQ6cGVoR/kzXIqgLjkQu91qiYNoyJhQsN6weT9jrkHVsx3LyFUHVY
         wvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381797; x=1774986597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ugmutQn6Y+cg6jMPJEJG2Rb8TRcpT0toxPg0bPVeVjw=;
        b=TPOVCVTWTotc39UaQD37mE9s+TAR/71fY5Hjhk1hooo+uFTEmRjw8It6nkGj8VpwNa
         RyxT3AUHmindaavOlXIpTrgsrPYFcU2VCgCRVgkMcL+AtQFWpyTLPJDPHtJ6Gce+3I3G
         iQumAjlb57cWLkogAaYo5vr/12vc/Ai9wKGJScU4ho81EI4kfIIVLRCJusKPjFzJCLBR
         gNEC0U0yJlIdJG9MVj7DE6gOPssJUweIWhpesnf/J12bvknClospceOCr00Q+IwRg7dp
         ccMsxIJA3DW0chJOk7SsFAqMxVDvVmoQxdFYFSxU0OIM06yLQFk9Z2dRtY065SWaMxIm
         qAlQ==
X-Gm-Message-State: AOJu0YzR2nKUIzmgPP3WIkH8/awF5AzGo+i2eLCqMDAi6YCL2hSwkddJ
	EFctnpFutlMoJ2oAzwj1gn3JAYpTsBTqeYFysF1GGkEcivsevk24YWZqNeOh5E4H
X-Gm-Gg: ATEYQzycwMjbJMQiVgcY6StiltWtDyvnJ+aBBOBRmC/7Dd9pDfn488eJMJyiR24T9kt
	sZovuUCMVAcvkF0PeGR3XcBwvYGZ7ygoJ4WeiizJi4Gbsgt3nI4XvcExYAJP3MfrWsgbIVzit+n
	wtHNDIFfgBxQdEZa2gdIa5BWWLNsJnURL8NPbdLB9N3mwPCVKkgoTUJoCpLWFE1TSgztQRTWRuw
	/PRG3w2AqgTkXsv9sgI7sv8k1xksiyux1kvQSVOd/WCrxl2VuR98qiPulaBkn0H2oJ5fcmxRAUq
	vA2apNzdzQHh5DIYexVGY1G5Wxk8EOxwt7wmfhKWf012FMFYj51O/qGir1myK8/C9h4QvXSEfaW
	giZh766BR15/mg0M8FEpgdc7fNceQP1XfxM+d+QtjK+m/nAtAAwc1vSNiYPyDe3zcXjOcosTnnQ
	n6QbC+okRiyM4CTwHdBLI5sJIz5fuuWRwwkgLyrsbUBXLmyNfyruXdWtMDYxCw/V3RhHsjNfKjQ
	zVm0m29t7UumyNAIA==
X-Received: by 2002:a05:6102:41a9:b0:5ff:f4ae:a154 with SMTP id ada2fe7eead31-60387194a9amr603452137.1.1774381796222;
        Tue, 24 Mar 2026 12:49:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de3e33sm13759671241.9.2026.03.24.12.49.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:49:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/9] doc/btmon: Split GATT Database Reconstruction into btmon-gatt.rst
Date: Tue, 24 Mar 2026 15:49:41 -0400
Message-ID: <20260324194946.109349-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324194946.109349-1-luiz.dentz@gmail.com>
References: <20260324194946.109349-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Move the RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES section
into a standalone file and replace it with an RST include directive.
---
 doc/btmon-gatt.rst | 419 ++++++++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst      | 421 +--------------------------------------------
 2 files changed, 422 insertions(+), 418 deletions(-)
 create mode 100644 doc/btmon-gatt.rst

diff --git a/doc/btmon-gatt.rst b/doc/btmon-gatt.rst
new file mode 100644
index 000000000000..a4738b3bb177
--- /dev/null
+++ b/doc/btmon-gatt.rst
@@ -0,0 +1,419 @@
+.. This file is included by btmon.rst.
+
+RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES
+=================================================
+
+A btsnoop trace contains the complete ATT protocol exchange used by
+GATT clients and servers to discover each other's services. By reading
+the discovery requests and responses, it is possible to reconstruct the
+full GATT database of a remote device -- even without access to the
+device itself.
+
+This section explains the GATT discovery procedure and how each ATT
+operation appears in ``btmon`` output.
+
+Overview of GATT Discovery
+---------------------------
+
+GATT discovery is a multi-phase process where a client queries the
+server's attribute database using ATT protocol operations. The phases
+are:
+
+1. **Primary Service Discovery** -- Find all primary services and their
+   handle ranges.
+2. **Secondary Service Discovery** -- Find any secondary (included-only)
+   services.
+3. **Included Service Discovery** -- Find which services include other
+   services.
+4. **Characteristic Discovery** -- Find all characteristics within each
+   service.
+5. **Descriptor Discovery** -- Find all descriptors for each
+   characteristic.
+6. **Characteristic Value Reading** -- Read the values of readable
+   characteristics.
+
+Each phase uses a specific ATT operation and produces a
+request/response pattern in the trace. The client repeats each request
+with advancing handle ranges until the server responds with
+``Attribute Not Found``, indicating the end of that phase.
+
+Phase 1: Primary Service Discovery (Read By Group Type)
+--------------------------------------------------------
+
+The client discovers primary services using ``Read By Group Type
+Request`` with the ``Primary Service`` UUID (0x2800) as the group type.
+
+**Request**::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #516 [hci0] 0.124726
+          ATT: Read By Group Type Request (0x10) len 6
+            Handle range: 0x0001-0xffff
+            Attribute group type: Primary Service (0x2800)
+
+The first request always starts at handle 0x0001 and searches through
+0xffff (the entire handle space).
+
+**Response**::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 42       #523 [hci0] 0.240151
+          ATT: Read By Group Type Response (0x11) len 37
+            Attribute data length: 6
+            Attribute group list: 6 entries
+            Handle range: 0x0001-0x0009
+            UUID: Generic Access Profile (0x1800)
+            Handle range: 0x000a-0x0011
+            UUID: Generic Attribute Profile (0x1801)
+            Handle range: 0x0012-0x0014
+            UUID: Device Information (0x180a)
+            Handle range: 0x0015-0x0039
+            UUID: Generic Telephony Bearer (0x184c)
+            Handle range: 0x003a-0x0059
+            UUID: Generic Media Control (0x1849)
+            Handle range: 0x005a-0x005c
+            UUID: Telephony and Media Audio (0x1855)
+
+Each entry provides:
+
+- **Handle range** -- The start and end handle of the service. All
+  attributes belonging to this service (characteristics, descriptors)
+  have handles within this range.
+- **UUID** -- The service UUID. Standard 16-bit UUIDs are shown with
+  their name (e.g., ``Generic Access Profile``). 128-bit vendor-specific
+  UUIDs appear as full UUID strings.
+
+The client continues by sending another request starting after the last
+handle in the response::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #525 [hci0] 0.240641
+          ATT: Read By Group Type Request (0x10) len 6
+            Handle range: 0x005d-0xffff
+            Attribute group type: Primary Service (0x2800)
+
+This continues until the server responds with ``Attribute Not Found``::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 9        #532 [hci0] 0.360069
+          ATT: Error Response (0x01) len 4
+            Read By Group Type Request (0x10)
+            Handle: 0x005d
+            Error: Attribute Not Found (0x0a)
+
+This error indicates that no more primary services exist beyond handle
+0x005d. The client now has the complete list of primary services.
+
+.. note::
+
+   The ``Attribute data length`` field indicates the size of each entry
+   in the response. A value of 6 means 16-bit UUIDs (2 bytes start
+   handle + 2 bytes end handle + 2 bytes UUID). A value of 20 means
+   128-bit UUIDs (2 + 2 + 16). If the server has both 16-bit and
+   128-bit service UUIDs, they are returned in separate responses
+   because all entries in a single response must have the same length.
+
+Phase 2: Secondary Service Discovery
+--------------------------------------
+
+After primary services, the client may discover secondary services
+using the same ``Read By Group Type Request`` but with the ``Secondary
+Service`` UUID (0x2801)::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #534 [hci0] 0.360752
+          ATT: Read By Group Type Request (0x10) len 6
+            Handle range: 0x0001-0xffff
+            Attribute group type: Secondary Service (0x2801)
+
+If no secondary services exist, the server responds with
+``Attribute Not Found``. Secondary services are not directly accessible
+to clients -- they are only reachable via include references from
+primary services.
+
+Phase 3: Included Service Discovery (Read By Type)
+----------------------------------------------------
+
+To discover which services include other services, the client uses
+``Read By Type Request`` with the ``Include`` UUID (0x2802)::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #540 [hci0] 0.480731
+          ATT: Read By Type Request (0x08) len 6
+            Handle range: 0x0001-0x005c
+            Attribute type: Include (0x2802)
+
+The handle range typically spans the entire discovered database. Each
+include declaration in the response identifies a service that is
+included by the service containing that handle.
+
+Phase 4: Characteristic Discovery (Read By Type)
+--------------------------------------------------
+
+For each service, the client discovers its characteristics using
+``Read By Type Request`` with the ``Characteristic`` UUID (0x2803).
+The handle range is limited to the service's handle range.
+
+**Request**::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #531 [hci0] 0.360063
+          ATT: Read By Type Request (0x08) len 6
+            Handle range: 0x0008-0x0011
+            Attribute type: Characteristic (0x2803)
+
+**Response**::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 27       #533 [hci0] 0.360714
+          ATT: Read By Type Response (0x09) len 22
+            Attribute data length: 7
+            Attribute data list: 3 entries
+            Handle: 0x0009
+            Value[5]: 200a00052a
+                Properties: 0x20
+                  Indicate (0x20)
+                Value Handle: 0x000a
+                Value UUID: Service Changed (0x2a05)
+            Handle: 0x000c
+            Value[5]: 0a0d00292b
+                Properties: 0x0a
+                  Read (0x02)
+                  Write (0x08)
+                Value Handle: 0x000d
+                Value UUID: Client Supported Features (0x2b29)
+            Handle: 0x000e
+            Value[5]: 020f002a2b
+                Properties: 0x02
+                  Read (0x02)
+                Value Handle: 0x000f
+                Value UUID: Database Hash (0x2b2a)
+
+Each characteristic entry provides:
+
+- **Handle** -- The handle of the characteristic declaration attribute.
+- **Properties** -- A bitmask indicating supported operations:
+
+  .. list-table::
+     :header-rows: 1
+     :widths: 10 30 60
+
+     * - Bit
+       - Property
+       - Description
+     * - 0x01
+       - Broadcast
+       - Can be broadcast in advertising data
+     * - 0x02
+       - Read
+       - Can be read
+     * - 0x04
+       - Write Without Response
+       - Can be written without acknowledgment
+     * - 0x08
+       - Write
+       - Can be written with acknowledgment
+     * - 0x10
+       - Notify
+       - Server can send notifications
+     * - 0x20
+       - Indicate
+       - Server can send indications
+     * - 0x40
+       - Authenticated Signed Writes
+       - Supports signed write commands
+     * - 0x80
+       - Extended Properties
+       - Has extended properties descriptor
+
+- **Value Handle** -- The handle where the characteristic's value is
+  stored (always declaration handle + 1).
+- **Value UUID** -- The UUID identifying the characteristic type.
+
+The client continues with advancing handle ranges until it receives
+``Attribute Not Found``::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 9        #572 [hci0] 1.200228
+          ATT: Error Response (0x01) len 4
+            Read By Type Request (0x08)
+            Handle: 0x005c
+            Error: Attribute Not Found (0x0a)
+
+Phase 5: Descriptor Discovery (Find Information)
+--------------------------------------------------
+
+Descriptors occupy the handles between a characteristic's value handle
+and the next characteristic declaration (or end of service). The client
+discovers them using ``Find Information Request``.
+
+**Request**::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 9        #556 [hci0] 0.959965
+          ATT: Find Information Request (0x04) len 4
+            Handle range: 0x000b-0x000b
+
+The handle range covers the gap between the characteristic value handle
+and the next characteristic declaration handle.
+
+**Response**::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 10       #561 [hci0] 0.961049
+          ATT: Find Information Response (0x05) len 5
+            Format: UUID-16 (0x01)
+            Handle: 0x000b
+            UUID: Client Characteristic Configuration (0x2902)
+
+Common descriptor UUIDs:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 15 40 45
+
+   * - UUID
+     - Name
+     - Purpose
+   * - 0x2900
+     - Characteristic Extended Properties
+     - Additional property bits
+   * - 0x2901
+     - Characteristic User Description
+     - Human-readable description string
+   * - 0x2902
+     - Client Characteristic Configuration (CCC)
+     - Enable/disable notifications or indications
+   * - 0x2903
+     - Server Characteristic Configuration
+     - Server-side broadcast configuration
+   * - 0x2904
+     - Characteristic Presentation Format
+     - Data format, exponent, unit
+
+Phase 6: Reading Characteristic Values
+----------------------------------------
+
+After discovery, the client may read characteristic values using
+``Read Request``::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 7        #577 [hci0] 1.380203
+          ATT: Read Request (0x0a) len 2
+            Handle: 0x000f
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #579 [hci0] 1.380774
+          ATT: Read Response (0x0b) len 16
+            Value[16]: a470d508da8751a2a50b79da0250bfda
+
+The ``Handle`` in the request corresponds to a characteristic value
+handle from the discovery phase. btmon shows the raw value bytes; the
+interpretation depends on the characteristic UUID.
+
+Find By Type Value (Targeted Service Search)
+----------------------------------------------
+
+In addition to discovering all services, a client can search for a
+specific service UUID using ``Find By Type Value Request``::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 13       #513 [hci0] 0.124195
+          ATT: Find By Type Value Request (0x06) len 8
+            Handle range: 0x0001-0xffff
+            Attribute type: Primary Service (0x2800)
+              UUID: Generic Attribute Profile (0x1801)
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 9        #515 [hci0] 0.124684
+          ATT: Find By Type Value Response (0x07) len 4
+            Handle range: 0x0008-0x0011
+
+This returns only the handle range for the matching service, without
+iterating through all services. If the service is not found::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 9        #524 [hci0] 0.240607
+          ATT: Error Response (0x01) len 4
+            Find By Type Value Request (0x06)
+            Handle: 0x0012
+            Error: Attribute Not Found (0x0a)
+
+Bidirectional Discovery
+------------------------
+
+Both devices in a connection can act as GATT client and server
+simultaneously. In a btsnoop trace, you may see interleaved discovery
+in both directions:
+
+- **TX (``<``) requests + RX (``>``) responses** -- The local device
+  (whose trace this is) is acting as a GATT client, discovering the
+  remote device's services.
+- **RX (``>``) requests + TX (``<``) responses** -- The remote device
+  is acting as a GATT client, discovering the local device's services.
+
+For example, the local server responding to the remote's discovery::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #584 [hci0] 1.512006
+          ATT: Read By Group Type Request (0x10) len 6
+            Handle range: 0x0001-0xffff
+            Attribute group type: Primary Service (0x2800)
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 66       #586 [hci0] 1.518778
+          ATT: Read By Group Type Response (0x11) len 61
+            Attribute data length: 6
+            Attribute group list: 10 entries
+            Handle range: 0x0001-0x0007
+            UUID: Generic Access Profile (0x1800)
+            Handle range: 0x0008-0x0011
+            UUID: Generic Attribute Profile (0x1801)
+            Handle range: 0x0012-0x0014
+            UUID: Device Information (0x180a)
+            Handle range: 0x0015-0x001e
+            UUID: Coordinated Set Identification (0x1846)
+            Handle range: 0x001f-0x0020
+            UUID: Common Audio (0x1853)
+            Handle range: 0x0021-0x0024
+            UUID: Microphone Control (0x184d)
+            Handle range: 0x0041-0x004b
+            UUID: Volume Control (0x1844)
+            Handle range: 0x006b-0x0073
+            UUID: Broadcast Audio Scan (0x184f)
+            Handle range: 0x0074-0x0086
+            UUID: Published Audio Capabilities (0x1850)
+            Handle range: 0x0087-0x0096
+            UUID: Audio Stream Control (0x184e)
+
+This shows the local device's own GATT database as seen by the remote.
+To reconstruct the remote device's database, focus on the TX requests
+and RX responses (the local device acting as client).
+
+Building the Attribute Table
+-----------------------------
+
+To reconstruct the GATT database, extract the discovery responses and
+organize them into a table. Using the trace above as an example, the
+remote device at address 00:11:22:33:44:55 has:
+
+**Services** (from Read By Group Type Response)::
+
+    Handle Range    UUID                            Service Name
+    ──────────────  ──────────────────────────────  ────────────────────────────
+    0x0001-0x0009   0x1800                          Generic Access Profile
+    0x000a-0x0011   0x1801                          Generic Attribute Profile
+    0x0012-0x0014   0x180a                          Device Information
+    0x0015-0x0039   0x184c                          Generic Telephony Bearer
+    0x003a-0x0059   0x1849                          Generic Media Control
+    0x005a-0x005c   0x1855                          Telephony and Media Audio
+
+**Characteristics** (from Read By Type Response, within GAP 0x0001-0x0009)::
+
+    Handle  Value Handle  Properties  UUID    Name
+    ──────  ────────────  ──────────  ──────  ────────────────────────────────
+    0x0002  0x0003        Read        0x2a00  Device Name
+    0x0004  0x0005        Read        0x2a01  Appearance
+    0x0006  0x0007        Read        0x2a04  Peripheral Preferred Conn Params
+    0x0008  0x0009        Read        0x2aa6  Central Address Resolution
+
+**Characteristics** (within GATT 0x000a-0x0011)::
+
+    Handle  Value Handle  Properties       UUID    Name
+    ──────  ────────────  ───────────────  ──────  ────────────────────────────
+    0x000b  0x000c        Indicate         0x2a05  Service Changed
+    0x000e  0x000f        Read, Write      0x2b29  Client Supported Features
+    0x0010  0x0011        Read             0x2b2a  Database Hash
+
+**Descriptors** (from Find Information Response)::
+
+    Handle  UUID    Name
+    ──────  ──────  ────────────────────────────────────
+    0x000d  0x2902  Client Characteristic Configuration
+
+The CCC descriptor at handle 0x000d belongs to the Service Changed
+characteristic (0x000c), because it falls between that value handle
+and the next characteristic declaration at 0x000e.
+
diff --git a/doc/btmon.rst b/doc/btmon.rst
index a9b08bdfab01..c2309fc30389 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -710,424 +710,7 @@ Analyze mode reports, for each controller found in the trace:
   connection, the same packet/latency/size statistics.
 
 - **Latency plots**: If ``gnuplot`` is installed, ASCII-art latency
-  distribution plots are rendered in the terminal.
-
-RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES
-=================================================
-
-A btsnoop trace contains the complete ATT protocol exchange used by
-GATT clients and servers to discover each other's services. By reading
-the discovery requests and responses, it is possible to reconstruct the
-full GATT database of a remote device -- even without access to the
-device itself.
-
-This section explains the GATT discovery procedure and how each ATT
-operation appears in ``btmon`` output.
-
-Overview of GATT Discovery
----------------------------
-
-GATT discovery is a multi-phase process where a client queries the
-server's attribute database using ATT protocol operations. The phases
-are:
-
-1. **Primary Service Discovery** -- Find all primary services and their
-   handle ranges.
-2. **Secondary Service Discovery** -- Find any secondary (included-only)
-   services.
-3. **Included Service Discovery** -- Find which services include other
-   services.
-4. **Characteristic Discovery** -- Find all characteristics within each
-   service.
-5. **Descriptor Discovery** -- Find all descriptors for each
-   characteristic.
-6. **Characteristic Value Reading** -- Read the values of readable
-   characteristics.
-
-Each phase uses a specific ATT operation and produces a
-request/response pattern in the trace. The client repeats each request
-with advancing handle ranges until the server responds with
-``Attribute Not Found``, indicating the end of that phase.
-
-Phase 1: Primary Service Discovery (Read By Group Type)
---------------------------------------------------------
-
-The client discovers primary services using ``Read By Group Type
-Request`` with the ``Primary Service`` UUID (0x2800) as the group type.
-
-**Request**::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #516 [hci0] 0.124726
-          ATT: Read By Group Type Request (0x10) len 6
-            Handle range: 0x0001-0xffff
-            Attribute group type: Primary Service (0x2800)
-
-The first request always starts at handle 0x0001 and searches through
-0xffff (the entire handle space).
-
-**Response**::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 42       #523 [hci0] 0.240151
-          ATT: Read By Group Type Response (0x11) len 37
-            Attribute data length: 6
-            Attribute group list: 6 entries
-            Handle range: 0x0001-0x0009
-            UUID: Generic Access Profile (0x1800)
-            Handle range: 0x000a-0x0011
-            UUID: Generic Attribute Profile (0x1801)
-            Handle range: 0x0012-0x0014
-            UUID: Device Information (0x180a)
-            Handle range: 0x0015-0x0039
-            UUID: Generic Telephony Bearer (0x184c)
-            Handle range: 0x003a-0x0059
-            UUID: Generic Media Control (0x1849)
-            Handle range: 0x005a-0x005c
-            UUID: Telephony and Media Audio (0x1855)
-
-Each entry provides:
-
-- **Handle range** -- The start and end handle of the service. All
-  attributes belonging to this service (characteristics, descriptors)
-  have handles within this range.
-- **UUID** -- The service UUID. Standard 16-bit UUIDs are shown with
-  their name (e.g., ``Generic Access Profile``). 128-bit vendor-specific
-  UUIDs appear as full UUID strings.
-
-The client continues by sending another request starting after the last
-handle in the response::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #525 [hci0] 0.240641
-          ATT: Read By Group Type Request (0x10) len 6
-            Handle range: 0x005d-0xffff
-            Attribute group type: Primary Service (0x2800)
-
-This continues until the server responds with ``Attribute Not Found``::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 9        #532 [hci0] 0.360069
-          ATT: Error Response (0x01) len 4
-            Read By Group Type Request (0x10)
-            Handle: 0x005d
-            Error: Attribute Not Found (0x0a)
-
-This error indicates that no more primary services exist beyond handle
-0x005d. The client now has the complete list of primary services.
-
-.. note::
-
-   The ``Attribute data length`` field indicates the size of each entry
-   in the response. A value of 6 means 16-bit UUIDs (2 bytes start
-   handle + 2 bytes end handle + 2 bytes UUID). A value of 20 means
-   128-bit UUIDs (2 + 2 + 16). If the server has both 16-bit and
-   128-bit service UUIDs, they are returned in separate responses
-   because all entries in a single response must have the same length.
-
-Phase 2: Secondary Service Discovery
---------------------------------------
-
-After primary services, the client may discover secondary services
-using the same ``Read By Group Type Request`` but with the ``Secondary
-Service`` UUID (0x2801)::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #534 [hci0] 0.360752
-          ATT: Read By Group Type Request (0x10) len 6
-            Handle range: 0x0001-0xffff
-            Attribute group type: Secondary Service (0x2801)
-
-If no secondary services exist, the server responds with
-``Attribute Not Found``. Secondary services are not directly accessible
-to clients -- they are only reachable via include references from
-primary services.
-
-Phase 3: Included Service Discovery (Read By Type)
-----------------------------------------------------
-
-To discover which services include other services, the client uses
-``Read By Type Request`` with the ``Include`` UUID (0x2802)::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 11       #540 [hci0] 0.480731
-          ATT: Read By Type Request (0x08) len 6
-            Handle range: 0x0001-0x005c
-            Attribute type: Include (0x2802)
-
-The handle range typically spans the entire discovered database. Each
-include declaration in the response identifies a service that is
-included by the service containing that handle.
-
-Phase 4: Characteristic Discovery (Read By Type)
---------------------------------------------------
-
-For each service, the client discovers its characteristics using
-``Read By Type Request`` with the ``Characteristic`` UUID (0x2803).
-The handle range is limited to the service's handle range.
-
-**Request**::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #531 [hci0] 0.360063
-          ATT: Read By Type Request (0x08) len 6
-            Handle range: 0x0008-0x0011
-            Attribute type: Characteristic (0x2803)
-
-**Response**::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 27       #533 [hci0] 0.360714
-          ATT: Read By Type Response (0x09) len 22
-            Attribute data length: 7
-            Attribute data list: 3 entries
-            Handle: 0x0009
-            Value[5]: 200a00052a
-                Properties: 0x20
-                  Indicate (0x20)
-                Value Handle: 0x000a
-                Value UUID: Service Changed (0x2a05)
-            Handle: 0x000c
-            Value[5]: 0a0d00292b
-                Properties: 0x0a
-                  Read (0x02)
-                  Write (0x08)
-                Value Handle: 0x000d
-                Value UUID: Client Supported Features (0x2b29)
-            Handle: 0x000e
-            Value[5]: 020f002a2b
-                Properties: 0x02
-                  Read (0x02)
-                Value Handle: 0x000f
-                Value UUID: Database Hash (0x2b2a)
-
-Each characteristic entry provides:
-
-- **Handle** -- The handle of the characteristic declaration attribute.
-- **Properties** -- A bitmask indicating supported operations:
-
-  .. list-table::
-     :header-rows: 1
-     :widths: 10 30 60
-
-     * - Bit
-       - Property
-       - Description
-     * - 0x01
-       - Broadcast
-       - Can be broadcast in advertising data
-     * - 0x02
-       - Read
-       - Can be read
-     * - 0x04
-       - Write Without Response
-       - Can be written without acknowledgment
-     * - 0x08
-       - Write
-       - Can be written with acknowledgment
-     * - 0x10
-       - Notify
-       - Server can send notifications
-     * - 0x20
-       - Indicate
-       - Server can send indications
-     * - 0x40
-       - Authenticated Signed Writes
-       - Supports signed write commands
-     * - 0x80
-       - Extended Properties
-       - Has extended properties descriptor
-
-- **Value Handle** -- The handle where the characteristic's value is
-  stored (always declaration handle + 1).
-- **Value UUID** -- The UUID identifying the characteristic type.
-
-The client continues with advancing handle ranges until it receives
-``Attribute Not Found``::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 9        #572 [hci0] 1.200228
-          ATT: Error Response (0x01) len 4
-            Read By Type Request (0x08)
-            Handle: 0x005c
-            Error: Attribute Not Found (0x0a)
-
-Phase 5: Descriptor Discovery (Find Information)
---------------------------------------------------
-
-Descriptors occupy the handles between a characteristic's value handle
-and the next characteristic declaration (or end of service). The client
-discovers them using ``Find Information Request``.
-
-**Request**::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 9        #556 [hci0] 0.959965
-          ATT: Find Information Request (0x04) len 4
-            Handle range: 0x000b-0x000b
-
-The handle range covers the gap between the characteristic value handle
-and the next characteristic declaration handle.
-
-**Response**::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 10       #561 [hci0] 0.961049
-          ATT: Find Information Response (0x05) len 5
-            Format: UUID-16 (0x01)
-            Handle: 0x000b
-            UUID: Client Characteristic Configuration (0x2902)
-
-Common descriptor UUIDs:
-
-.. list-table::
-   :header-rows: 1
-   :widths: 15 40 45
-
-   * - UUID
-     - Name
-     - Purpose
-   * - 0x2900
-     - Characteristic Extended Properties
-     - Additional property bits
-   * - 0x2901
-     - Characteristic User Description
-     - Human-readable description string
-   * - 0x2902
-     - Client Characteristic Configuration (CCC)
-     - Enable/disable notifications or indications
-   * - 0x2903
-     - Server Characteristic Configuration
-     - Server-side broadcast configuration
-   * - 0x2904
-     - Characteristic Presentation Format
-     - Data format, exponent, unit
-
-Phase 6: Reading Characteristic Values
-----------------------------------------
-
-After discovery, the client may read characteristic values using
-``Read Request``::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 7        #577 [hci0] 1.380203
-          ATT: Read Request (0x0a) len 2
-            Handle: 0x000f
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 21       #579 [hci0] 1.380774
-          ATT: Read Response (0x0b) len 16
-            Value[16]: a470d508da8751a2a50b79da0250bfda
-
-The ``Handle`` in the request corresponds to a characteristic value
-handle from the discovery phase. btmon shows the raw value bytes; the
-interpretation depends on the characteristic UUID.
-
-Find By Type Value (Targeted Service Search)
-----------------------------------------------
-
-In addition to discovering all services, a client can search for a
-specific service UUID using ``Find By Type Value Request``::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 13       #513 [hci0] 0.124195
-          ATT: Find By Type Value Request (0x06) len 8
-            Handle range: 0x0001-0xffff
-            Attribute type: Primary Service (0x2800)
-              UUID: Generic Attribute Profile (0x1801)
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 9        #515 [hci0] 0.124684
-          ATT: Find By Type Value Response (0x07) len 4
-            Handle range: 0x0008-0x0011
-
-This returns only the handle range for the matching service, without
-iterating through all services. If the service is not found::
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 9        #524 [hci0] 0.240607
-          ATT: Error Response (0x01) len 4
-            Find By Type Value Request (0x06)
-            Handle: 0x0012
-            Error: Attribute Not Found (0x0a)
-
-Bidirectional Discovery
-------------------------
-
-Both devices in a connection can act as GATT client and server
-simultaneously. In a btsnoop trace, you may see interleaved discovery
-in both directions:
-
-- **TX (``<``) requests + RX (``>``) responses** -- The local device
-  (whose trace this is) is acting as a GATT client, discovering the
-  remote device's services.
-- **RX (``>``) requests + TX (``<``) responses** -- The remote device
-  is acting as a GATT client, discovering the local device's services.
-
-For example, the local server responding to the remote's discovery::
-
-    > ACL Data RX: Handle 2048 flags 0x02 dlen 11       #584 [hci0] 1.512006
-          ATT: Read By Group Type Request (0x10) len 6
-            Handle range: 0x0001-0xffff
-            Attribute group type: Primary Service (0x2800)
-
-    < ACL Data TX: Handle 2048 flags 0x00 dlen 66       #586 [hci0] 1.518778
-          ATT: Read By Group Type Response (0x11) len 61
-            Attribute data length: 6
-            Attribute group list: 10 entries
-            Handle range: 0x0001-0x0007
-            UUID: Generic Access Profile (0x1800)
-            Handle range: 0x0008-0x0011
-            UUID: Generic Attribute Profile (0x1801)
-            Handle range: 0x0012-0x0014
-            UUID: Device Information (0x180a)
-            Handle range: 0x0015-0x001e
-            UUID: Coordinated Set Identification (0x1846)
-            Handle range: 0x001f-0x0020
-            UUID: Common Audio (0x1853)
-            Handle range: 0x0021-0x0024
-            UUID: Microphone Control (0x184d)
-            Handle range: 0x0041-0x004b
-            UUID: Volume Control (0x1844)
-            Handle range: 0x006b-0x0073
-            UUID: Broadcast Audio Scan (0x184f)
-            Handle range: 0x0074-0x0086
-            UUID: Published Audio Capabilities (0x1850)
-            Handle range: 0x0087-0x0096
-            UUID: Audio Stream Control (0x184e)
-
-This shows the local device's own GATT database as seen by the remote.
-To reconstruct the remote device's database, focus on the TX requests
-and RX responses (the local device acting as client).
-
-Building the Attribute Table
------------------------------
-
-To reconstruct the GATT database, extract the discovery responses and
-organize them into a table. Using the trace above as an example, the
-remote device at address 00:11:22:33:44:55 has:
-
-**Services** (from Read By Group Type Response)::
-
-    Handle Range    UUID                            Service Name
-    ──────────────  ──────────────────────────────  ────────────────────────────
-    0x0001-0x0009   0x1800                          Generic Access Profile
-    0x000a-0x0011   0x1801                          Generic Attribute Profile
-    0x0012-0x0014   0x180a                          Device Information
-    0x0015-0x0039   0x184c                          Generic Telephony Bearer
-    0x003a-0x0059   0x1849                          Generic Media Control
-    0x005a-0x005c   0x1855                          Telephony and Media Audio
-
-**Characteristics** (from Read By Type Response, within GAP 0x0001-0x0009)::
-
-    Handle  Value Handle  Properties  UUID    Name
-    ──────  ────────────  ──────────  ──────  ────────────────────────────────
-    0x0002  0x0003        Read        0x2a00  Device Name
-    0x0004  0x0005        Read        0x2a01  Appearance
-    0x0006  0x0007        Read        0x2a04  Peripheral Preferred Conn Params
-    0x0008  0x0009        Read        0x2aa6  Central Address Resolution
-
-**Characteristics** (within GATT 0x000a-0x0011)::
-
-    Handle  Value Handle  Properties       UUID    Name
-    ──────  ────────────  ───────────────  ──────  ────────────────────────────
-    0x000b  0x000c        Indicate         0x2a05  Service Changed
-    0x000e  0x000f        Read, Write      0x2b29  Client Supported Features
-    0x0010  0x0011        Read             0x2b2a  Database Hash
-
-**Descriptors** (from Find Information Response)::
-
-    Handle  UUID    Name
-    ──────  ──────  ────────────────────────────────────
-    0x000d  0x2902  Client Characteristic Configuration
-
-The CCC descriptor at handle 0x000d belongs to the Service Changed
-characteristic (0x000c), because it falls between that value handle
-and the next characteristic declaration at 0x000e.
+   distribution plots are rendered in the terminal.
 
 PROTOCOL ERROR CODES
 =====================
@@ -1313,6 +896,8 @@ Errors often cascade across layers. Common patterns:
 PROTOCOL FLOWS
 ===============
 
+.. include:: btmon-gatt.rst
+
 .. include:: btmon-smp.rst
 
 .. include:: btmon-l2cap.rst
-- 
2.53.0

