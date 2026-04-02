Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDC3D47BA
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152599; cv=none; b=tY1mTEBGStwzPo47Fy7SJb1cHqJzb5pWB04pqJ4CYLC04a1gXc4tCCU0ztOF2JybHS7uHlPE9XhXrrOIwcDZnWwcGqAOl+T/VCFXrH0MNHw6nCW3egE4P5XtXTMYD0DjcI5IHpPyYQK/SH8PuZ+z81MKitFnihYedWnnmXgGK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152599; c=relaxed/simple;
	bh=gsyNqMeAVOOGMJ8PLMlFctovv/3h1ab1GPu3ls7BTtA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr+jbVCRaJCYQdvc/MoiKDIwblxohmLqWKOtuH7gokjO/Fj0LzruqFMblCPeZ1WcqGVEXbdC01s95aujRWi2Mvs4JheZitv6PJPlEXWVjmlEm/fWIESYFvZHHS8nMGIz+orYZy1YVLlSHAyEZiytZOmOnwbH+ths5/pAjKPXNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKAohYKt; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKAohYKt"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-953a5defbbdso669174241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775152596; x=1775757396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PG9wyhVe93l7t77a1QVjEcG+6U/jkGLgVvjyeM+a2o=;
        b=iKAohYKt+imqlIRBtrPAwh+eHk/ZYj/UnltTc4ZaLovVSumhl/aIPQ+vR9f3F9pk3x
         Bn7zVIIHf7cVdBqrzBXWVhlUl+EAqylcvjXR16cB97jKgUP+TBV92rkgoU1nBv1jGZqS
         rYcAOvOgkDesNHtRPViyLDfqGhLQA5Lfmq8eUF4Ol8zraRpAoegderKRtckj7wr+66pk
         NGrozSQnVT8B34cSxV8V/EsY2V+ymhhyCBA1Z5FEMXSk+FlHHa4UkrdJiUDpyHuK5u2/
         QF5bss19HJI8XOZee46apuF3Hu3CEst1rroT5WNzCDzt54dqH069yF7+DK4tkhidiiGa
         cdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152596; x=1775757396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9PG9wyhVe93l7t77a1QVjEcG+6U/jkGLgVvjyeM+a2o=;
        b=SOcCrRyMGNR6dOJqDq2rUA5PV+sdfDty53+QsJSUXw9wrGRND4UOQepnWtasYvktbe
         /4WRQ/orTqOFWc9t9EWM3pqzdBNI1prnw15Ez2kKQ/kyL6SSE2ZRxwrpT7dzsES3y65v
         kP/uNoGnUb/dW2mx4eoWhyjbMfb0V1cNrDl7tymcqu+2xnklaB/XcLGbkjE6SyguuPlA
         RR0EprGb3ajNYME/r64zIajeqw81/lMPuvMOIw0yPsvEhY4V7jbNoKMlrwo2WxTcrwCk
         ezgrPA8SJQopMII5I8LLI1W8hdaFmPKEtGTqhZqGC6o+Vk87O8e6WwXRFEgacr7p0AGN
         n8HA==
X-Gm-Message-State: AOJu0YzbpgJrZO0vmRAXKVX4wbQxukSoYm2hQYWBqSwwQr1LzkYZUd44
	gdYRf6VIalJpdjCkWiyJEqOHKRl6uC9Of7NxVd4+xv1/bjWrPCWtzRdwYLupYbAy
X-Gm-Gg: ATEYQzxeZ4g4OT2ka1ZxKlQzy1qsvA5W1OVz2KpGbSLc0m8K1bp//fB/pMBGz7vXAa5
	vCeKLwSjTP7QPCJj7N1IkBCwgSyohHg/7ZzdCF4XYnF3gfvSuEdhA8zp8NyELmWex46qPQ2Lujd
	XCqRpVIv+4X/uyu2hhQ1qyda2y02EipvnZkm3NVU1R34lSRZEjXvglk0VBUhDjOzYZSArw7fiBy
	rl5H1TCwv7glIBKMk/s1RQpWCQOw9Ar34cOfaPrwI2G6aXiQBMu16UvT8PTe1W+FJ18zQbGg/T3
	5Hncwpf+x1VPv2vUho5BjhYNwqtkaQhbhxvJ/pa6hx4mEQc6RC5f9mv9qNBVUtxd4w8VIccJNwK
	HFwT3vALRBlkeQXpeytFz+GgOV/0r853lASkLxjA5Q4O8KathlknyvTpn65JNyL8kI5HTtHluOG
	coXREWvQT+PBisLTJbT196B9QTAE/9Dnbv1Y6lqTLGUI6YTeNACBd/v5hFfFndrtW6qKzFzjH9z
	x5HeySTY0MSONNtaw==
