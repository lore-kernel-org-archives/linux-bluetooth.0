Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E138C429
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286713; cv=none; b=RrGE2mKpJbfJK/xqxWFo85MgAlEZC9662FrnlnpNs/LYCgLb5HUogUooNSD4N1Ex5b8rkniUjOroRLxeq15I+2us/TxHzrm+4T+Mck2XololxibTn0HUAkfg7zLs0blfKzNtiHnibZ7s9mTNcD1PNcuK/2VYcLOCvpqIAGVmjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286713; c=relaxed/simple;
	bh=hr1SyPtJ0ACh4vqxJXzKWQ0r9xOgDEJOnZCn57diDKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vdg2Wltm3t04jGLTQ1SJcdOHIe6K1ktzJjqUrqRU7dzuUzKweCSRqoTzt/uiIRRDfJ3FETZzz5oMd1pEJlEH6FN0GAvWtNkYOdOzUkDdjT+ockywkoNRi4u0vEliWcJ2Ke1m7Fh3Ey7q2auXVnFPU8r8TV3JMW1F9dkNj+4TXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tF/hQmpk; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tF/hQmpk"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a857578a8so2866982e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776286711; x=1776891511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=he+j6+AAh2ivKJP2IMM7LeOVAU++e/q5qxYPHatOL54=;
        b=tF/hQmpkbg/U2fWVl6wcGN3do1KrSRRYhz1cOxG2TEI3gS1U0Il6ymTco0xaonR6RN
         sqtqB09Wa7ldb7PfDi0Gm4eAGj8/rxjII2XYdtLMPCyBwRNV40IYBfM7rWrRn+pG5o5i
         BJEOEOhnkS3LuPrj9g5tM0y8BhMqi6s5Fd9ICT2n5JntIWWQRIEVsc9l0MRF1hl9w1yG
         DKFhinwEJm3nuj4FabPVxdvIs2uCSUtNs2wXzFcnEKwWHRTtxx/m8EbGKjqMaKYm1iQy
         74IsjZmCpwLisnE9P8kkD7zMHTeNKQU6xNPloUDv3j2BQ8jTMmBu2bJvZNk54MDANv1/
         2gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286711; x=1776891511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=he+j6+AAh2ivKJP2IMM7LeOVAU++e/q5qxYPHatOL54=;
        b=oGthUAFS4Y4S29djV/lsR4k1D4wW4OrxkFiZAXnEfMogLtqbCPdZ3OOZPFEoNiYN1O
         v9zu3w+QhGyKb52I9gNXXE99eDTr+snCZJf3PAXtPyaq87DE+zwJevF8uZvGgs4BrF40
         dEAuVO0/GzjlEgrdudBPR2MNCQljejqHuRle+XSdkHXrFMSO4D0/ays9Kzi0EW2hfz/E
         gLu967r9Dq0jv/dg2XEX5thAE0jqVbV6IeQVO7nMUMpBvZZLciDtF9yXHotA/ch2l1iy
         4aSzNfDzWFPObXFEI9o4454XLx2n56YW/C2rgZrbv+D/guJMVHCty01EqF4L/qEIP+3O
         U/uQ==
X-Gm-Message-State: AOJu0Yx4y0XX97hZHIQOlqOqkAm1ul8iplPYz7QuQuz7RfcNtfiDl6/O
	XNG0/w+itPhNjfbAEJwXmXVEpa30rxki/ArsanZAdckwfQxWiXp7aAvKtQrp1zdKRP8=
X-Gm-Gg: AeBDievdFfX454k56I20sFJ5/e5X4SkzxS8W4/D8j4/YJ4VVek5b8rwAsmzFZM8Z6aJ
	4YutbhTuFB2eoSZlGLEkhmr5M5EYvWvi6VVu6ofhi54MJOhW0P6K983AzJYUnHxjyJvsG9Bv4o4
	OGp6YHWVqa15vj0h6TmxG8oRqMDAdjk+MLNt40bj+dFQppmr+uqWgUcvzropNws+XQbkypeuS1X
	Ohreqw1HLyRCDxB2Z0V2DZo3kDgnv2vSwOIoSXl6sgFhiNyBdV19QTHOry8KA7n31mg0YRVIDjJ
	boVG4hAcAvxXjnW0iAgPGV+M13R70DVbzh9odKnDRb1VEb+87M2B1hx793Mv+J1RaIdThvvByQe
	SdJj5oSubjAvDaZQ0MPt0JEl9GxrOzEgr8nKaOHu+aLMNXl2nbs36pU5aN65ihLAuMyz9rKBs5W
	qnYbXHW7keBfU/rAX6z1XXhUW6H5lmH9G561xJn6nQvFvfvt4ancm8qsRw+qUfqUspkHfS9L0rd
	BnOfAamPNsu+ner1pAipu2l9PPNOEEOWQz92ZQ=
