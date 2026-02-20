Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5E35FF42
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608704; cv=none; b=OaluYdI7P49vPcQQ3ebm4/IfF9GhEQOdwmUbb4PjioQvz4JKm+iBgUaPGV88Ugs1ZEHTmU97ja3X8snqDIY16MwwNz97PGJOIby7h3hkPdEbxXDJw4bAmIGD03f92RKTzXlqkpIhfc4I9Z7ls6pqvW5fDFM4jUK6uImaJoQ/Mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608704; c=relaxed/simple;
	bh=k3tP2GaT4tcHfCbCWnfQncRh/tO8W5gbGX1DWoUynq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY9+uD7CnylJn4/XUavsbHWzXpLxh+xNubqa5+6NtVtf0ToCTxlVbYgYJWgUM4PKRlLXSeeeRIPHvUSLzR/YhZ4MFh/IBpbJv1wphhV4wk3ejvzb5PGhcTWb1XwQgPkEpONcxHL9jC1bW2nlN4nA6bBJoatmwRvB3EBzZX/5jIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czM46tQD; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czM46tQD"
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-5663724e4daso2190790e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608702; x=1772213502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax+6MRW6PcZ3S7laM+czngD7BUwoJo75x/lC+Cs1LE4=;
        b=czM46tQDT5qK+2vYUpwCxAvlnt8U7I0wCfd5GDFi2/3ihz2ItigcSn4KyZ5GnFSBxi
         GA/arG66j6MarBaGfTszE1CG0VkE0MeT+v5/QLruPJkGf4pzv/mUvW0Lo36j5Gnx20GN
         LrS1YeGfhikT3n4WhHjH1XzbUin5b/RbuRmT6I6KheXqOGawPcXSR+5Od8Y7JCTok0QJ
         El2XiDHI5VpAlMTJS04qBsd8lbCsO0rPjCFpGIJqCVtrrdlMJJKzHQDFGUV0AsX/OHDL
         sN8QdKhaC0nzB5lksmHy/3E8ZJMhFJTBlhBxwa9ao2Ph+djN7eA0yoaFh3zQXuuJqb+x
         KLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608702; x=1772213502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ax+6MRW6PcZ3S7laM+czngD7BUwoJo75x/lC+Cs1LE4=;
        b=sbbHGAkJZCf62pWRNgqzQZ2PpyaXxK0yNIVTk6BbiEbLj+MidE8Gv+JwTWnfxD3lbu
         lr7V9i52kJ5d7AvfUxCSwqOfaJENTaiXY5Y+pNu4oal5MAd3fBCRHE6zUZS4XsK8ItHf
         1DOUTW43FkJ6XefAFukEv25cPd+rIq5BTd423SlV/3l9d7HJ71A1e34Pep1kTPoFLie8
         W7rk1CqHSaTRJK7PeEjGlC3hAdqUct/kCkKJZ9Si2do6aq7Zt1+agWTonGVdR2kfWCZv
         xzLIBi19puwJwv3yII/oRo/AGwt9wpfhQSD4mgI7NYpzTIyEaoGulqngZtkRZVjyKZry
         epHg==
X-Gm-Message-State: AOJu0YzmdM+aObHTwCu9WYuhjNqA5GY88V7MWK8hfDBPFp7MnDpm/82l
	cGJVJdQO/evB+GxQxF5YNlpmNaS5B530nlv6m/XFb72DGANeE4pleO5+cOQUNpzn
X-Gm-Gg: AZuq6aIN1GTi7ihddWpQVJPxpbUi9Q6aDKpreibhoHQiJhLK7Zy73tclnf93veQOM3V
	/ZBFL7nhCbTdmCvSlTQRxk81XowTZZ6KqiqlBmLz5BJWqtro+6K522+LypPxy9fhMtC7HrqRJ7B
	UylkqnIEi6dmV4nYWYvPrugRQUOe6zNF/EXj3X8UHQjNZq87UBpkBjd26w40UVFRG1n+qfAE+3R
	I/H+YNsxw3KnGr8WHjECH6Dl8T5Vb0Om03DbvVT4rphIt8HelIgijFbbbB1U+iHFQXVLQpNSnkD
	9hGBraP+iAR5+1AQs9c1vS4JC7c74UBmbAqFPVfZPK5Ixd95yyLGz46xbMSkyH5V9XdBcDq/F+F
	L5TxVguCa9E3zvUxQ3x5O/qcPoOQv3rwEkiIZjqzCDHiKpLOfmPUq2uZQ8L5gGlUSwcSSIRLQOl
	1g/TxafhnrTSCUiv9XN+lA+JHcTg3WTv8IHvXbmKUbM8YR8Vj66SFU8HjGiFS3KY2BtRs+XSWMb
	KDHcMxUn+9WF3PsvA==
X-Received: by 2002:a05:6122:4d81:b0:567:3ac6:5a67 with SMTP id 71dfb90a1353d-568e48b5059mr275181e0c.15.1771608693420;
        Fri, 20 Feb 2026 09:31:33 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/12] doc/btmon: Add a dedicated section for analyze mode
Date: Fri, 20 Feb 2026 12:31:08 -0500
Message-ID: <20260220173120.3418666-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220173120.3418666-1-luiz.dentz@gmail.com>
References: <20260220173120.3418666-1-luiz.dentz@gmail.com>
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