X-Received: by 2002:a05:6102:54a2:b0:5ff:ea89:449a with SMTP id ada2fe7eead31-6058a87bf7amr1146605137.13.1775152595858;
        Thu, 02 Apr 2026 10:56:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb897b8dsm3858085241.7.2026.04.02.10.56.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:56:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH BlueZ 3/3] doc/btmon: Add CS and RAS state machines and combined flow charts
Date: Thu,  2 Apr 2026 13:56:22 -0400
Message-ID: <20260402175624.2442647-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402175624.2442647-1-luiz.dentz@gmail.com>
References: <20260402175624.2442647-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add three state machine diagrams and four flow charts to btmon-cs.rst:

- CS State Machine: IDLE → CAPABILITIES EXCHANGED → CONFIGURED →
  PARAMETERS SET → PROCEDURE RUNNING → CONFIGURED → IDLE

- RAS Data Transfer State Machine: IDLE → DATA READY →
  TRANSFERRING → COMPLETE → IDLE (with ABORTED and recovery paths)

- Typical CS Setup Sequence: HCI command/event timeline with
  state annotations showing the full capability exchange through
  procedure enable/disable cycle

- Combined HCI + GATT Flow: interleaved three-column chart
  showing HCI CS operations alongside GATT RAS service discovery,
  CCC setup, data ready notification, on-demand retrieval with
  segmented transfers, and ACK

- Real-time Streaming Flow: shows how HCI Subevent Results
  trigger immediate GATT notifications on Real-time Ranging Data

- Lost Segment Recovery Flow: demonstrates the Retrieve Lost
  Segments mechanism with gap detection and retransmission
---
 doc/btmon-cs.rst | 352 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 330 insertions(+), 22 deletions(-)

diff --git a/doc/btmon-cs.rst b/doc/btmon-cs.rst
index 76bb372a0c26..2a7f99557514 100644
--- a/doc/btmon-cs.rst
+++ b/doc/btmon-cs.rst
@@ -549,33 +549,115 @@ High nibble (subevent abort reason):
 - ``0x03`` -- Scheduling conflict or limited resources
 - ``0x0f`` -- Unspecified reason
 
+CS State Machine
+-----------------
+
+A CS configuration transitions through these states on each device.
+The state is not reported explicitly in a single field -- it is
+inferred from the sequence of HCI commands and events::
+
+    ┌──────────┐
+    │   IDLE   │
+    └────┬─────┘
+         │ LE CS Read Local/Remote Supported Capabilities
+         │ LE CS Security Enable Complete
+         │ LE CS Set Default Settings
+         ▼
+    ┌──────────────────┐
+    │ CAPABILITIES     │  Both devices' CS parameters are known.
+    │ EXCHANGED        │  Security is established.
+    └────┬─────────────┘
+         │ LE CS Create Config
+         │ ──► LE CS Config Complete (status=0x00)
+         ▼
+    ┌──────────────────┐
+    │ CONFIGURED       │  Config ID N exists with negotiated params.
+    │ (config_id=N)    │  Can create up to 4 configs simultaneously.
+    └────┬─────────────┘
+         │ LE CS Set Procedure Parameters
+         ▼
+    ┌──────────────────┐
+    │ PARAMETERS SET   │  Scheduling and antenna params are locked.
+    │ (config_id=N)    │
+    └────┬─────────────┘
+         │ LE CS Procedure Enable (enable=1)
+         │ ──► LE CS Procedure Enable Complete (state=1)
+         ▼
+    ┌──────────────────┐
+    │ PROCEDURE        │  Controller is actively measuring.
+    │ RUNNING          │  Subevent Result events stream in.
+    │ (config_id=N)    │
+    └────┬─────────────┘
+         │ LE CS Procedure Enable (enable=0)
+         │ ──► LE CS Procedure Enable Complete (state=0)
+         ▼
+    ┌──────────────────┐
+    │ CONFIGURED       │  Config still exists, can re-enable.
+    │ (config_id=N)    │
+    └────┬─────────────┘
+         │ LE CS Remove Config
+         ▼
+    ┌──────────┐
+    │   IDLE   │
+    └──────────┘
+
+Multiple configurations can coexist. Removing one config does not
+affect others.
+
 Typical CS Setup Sequence
 --------------------------
 