X-Received: by 2002:a05:6122:1d4c:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-56f3bb66d4cmr11002310e0c.4.1776286711182;
        Wed, 15 Apr 2026 13:58:31 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f8a032227sm2059622e0c.18.2026.04.15.13.58.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:58:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] doc: Add throughput estimation section to btmon-l2cap.rst
Date: Wed, 15 Apr 2026 16:58:18 -0400
Message-ID: <20260415205818.594024-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415205818.594024-1-luiz.dentz@gmail.com>
References: <20260415205818.594024-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the throughput statistics reported by btmon analyze mode,
including speed calculation methodology, channel details (PSM, mode,
MTU, MPS), and caveats about inter-packet latency vs wall-clock time.
Also document the windowed throughput approach used by btsnoop-analyzer.
---
 doc/btmon-l2cap.rst | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/doc/btmon-l2cap.rst b/doc/btmon-l2cap.rst
index e8c52c5e6c5c..6543f31db95c 100644
--- a/doc/btmon-l2cap.rst
+++ b/doc/btmon-l2cap.rst
@@ -190,3 +190,59 @@ Automating L2CAP Analysis
 channel, note the Source CID and Destination CID from the Connection
 Request/Response pair. Then search for those CIDs in subsequent data
 frames.
+
+Throughput Estimation
+----------------------
+
+btmon's ``--analyze`` (``-a``) mode computes per-channel statistics
+including throughput.  For each L2CAP channel it reports:
+
+- **Speed**: Computed as ``bytes * 8 / latency_sum_ms`` where
+  ``latency_sum_ms`` is the sum of inter-packet deltas (not wall-clock
+  duration).  This means idle gaps are excluded, so the figure
+  represents the *active sending rate* rather than application-level
+  throughput.
+
+- **Min/Avg/Max latency**: Per-packet inter-arrival time range.
+
+Example output::
+
+    Found TX L2CAP channel with CID 64
+          PSM 128 (0x0080)
+          Mode: LE Credit
+          MTU: 672
+          MPS: 490
+          TX packets: 29120/29114
+          TX Latency: 1-79 msec (~29 msec)
+          TX size: 494-494 octets (~494 octets)
+          TX speed: ~571 Kb/s
+
+**Channel details shown in analyze mode:**
+
+- **Fixed channels** (CID <= 7) display their protocol name
+  (e.g., ``ATT``, ``L2CAP Signaling (LE)``).
+- **PSM** is shown in both decimal and hexadecimal.
+- **Mode** is decoded from Configure Request options (BR/EDR) or
+  LE signaling (``Basic``, ``ERTM``, ``LE Credit``,
+  ``Enhanced Credit``, etc.).
+- **MTU** and **MPS** are extracted from signaling exchanges.
+
+**Throughput caveats:**
+
+1. The speed value uses inter-packet latency sums as the denominator,
+   not wall-clock elapsed time.  If the sender pauses (e.g., waiting
+   for credits), the idle period is not counted, which inflates the
+   reported speed relative to overall throughput.
+
+2. TX latency is measured from command submission to completion event.
+   RX latency is the inter-arrival time between consecutive packets.
+   These measure different things, so TX and RX speeds for the same
+   channel are not directly comparable.
+
+3. For windowed throughput (min/avg/max), btsnoop-analyzer uses
+   1-second sampling windows over wall-clock time, which provides
+   a more realistic view of application-level bandwidth variation.
+
+**Automated throughput extraction** from btmon analyze output::
+
+    btmon -a trace.btsnoop 2>/dev/null | grep -E "speed:|Mode:|MTU:|MPS:|PSM"
-- 
2.53.0

