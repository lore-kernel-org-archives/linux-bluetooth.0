Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26943C9429
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152598; cv=none; b=slgJKCiI04s5ssjwNmac7gsKDOa+0aUIV4eqXqpmw6oO8q0P3q5wMTbyZUHIWMDmYY37BtvoLVqGmKUNBdltXAVAcSPLssvnKEw91egZa9oUrfgvu9N8Q4CJIoGV84D/QyaOH85h6JXEnnQyQZu5ANaXAhGME93ZRYnvfJgK7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152598; c=relaxed/simple;
	bh=t68ML6fAXjYTtFbiD0J5t2h+PdoFNdOf8/4RRSreHrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTgROtOeX5H7j7f7S0NcjgFXZ35T9pTJ96tsCvuGjqXjpCs1bAre8laATLBIoG655JzowymDt+kjKwcdp88fyZ1wcFKkOVDDbwd4X//hMcudqzZ+xe1kN7QR47R0cPDrTYvfvv4LCdLhdz2Bu5eumtGcjcQL4Tb9dXJMaqMZx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3xrCBhC; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3xrCBhC"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6058a955e04so658556137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775152595; x=1775757395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2c4oYQKUFMKH6EgSNgDg1ydOD1bLcINyeKQDacvbCDg=;
        b=s3xrCBhCwet0mXjtaGesJXD/VnXbzL1y2DSAqbe0MSbdhm/LCQaD6I3GLXaLwWGb5h
         OmVJE5QUiEqm8WVAAEckkW9GvVY8f+FIbWZWKiyAq3v7tHKK/abHkU+o/kZpCtEMqvAK
         X0+4CQbPA0w6WbG7gU+j6ZPD17FUesERuBIA1ieBTReC+7E7KUwpmt48tsXUoNdGuDTM
         LkQn15rFhjyA+eMtBg7n8jp6Jenouvc2GyvI/DDaXz/48ub18C0F/wjoc6lP101yt++7
         GoJ3ZonzznFGCjFFSkDxLbZZcYAhGhfxff37dzwnqvDBJuf2pYUjD4sRLMkaP0VKs4TY
         NhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152595; x=1775757395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2c4oYQKUFMKH6EgSNgDg1ydOD1bLcINyeKQDacvbCDg=;
        b=oT6fz5hk07XYAZ08QdANDmo9hTCuU9Si4sx+d/D4pSCjW37hGT0pzgq4fDYpxNKvUN
         jR1PWMQcSkKMbynXGa7Cj49xuLd2nzsiMJnGdcXzS5B/1c0woBkBjZ/2d/ZJLKU/2Lif
         B20JsYlEf3M+L2Hiuwx36VyS2yDQWPqcKemIOYKN6oPD6ajB13V8f8YOWAy2U0T7BtrC
         pfpvyC5S2Z1+1T85i9RIYBQHqjuyhUBOIYW3blLhXqXDuYXpglG/73/jcs6cDJ+LDzPZ
         UCWmfT8D750DU934ky4/v886sc/4aiy+Ux3j6V8dooxeAo24Oly6EcG5vTo1ivjjgTK+
         avtA==
X-Gm-Message-State: AOJu0YyyhZlx8Cuqj2ayvpx7MYBQz47lYhDdgcqs6y8wz7yqa2dEinQL
	+zb3N69BvGChuUH3FNdU8hBm7fJi+SFWnHjOIibK1O8UXP8rOqinUe9v/Zoqm2Z9
X-Gm-Gg: ATEYQzw43VIzLvwwKx+9T1acjGI/NiI++A64oqMDK/DqiWqyjNNYqPDxuf1qeLziD3l
	iASeegG9XasS0x+9ujNxOC+vW3Qt6pJKPw7IPr5X0VeRbCwsAgMcfKwrwjFoOvWJ0GMmTE2LY3W
	1XfeZ6fZSWGyShSHqlthhRPqTzlmzk9XA1t0IhQD8o/JTwH8SlgblrY7xyrmW/6lk2dVmJ1qM8C
	OLlZFNQn0AtkDWHgBlgkLVgQLjv5aHDjKZnrk5lmrH2cAGWB6f3T0R0PQCBTryp1qidAfaDVat4
	Sw8Y90/orjwDSQZkP6QGiY9dez9pKpzsV3i8ITOADl0lTRKyGcOG9SIqbnBb1S8vq3OyEWBT25H
	FyXmK9zQF9H7deESbqm7Usd4hXpo8KucDH63YsE6EJgGX4qFzmbm7XNxboJHl9X4xzXLpVzSMM7
	dLO5dOoCzDDdTuJIqhIQZSJt0drqEbYmwIqhA4AuGI/cWbIYUAmHI1r5d1yJzP9b2OKJVRV0F62
	xWFg+CzKdSnbAWxVQ==