-A complete CS distance measurement session follows this order::
+A complete HCI-only CS distance measurement session follows this
+flow. The left column shows the Host ──► Controller commands, and
+the right column shows the resulting state::
 
-    1. LE CS Read Local Supported Capabilities
-    2. LE CS Read Remote Supported Capabilities
-           ──► LE CS Read Remote Supported Capabilities Complete
-    3. LE CS Security Enable
-           ──► LE CS Security Enable Complete
-    4. LE CS Set Default Settings
-    5. LE CS Read Remote FAE Table          (optional)
-           ──► LE CS Read Remote FAE Table Complete
-    6. LE CS Set Channel Classification     (optional)
-    7. LE CS Create Config
-           ──► LE CS Config Complete
-    8. LE CS Set Procedure Parameters
-    9. LE CS Procedure Enable (enable=1)
-           ──► LE CS Procedure Enable Complete
-          ... LE CS Subevent Result (repeated)
-          ... LE CS Subevent Result Continue (if fragmented)
-   10. LE CS Procedure Enable (enable=0)
-           ──► LE CS Procedure Enable Complete (state=0)
-   11. LE CS Remove Config                  (optional, cleanup)
+     Host ──► Controller                            State
+    ═══════════════════════════════════════════════════════════════
+     LE CS Read Local Supported Capabilities        IDLE
+       ◄── Command Complete (capabilities)
+                                                    │
+     LE CS Read Remote Supported Capabilities       │
+       ◄── Command Status                           │
+       ◄── LE CS Read Remote Supp. Cap. Complete    │
+                                                    │
+     LE CS Security Enable                          │
+       ◄── Command Status                           │
+       ◄── LE CS Security Enable Complete           │
+                                                    │
+     LE CS Set Default Settings                     │
+       ◄── Command Complete                         ▼
+                                                    CAPABILITIES EXCHANGED
+     LE CS Read Remote FAE Table        (optional)  │
+       ◄── LE CS Read Remote FAE Complete           │
+                                                    │
+     LE CS Set Channel Classification   (optional)  │
+       ◄── Command Complete                         │
+                                                    │
+     LE CS Create Config (config_id=0)              │
+       ◄── Command Status                           │
+       ◄── LE CS Config Complete                    ▼
+                                                    CONFIGURED (id=0)
+     LE CS Set Procedure Parameters (config_id=0)   │
+       ◄── Command Complete                         ▼
+                                                    PARAMETERS SET (id=0)
+     LE CS Procedure Enable (id=0, enable=1)        │
+       ◄── Command Status                           │
+       ◄── LE CS Procedure Enable Complete (state=1)▼
+                                                    PROCEDURE RUNNING (id=0)
+       ◄── LE CS Subevent Result        ┐           │
+       ◄── LE CS Subevent Result Cont.  │(repeated) │
+       ◄── LE CS Subevent Result        ┘           │
+                                                    │
+     LE CS Procedure Enable (id=0, enable=0)        │
+       ◄── Command Status                           │
+       ◄── LE CS Procedure Enable Complete (state=0)▼
+                                                    CONFIGURED (id=0)
+     LE CS Remove Config (id=0)         (optional)  │
+       ◄── Command Status                           ▼
+                                                    IDLE
 
-Steps 1--4 are one-time setup per connection. Steps 7--10 can be
-repeated with different configurations or parameters.
+Steps above the first ``LE CS Create Config`` are one-time setup per
+connection. The config/params/enable/disable cycle can be repeated.
 
 CS Test Mode
 -------------
@@ -929,6 +1011,54 @@ Continuation segments contain only the Segmentation Header followed
 by raw ranging data bytes that are reassembled with the previous
 segments.
 
