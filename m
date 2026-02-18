Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA23469EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439485; cv=none; b=e9wAhijzChzkPbgPs9MqyFzIkv+lUBusMuSkjUuBKyXxdwje+hyjEluxlbKz9luRBeQR22tArMV8Xa3WvpWZ0CMADjtfg3eC+f32vul0XXJ5NwZ15BX3useXxxTmBMrjJhXNiE9vmD1Raagwvg56MP9vSRKsvocsqAQTPaUl97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439485; c=relaxed/simple;
	bh=k3tP2GaT4tcHfCbCWnfQncRh/tO8W5gbGX1DWoUynq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY/IhoAA3PycGLoBUPt9tmgzgdlylYLocEed9gPNpl3//m52sstKh+TNWzhD2/FlVWZAuO/FmNpQP9sLR4atA1H7kT1vn0V6WegWV/jJKocEI4TCpVCJlGjehy6/Pe+lm8YZS1QttAt2GsHjhpIUxCW4XwhVkpZc2O/L0OqoeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6ruTuSD; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6ruTuSD"
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-5664848545fso78109e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439483; x=1772044283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax+6MRW6PcZ3S7laM+czngD7BUwoJo75x/lC+Cs1LE4=;
        b=b6ruTuSD5mbvvYTAMbB+/HPZymLLahdG/Y+VZb8GZn29SaKHWhP1ZhaokfYVn/ohLn
         rEWbBWmaiad4ERoTygcVpZkZVANF4iGdzxzHdM0YgzyoGroB9bl1Ry1p7Ai5zsPDCWuG
         JDwcGAijhru7OWT3JevRH3MTFfT1hoeE/YiKUZ+wDmSWhdouMVB8EB9ye41fSBxvssBY
         EOI/3YvzXBPgnitLomrZt7Wl5PTeqUMl/vVKlqSJmD0BpsGE93PvTE6WRFmq+1suuxAt
         PytyZZ7fgqy+tLIF4nTui8CzC9qPJnkj7Z9bsH9uWEiuow/kDaaBuoMKSVjii+S795pN
         HW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439483; x=1772044283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ax+6MRW6PcZ3S7laM+czngD7BUwoJo75x/lC+Cs1LE4=;
        b=avrEeVIWuyzscFbEZ4Nllk/0oufpqRGfHudxF/BpG2bKihORN7rYw8AXAs9hMTh5sU
         RvuH3ATAEu28baL5Tlw6m/E6ZasnjoWpLFlZ98ZSq3SnfBcDG7C1PFQbrSfxbzi0VytD
         sguPp45bbMC6bJqItUwV5rcBterUlU7/f6yfnxhoDGShwwe52+RCXAiCBv/dQpGJo5wy
         qdrnlQYNqzPZMfWB5UFN7qtn2NIYTv1SRKD+KKwqmRx1Z9C74WLLgdz2p8XUiy/6fO7F
         DIjq0jI9OH8EvR4vGORiVwdbH5zgBG6ZioilbszeI+EHP06AsSNzcj/Gm6Vuvr3gBX8a
         vc0g==
X-Gm-Message-State: AOJu0Yy4zL6MthCoIKQo1mpA4vqp7MQAUKkwBBwiqPHf8JFKddXQjTf8
	4HWQpB/h/Hi1b0uR2WWarvN5liTShPNNiwpNCkLLDFA6QHDwzSrvLdAZ98ccR//vsgo=
X-Gm-Gg: AZuq6aKQD7i+WYm/4Dizt1Pgqvv/wL7mJHWQl8QNBg04Wd/JRD8KdFuYyEomjv6OGS9
	bEW9Tp/uoep/BiLdUrFMEP/OAQwNKPXH70SmIK2fcMSSto/DuZXvLUqgHb36EtuRhhpQEQX3mgS
	mtaEnVDJxhI2ZoxR0QwKHmsNjbZMO9qYq36jWUMRS3CJH7S6U/4bJHpQqFnVDsxPGt+QNBApQv9
	4wZBFigoOS3gYAu6W9vXoxdr2RZl0GakUQI79BAwYJvSZzjYBkqJLPjoxPNxX/0Q+fzpYFRrQ0G
	tf+MmGs5i4065QaQcg0FgmXci4nuLktlQsWntca97sJHpQJuBzpSM1Pkt/1HI5oXflvwrNM2O7p
	A+k0Gf5GQK9bc/34I7EtdNh1dutlb3AijagJ5NF1kbL43vjhUkjjZA5f/LzoRrRfGEuKrvDUoRk
	kiPBdHBbzqz3vKOAFnKmWFdcKRvJx7otVLzwR5K8IW/EVpgKGfO/y9EN7rY/eHxVKswLHKwBAMb
	wAiiQA0opDrkO8UyA==
X-Received: by 2002:a05:6122:d92:b0:563:7d93:b135 with SMTP id 71dfb90a1353d-56768179fb7mr5892283e0c.2.1771439483441;
        Wed, 18 Feb 2026 10:31:23 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1f1f82sm10959316241.8.2026.02.18.10.31.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:31:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/5] doc/btmon: Add a dedicated section for analyze mode
Date: Wed, 18 Feb 2026 13:31:09 -0500
Message-ID: <20260218183110.2840582-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218183110.2840582-1-luiz.dentz@gmail.com>
References: <20260218183110.2840582-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a dedicated section for analyze mode.
---
 doc/btmon.rst | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index d93aa34a9412..66a97859a49e 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -672,6 +672,43 @@ Bluetooth Core Specification, Volume 1, Part F. btmon decodes all
 of them automatically in ``Status:`` and ``Reason:`` fields. The
 source mapping is in ``monitor/packet.c`` (``error2str_table``).
 
+ANALYZE MODE
+============
+
+The ``-a`` (``--analyze``) option reads a btsnoop file and produces a
+statistical summary instead of the full decoded trace.
+
+Usage
+-----
+
+.. code-block::
+
+   $ btmon -a hcidump.log
+
+Output Contents
+---------------
+
+Analyze mode reports, for each controller found in the trace:
+
+- **Packet counts**: Total HCI packets broken down by type (commands,
+  events, ACL, SCO, ISO, vendor diagnostics, system notes, user
+  logs, control messages).
+
+- **Per-connection statistics**: For each connection handle found:
+
+  - Connection type (BR-ACL, LE-ACL, BR-SCO, BR-ESCO, LE-ISO)
+  - Device address
+  - TX and RX packet counts and completion counts
+  - Latency statistics (min, max, median) in milliseconds
+  - Packet size statistics (min, max, average) in octets
+  - Throughput estimate in Kb/s
+
+- **Per-channel statistics**: For each L2CAP channel within a
+  connection, the same packet/latency/size statistics.
+
+- **Latency plots**: If ``gnuplot`` is installed, ASCII-art latency
+  distribution plots are rendered in the terminal.
+
 EXAMPLES
 ========
 
-- 
2.52.0