X-Received: by 2002:a05:6102:26cc:b0:602:8742:1fa with SMTP id ada2fe7eead31-6058a5a2bb2mr1308054137.9.1775152595183;
        Thu, 02 Apr 2026 10:56:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb897b8dsm3858085241.7.2026.04.02.10.56.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:56:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH BlueZ 2/3] doc/btmon: Add RAS/RAP protocol flow to Channel Sounding documentation
Date: Thu,  2 Apr 2026 13:56:21 -0400
Message-ID: <20260402175624.2442647-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402175624.2442647-1-luiz.dentz@gmail.com>
References: <20260402175624.2442647-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add the Ranging Service (RAS) and Ranging Profile (RAP) GATT-level
protocol flow to btmon-cs.rst.  Covers all six RAS characteristics
(Features, Real-time Ranging Data, On-demand Ranging Data, Control
Point, Data Ready, Data Overwritten), the five Control Point opcodes
(Get Ranging Data, ACK, Retrieve Lost Segments, Abort, Set Filter),
the segmented ranging data format with Ranging Header and Subevent
Header decoding, the typical on-demand and real-time data flows,
and common issues.
---
 doc/btmon-cs.rst | 328 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 328 insertions(+)

diff --git a/doc/btmon-cs.rst b/doc/btmon-cs.rst
index b1c0ee5f01e3..76bb372a0c26 100644
--- a/doc/btmon-cs.rst
+++ b/doc/btmon-cs.rst
@@ -654,3 +654,331 @@ Common Issues
   The controller could not compute a valid time measurement for this
   step. Common with weak signals or when the CS Access Address was
   not detected (packet quality = 0x02).