+RAS Data Transfer State Machine
+---------------------------------
+
+The RAS data transfer for a single ranging dataset transitions
+through these states::
+
+    ┌───────────────┐
+    │  IDLE         │  No active data transfer.
+    └─────┬─────────┘
+          │ Server: CS procedure completes (HCI level)
+          │ Server: notifies Ranging Data Ready (counter=N)
+          ▼
+    ┌───────────────┐
+    │  DATA READY   │  Dataset N is buffered on server.
+    │  (counter=N)  │  Client has been notified.
+    └─────┬─────────┘
+          │ Client writes: Get Ranging Data (counter=N)
+          │ ── OR ── (real-time mode: automatic push)
+          ▼
+    ┌───────────────┐
+    │  TRANSFERRING  │  Server sends segmented notifications.
+    │  (counter=N)   │  Segment Index increments: 0, 1, 2, ...
+    └─────┬──────┬──┘
+          │      │ Segment lost? Client writes:
+          │      │   Retrieve Lost Segments (counter=N, first, last)
+          │      │ Server re-sends missing segments.
+          │      │ (loops back to TRANSFERRING)
+          │      │
+          │      │ Client writes: Abort Operation
+          │      └──────────────────────┐
+          │ Last Segment received       │
+          ▼                             ▼
+    ┌───────────────┐           ┌───────────────┐
+    │  COMPLETE     │           │  ABORTED      │
+    │  (counter=N)  │           └───────┬───────┘
+    └─────┬─────────┘                   │
+          │ Client writes:              │
+          │   ACK Ranging Data          │
+          │   (counter=N)               │
+          ▼                             ▼
+    ┌───────────────┐
+    │  IDLE         │  Server may free buffer for counter=N.
+    └───────────────┘
+
+If the server's buffer fills before the client retrieves data,
+a Ranging Data Overwritten notification is sent and the dataset
+transitions directly from DATA READY to overwritten (lost).
+
 Typical RAS Data Flow
 ----------------------
 
@@ -955,6 +1085,184 @@ If segments are lost (e.g., due to ATT MTU limitations or missed
 notifications), the client uses Retrieve Lost Ranging Data Segments
 to request retransmission of specific segment indices.
 
