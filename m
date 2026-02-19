Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06470345CD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518165; cv=none; b=Wuc+KSiZqU2yFmb7tsmx6lyiy3WFeVI+4nP35SGPP6I6lfLTz3ToOH7p8P8O84kgxzOG1dR/zBgN84ZuLpxvhZQPo2ckXWrpfhQzmbkM2BBFC4drQftTBM+4hn5i/kul3STRLhtEYifibFaCrskTY56RypPRO3uXCBcrhd+PPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518165; c=relaxed/simple;
	bh=k3tP2GaT4tcHfCbCWnfQncRh/tO8W5gbGX1DWoUynq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWc68UdDle5P/cIPyxBkOWIujgIM+VxA2EI3WsZCnFJBEmWAMReohaxo+Tv7K7j7/lrGq9B+ulDp4xpJEgFqU4h49k98BxaduFPtk/y4g5udHyz5v3CsHxoJ8mUjDAhJ8XS7XBeEjhD3FSF3zF0mS8dSUOrNxuN6320G7G7gGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYGnaJV6; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYGnaJV6"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-56637565faaso963861e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518163; x=1772122963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax+6MRW6PcZ3S7laM+czngD7BUwoJo75x/lC+Cs1LE4=;
        b=WYGnaJV6T98pxS79BoJQ9Zch33KvBEip+ydAozHUnb3kzKJTOHEPvpPto0BelmciLB
         JoTCoOXeDVaVo9btLfC7l7l/LqgS9Bce6ypIHSVd0rj7OzAQMJLEgEdnvkxB5EoUP4XQ
         ihPoP1ZPlfE7K+HD2VTilvmesOYJ6XhBjURPl7OV3Cc04oCRAUUB4F0TSaJYs8NtL6D1
         lKUpw+XCPzqiCW1QvLHtU7Ze3vB9esfWXUl6deVo/XKT/v7Sh8rN7luhwecqJt0Ihhbh
         UFSx8D8ZIQJ4xleQgytwi2F/U4u/GY9VU709UytsgOXDOz4LwunuchHE+sn9dmUoAzrq
         z9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518163; x=1772122963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ax+6MRW6PcZ3S7laM+czngD7BUwoJo75x/lC+Cs1LE4=;
        b=NDfx7NuCCCSH+FydSmbAxJPkzgbZHeMylLNCBHtW1+QTtfh88EBjy2JyTjZ8493I6q
         RyikKsL/6n6Q7fnT2BGOcf9X2SMtJQYu2c3wWRbROlpgtRQad/L9/k2399zPiVQ7/viE
         J3sX8enTADKYRiOzoMFgWqzAuoElcIURhzKaZ4r69OgSdFOHhJvmj5Iq5Jr2NltlPcvE
         TBrtnhUjzf2BkmXibc0ltd1nl2ZFM5a14V3yLgS/hXC2RgquyhTy5P69ZRF4oP3F95jw
         v/RwTbxTWjbKy28CUTZwOtx1FVSK5FaEzVuTnPDJYg7Q56o8R3aMMMdZIwXZvVgirFTx
         Wnrg==
X-Gm-Message-State: AOJu0Yx13i0UfDtxtCVXIyffzd0xSzLgKF+oAAKGFwJFAR+WShs2n2e+
	covInNEu6k3Hl3/FNb6JdO9fY5gbd6lBacvj0fee/qduo0RhzjCHnP62mIN9JtNp
X-Gm-Gg: AZuq6aKaMIok63eSSpvz4hotC12mvWv26b2Yl11nkHzsDutFo4IT2tEYWt6Uq4rR86c
	4Gt65gLlSOScz07HDGvV4JikkSl6evVDkLpu5IEeClfOgmGfJKX2R0bp72w2YJSQ+mS9/uzMtUK
	kdoZL1OcThjETtvF9DhaJg6NYoJ2aME1tfPVL6ijxLdDP5vkIXExtaCipMQSbg3xGj9vSuguFyJ
	YbMVnZH3f2/0vONo3aQTRkLm78R1HA82q32K9WWvBHYrwTRSDm8b1+UwONA2WPBQrp/MzFkyLrP
	Qb1eulHg43r/JGBOpKvMJjreHulZg2rX57S5FNqrm0rLYyBbQh8w42CPmkm6aVnlYME5KW2t5ws
	NivnE2skYECdmk52p1LszpsjDTHoaXuHINkDUs+ybu6N0lEp8WakmaZQ3Pe94bH3gT9PV4KynBp
	KFWDlE0ZdLyryAJzvnrq0awMnuGoPnTrmM6cRn/qYjvInXlA23DzQkabA/b3/LF3UVQKMvKS1oT
	ZtIH7RxKdvsCeoi9Q==
X-Received: by 2002:a05:6122:8b85:b0:567:4260:5244 with SMTP id 71dfb90a1353d-568bf5f030fmr2995989e0c.21.1771518162593;
        Thu, 19 Feb 2026 08:22:42 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/8] doc/btmon: Add a dedicated section for analyze mode
Date: Thu, 19 Feb 2026 11:22:26 -0500
Message-ID: <20260219162230.3074355-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219162230.3074355-1-luiz.dentz@gmail.com>
References: <20260219162230.3074355-1-luiz.dentz@gmail.com>
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