+
+RANGING SERVICE (RAS) / RANGING PROFILE (RAP)
+==============================================
+
+The Ranging Service (RAS) is a GATT service that transfers CS
+measurement data between devices at the application layer. It
+complements the HCI-level CS procedure by providing a standardized
+way to exchange, acknowledge, and retrieve ranging results over ATT.
+The Ranging Profile (RAP) defines how a device discovers and interacts
+with RAS on a remote device.
+
+btmon decodes all RAS characteristics automatically when it sees
+ATT operations on the RAS UUIDs.
+
+RAS Service UUID: ``0x185B``
+
+RAS Characteristics
+--------------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 30 10 20 40
+
+   * - Characteristic
+     - UUID
+     - Properties
+     - Description
+   * - RAS Features
+     - 0x2C14
+     - Read
+     - Bitmask of supported RAS capabilities
+   * - RAS Real-time Ranging Data
+     - 0x2C15
+     - Notify, Indicate
+     - Streaming ranging results as they are produced
+   * - RAS On-demand Ranging Data
+     - 0x2C16
+     - Notify, Indicate
+     - Ranging results retrieved on request
+   * - RAS Control Point
+     - 0x2C17
+     - Write Without Response, Indicate
+     - Command interface for data retrieval and filtering
+   * - RAS Ranging Data Ready
+     - 0x2C18
+     - Read, Notify, Indicate
+     - Signals that a new ranging dataset is available
+   * - RAS Ranging Data Overwritten
+     - 0x2C19
+     - Read, Notify, Indicate
+     - Signals that a stored dataset was overwritten
+
+All characteristics except RAS Features use Client Characteristic
+Configuration (CCC) descriptors to enable notifications/indications.
+The typical GATT attribute layout uses 18 handles total.
+
+RAS Features
+-------------
+
+The RAS Features characteristic is a 4-byte bitmask read by the
+client to discover the server's capabilities::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 11               #200 [hci0]
+          ATT: Read Response (0x0b) len 4
+            Handle: 0x0003
+              Features: 0x0000000f
+                Real-time Ranging Data (0x00000001)
+                Retrieve Lost Ranging Data Segments (0x00000002)
+                Abort Operation (0x00000004)
+                Filter Ranging Data (0x00000008)
+
+Feature bits:
+
+- **Bit 0** -- Real-time Ranging Data: the server can stream results
+  via the Real-time Ranging Data characteristic as CS procedures run.
+- **Bit 1** -- Retrieve Lost Ranging Data Segments: the client can
+  request retransmission of missing data segments.
+- **Bit 2** -- Abort Operation: the client can cancel an in-progress
+  data transfer.
+- **Bit 3** -- Filter Ranging Data: the client can configure which
+  fields are included in ranging data notifications.
+
+RAS Ranging Data Ready
+-----------------------
+
+When a CS procedure completes and results are stored, the server
+notifies the client that data is available for retrieval::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 9                #250 [hci0]
+          ATT: Handle Value Notification (0x1b) len 2
+            Handle: 0x000e
+              Counter: 42
+
+The counter value identifies the specific ranging dataset. The client
+uses this counter in subsequent Control Point commands to request or
+acknowledge the data.
+
+RAS Ranging Data Overwritten
+------------------------------
+
+If the server's buffer is full and older results are discarded, this
+characteristic notifies the client::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 9                #260 [hci0]
+          ATT: Handle Value Notification (0x1b) len 2
+            Handle: 0x0011
+              Overwritten Count: 38
+
+This tells the client that ranging data with counter value 38 (and
+possibly earlier) has been overwritten and can no longer be retrieved.
+
+RAS Control Point
+------------------
+
+The RAS Control Point is the command interface for managing ranging
+data transfers. The client writes commands, and the server responds
+via indications on the same characteristic.
+
+**Opcodes:**
+
+.. list-table::
+   :header-rows: 1
+   :widths: 10 35 55
+
+   * - Opcode
+     - Command
+     - Description
+   * - 0x00
+     - Get Ranging Data
+     - Request on-demand transfer of a specific dataset
+   * - 0x01
+     - ACK Ranging Data
+     - Acknowledge receipt of a dataset
+   * - 0x02
+     - Retrieve Lost Ranging Data Segments
+     - Re-request specific missing segments
+   * - 0x03
+     - Abort Operation
+     - Cancel an in-progress data transfer
+   * - 0x04
+     - Set Filter
+     - Configure which data fields are included
+
+**Get Ranging Data** -- requests transfer of a stored dataset::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 10               #270 [hci0]
+          ATT: Write Command (0x52) len 3
+            Handle: 0x000b
+              Opcode: Get Ranging Data (0x00)
+              Ranging Counter: 0x002a
+
+After this command, the server sends the data as a sequence of
+notifications on the On-demand Ranging Data characteristic (0x2C16).
+
+**ACK Ranging Data** -- confirms the client received a complete
+dataset, allowing the server to free the buffer::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 10               #290 [hci0]
+          ATT: Write Command (0x52) len 3
+            Handle: 0x000b
+              Opcode: ACK Ranging Data (0x01)
+              Ranging Counter: 0x002a
+
+**Retrieve Lost Ranging Data Segments** -- requests retransmission
+of specific segments that were missed or corrupted::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 12               #295 [hci0]
+          ATT: Write Command (0x52) len 5
+            Handle: 0x000b
+              Opcode: Retrieve Lost Ranging Data Segments (0x02)
+              Ranging Counter: 0x002a
+              First Segment Index: 3
+              Last Segment Index: 5
+
+A Last Segment Index of ``0xFF`` means "all remaining segments from
+the first index onward."
+
+**Abort Operation** -- cancels any in-progress data transfer::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 8                #298 [hci0]
+          ATT: Write Command (0x52) len 1
+            Handle: 0x000b
+              Opcode: Abort Operation (0x03)
+
+**Set Filter** -- configures which fields to include in ranging
+data notifications::
+
+    < ACL Data TX: Handle 2048 flags 0x00 dlen 10               #265 [hci0]
+          ATT: Write Command (0x52) len 3
+            Handle: 0x000b
+              Opcode: Set Filter (0x04)
+              Filter Configuration: 0x0001
+                Mode: 1
+                Filter Bit Mask: 0x0000
+
+The filter configuration is a 16-bit value: bits [1:0] select the
+filter mode, and bits [15:2] provide a field bitmask.
+
+Ranging Data Format
+--------------------
+
+Both Real-time (0x2C15) and On-demand (0x2C16) Ranging Data
+characteristics use the same segmented data format. Large datasets
+are split across multiple ATT notifications.
+
+**Segmentation Header** (1 byte, present in every notification)::
+
+    > ACL Data RX: Handle 2048 flags 0x02 dlen 30               #275 [hci0]
+          ATT: Handle Value Notification (0x1b) len 25
+            Handle: 0x0005
+              Segmentation Header: 0x01
+                First Segment: True
+                Last Segment: False
+                Segment Index: 0
+              Ranging Data Body:
+                Ranging Counter: 0x02a
+                Configuration ID: 0
+                Selected TX Power: 12 dBm
+                Antenna Paths Mask: 0x03
+                  Antenna Path 1 (0x01)
+                  Antenna Path 2 (0x02)
+                Subevent #0:
+                  Start ACL Connection Event: 1200
+                  Frequency Compensation: 150 (0.01 ppm)
+                  Ranging Done Status: Partial results (0x1)
+                  Subevent Done Status: All results complete (0x0)
+                  Ranging Abort Reason: No abort (0x0)
+                  Subevent Abort Reason: No abort (0x0)
+                  Reference Power Level: -20 dBm
+                  Number of Steps Reported: 8
+              Remaining Ranging Data Segment: ...
+
+Segmentation header fields:
+
+- **First Segment** (bit 0) -- ``True`` for the first notification of
+  a dataset. Only the first segment contains the Ranging Header.
+- **Last Segment** (bit 1) -- ``True`` for the final notification.
+  When both bits are set, the entire dataset fits in one notification.
+- **Segment Index** (bits [7:2]) -- Sequential index for reassembly.
+
+**Ranging Header** (4 bytes, only in first segment):
+
+- **Ranging Counter** (bits [11:0]) -- Matches the counter from the
+  Data Ready notification; identifies the CS procedure instance.
+- **Configuration ID** (bits [15:12]) -- The CS configuration ID
+  (0--3) used for this measurement.
+- **Selected TX Power** (1 byte, signed) -- Actual transmit power
+  used, in dBm.
+- **Antenna Paths Mask** (1 byte) -- Bitmask indicating which antenna
+  paths have data: bit 0 = path 1, bit 1 = path 2, etc.
+
+**Subevent Header** (per subevent within the ranging data):
+
+- **Start ACL Connection Event** -- The ACL connection event counter
+  at which this CS subevent started.
+- **Frequency Compensation** -- Measured frequency offset in 0.01 ppm
+  units (signed 16-bit).
+- **Ranging Done Status** -- Same codes as HCI subevent results:
+  ``0x0`` = complete, ``0x1`` = partial, ``0xF`` = aborted.
+- **Subevent Done Status** -- ``0x0`` = complete, ``0xF`` = aborted.
+- **Ranging/Subevent Abort Reason** -- Same abort reason codes as HCI:
+  ``0x0`` = no abort, ``0x1`` = host/remote request,
+  ``0x2`` = channel map / no sync, ``0x3`` = scheduling,
+  ``0xF`` = unspecified.
+- **Reference Power Level** -- RSSI reference in dBm (signed).
+- **Number of Steps Reported** -- Count of CS step results that follow.
+
+The step data following the subevent header uses the same mode-specific
+format as HCI CS Subevent Result events (Mode 0--3), described in the
+`CS Step Modes`_ section above.
+
+Continuation segments contain only the Segmentation Header followed
+by raw ranging data bytes that are reassembled with the previous
+segments.
+
+Typical RAS Data Flow
+----------------------
+
+A complete RAS session for on-demand data retrieval::
+
+    1. Client discovers RAS (UUID 0x185B) via GATT primary service discovery
+    2. Client reads RAS Features (0x2C14) to learn capabilities
+    3. Client enables CCC notifications on:
+         - RAS Ranging Data Ready (0x2C18)
+         - RAS Ranging Data Overwritten (0x2C19)
+         - RAS On-demand Ranging Data (0x2C16) or
+           RAS Real-time Ranging Data (0x2C15)
+    4. CS procedure runs (HCI level)
+    5. Server notifies Ranging Data Ready with counter=N
+    6. Client writes Control Point: Get Ranging Data (counter=N)
+    7. Server sends On-demand Ranging Data notifications (segmented)
+    8. Client writes Control Point: ACK Ranging Data (counter=N)
+
+For real-time streaming, step 6 is skipped -- the server pushes
+data on the Real-time Ranging Data characteristic (0x2C15) as each
+CS subevent completes, using the same segmented format.
+
+If segments are lost (e.g., due to ATT MTU limitations or missed
+notifications), the client uses Retrieve Lost Ranging Data Segments
+to request retransmission of specific segment indices.
+
+RAS Common Issues
+------------------
+
+**Features read returns 0x00000000**
+  The server does not support any optional RAS features. Only basic
+  on-demand data retrieval via Control Point is available.
+
+**Ranging Data Ready not received**
+  Check that CCC notifications are enabled on handle 0x2C18. Also
+  verify the CS procedure actually completed -- if the procedure was
+  aborted, no Data Ready notification is sent.
+
+**Segmentation reassembly errors**
+  Verify that Segment Index values are sequential and that the First
+  Segment flag is set on the initial notification. A missing segment
+  triggers the Retrieve Lost Segments mechanism if the server supports
+  it (Features bit 1).
+
+**Data Overwritten before retrieval**
+  The server has limited buffer space. If the client does not retrieve
+  and ACK data promptly, older datasets are overwritten. The Data
+  Overwritten notification indicates the counter value of the lost data.
+
+**Control Point write rejected**
+  The connection must be encrypted. RAS Control Point requires write
+  permission with encryption (``WRITE_ENCRYPT``). Verify that SMP
+  pairing has completed.
-- 
2.53.0