+Combined HCI + GATT Flow
+--------------------------
+
+The following chart shows the full interleaved timeline of HCI CS
+operations and GATT RAS operations as they appear in a btmon trace.
+The left column is HCI traffic (``< HCI`` / ``> HCI``), the center
+shows GATT ATT traffic (``< ACL`` / ``> ACL``), and the right column
+shows the combined state::
+
+     HCI (CS)                        GATT (RAS)                  State
+    ══════════════════════════════════════════════════════════════════════════
+
+    --- One-time connection setup ---
+
+     < LE CS Read Local Supp. Cap.                                IDLE
+     > Command Complete                                           │
+     < LE CS Read Remote Supp. Cap.                               │
+     > Command Status                                             │
+     > LE CS Read Remote Supp.                                    │
+       Cap. Complete                                              │
+     < LE CS Security Enable                                      │
+     > Command Status                                             │
+     > LE CS Security Enable                                      │
+       Complete                                                   │
+     < LE CS Set Default Settings                                 │
+     > Command Complete                                           ▼
+                                                                  CAPS EXCHANGED
+                                     < ATT: Find By Type Value    │
+                                       (RAS UUID 0x185B)          │
+                                     > ATT: Find By Type Value    │
+                                       Response                   │
+                                     < ATT: Read Request           │
+                                       (RAS Features 0x2C14)      │
+                                     > ATT: Read Response          │
+                                       Features: 0x0000000f       │
+                                     < ATT: Write Request          │
+                                       (CCC: Ready 0x2C18)        │
+                                     > ATT: Write Response         │
+                                     < ATT: Write Request          │
+                                       (CCC: On-demand 0x2C16)    │
+                                     > ATT: Write Response         ▼
+                                                                  RAS READY
+
+    --- Per-measurement cycle (repeatable) ---
+
+     < LE CS Create Config (id=0)                                 │
+     > Command Status                                             │
+     > LE CS Config Complete                                      ▼
+                                                                  CONFIGURED (id=0)
+     < LE CS Set Proc. Params (id=0)                              │
+     > Command Complete                                           ▼
+                                                                  PARAMS SET (id=0)
+     < LE CS Proc. Enable                                         │
+       (id=0, enable=1)                                           │
+     > Command Status                                             │
+     > LE CS Proc. Enable                                         │
+       Complete (state=1)                                         ▼
+                                                                  PROCEDURE RUNNING
+     > LE CS Subevent Result  ─┐                                  │
+     > LE CS Subevent Result   │ (measurement data                │
+       Continue                │  streams from                    │
+     > LE CS Subevent Result   │  controller)                     │
+     > LE CS Subevent Result  ─┘                                  │
+                                                                  │
+     > LE CS Subevent Result                                      │
+       (Procedure Done=0x00)                                      ▼
+                                                                  PROCEDURE COMPLETE
+                                     > ATT: Notification           │
+                                       (Data Ready 0x2C18)        │
+                                       Counter: N                  ▼
+                                                                  DATA READY (N)
+                                     < ATT: Write Command          │
+                                       (Control Point 0x2C17)     │
+                                       Get Ranging Data            │
+                                       Counter: N                  ▼
+                                                                  TRANSFERRING (N)
+                                     > ATT: Notification           │
+                                       (On-demand 0x2C16)          │
+                                       Seg[0]: First=T Last=F     │
+                                       Ranging Header + data       │
+                                     > ATT: Notification           │
+                                       (On-demand 0x2C16)          │
+                                       Seg[1]: First=F Last=F     │
+                                     > ATT: Notification           │
+                                       (On-demand 0x2C16)          │
+                                       Seg[2]: First=F Last=T     ▼
+                                                                  TRANSFER COMPLETE (N)
+                                     < ATT: Write Command          │
+                                       (Control Point 0x2C17)     │
+                                       ACK Ranging Data            │
+                                       Counter: N                  ▼
+                                                                  IDLE (buffer freed)
+
+    --- Cleanup (optional) ---
+
+     < LE CS Remove Config (id=0)
+     > Command Status                                             IDLE
+
+Real-time Streaming Flow
+--------------------------
+
+When the server supports real-time ranging data (Features bit 0),
+results are pushed immediately as CS subevents complete, without
+waiting for a Get Ranging Data request::
+
+     HCI (CS)                        GATT (RAS)                  State
+    ══════════════════════════════════════════════════════════════════════════
+
+     < LE CS Proc. Enable                                         PARAMS SET
+       (id=0, enable=1)
+     > LE CS Proc. Enable Complete                                ▼
+                                                                  PROCEDURE RUNNING
+     > LE CS Subevent Result ──┐
+                               │     > ATT: Notification
+                               │       (Real-time 0x2C15)
+                               │       Seg[0]: First=T Last=T
+                               │       Ranging Header +
+                               │       subevent data
+     > LE CS Subevent Result ──┤
+                               │     > ATT: Notification
+                               │       (Real-time 0x2C15)
+                               │       Seg[0]: First=T Last=F
+                               │     > ATT: Notification
+                               │       (Real-time 0x2C15)
+                               │       Seg[1]: First=F Last=T
+     > LE CS Subevent Result ──┘
+                                     > ATT: Notification
+                                       (Real-time 0x2C15)
+                                       ...
+
+     > LE CS Subevent Result                                      │
+       (Procedure Done=0x00)                                      ▼
+                                                                  PROCEDURE COMPLETE
+                                     < ATT: Write Command
+                                       ACK Ranging Data
+                                       Counter: N                  ▼
+                                                                  IDLE
+
+In real-time mode, each HCI Subevent Result triggers one or more
+GATT notifications immediately. The Ranging Counter in the data
+header increments with each procedure. If a notification segment
+is lost, the client can use Retrieve Lost Segments after the
+procedure completes (if Features bit 1 is set).
+
+Lost Segment Recovery Flow
+----------------------------
+
+When segments are missed during transfer, the client requests
+retransmission::
+
+     GATT (RAS)                                      State
+    ══════════════════════════════════════════════════════════════
+     > ATT: Notification (On-demand 0x2C16)           TRANSFERRING
+       Seg[0]: First=T Last=F  ── received
+     > ATT: Notification (On-demand 0x2C16)
+       Seg[1]: First=F Last=F  ── received
+                                                      │
+       Seg[2] ── LOST (not received)                  │
+                                                      │
+     > ATT: Notification (On-demand 0x2C16)           │
+       Seg[3]: First=F Last=T  ── received            │
+                                                      │
+     (Client detects gap: Seg[2] missing)             ▼
+                                                      INCOMPLETE
+     < ATT: Write Command (Control Point 0x2C17)
+       Retrieve Lost Ranging Data Segments
+       Counter: N
+       First Segment Index: 2
+       Last Segment Index: 2                          ▼
+                                                      RECOVERING
+     > ATT: Notification (On-demand 0x2C16)
+       Seg[2]: First=F Last=F  ── re-sent             ▼
+                                                      TRANSFER COMPLETE
+     < ATT: Write Command (Control Point 0x2C17)
+       ACK Ranging Data
+       Counter: N                                     ▼
+                                                      IDLE
+
 RAS Common Issues
 ------------------
 
-- 
2.53.0

