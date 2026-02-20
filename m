Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9F35DD0C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608696; cv=none; b=iFZ9y7+AidlronJe44NSLQkgbia/NNKGx6xu0FSNrV8KyIOmhmb9+B6L8t+2OUnCnL0iW1+qK8ZwA26ppzW9ivmz25VeDp6sS1ILcnGUVrpCDKUlUNpDsYuGf4BkFNgWrOnD3h4lg+WvoRUITD6SW5iYKu6ai8zHnMuwr78xPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608696; c=relaxed/simple;
	bh=1IJc+iXbLOAclTgdmVYoo2gsguRPJplrQe70+EOH8Fg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9WBd87Sb29TdTdN1lVnMTkq5v9OBdzUlM8L1Rc3+XFjzmS3XIHVtTx1xl2IQo2wuOLo0pDBt2EQr6N4A5goGm4pqpOTHOPxnsi8nBggObZwPXPjQQP41yufRP7lkLwICvX8jz1IMReG4slWty9zChF+0QSHeMqaO/mNP0dmk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqr9ppYY; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqr9ppYY"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56753dc51baso1039436e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608693; x=1772213493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q32v8WNXKb6NO9IFdmH4yaS1YUnL7pgZ8UnB4X5hSHE=;
        b=Zqr9ppYYXuXU2i8P+sK1kx2r4OpLqK0QY5Ce6LfEDimAls1EniR/XnQSj7hSqAZf7d
         hUZYfTno9iclMImQQhgB0uh6S1hoxGkWNxGjHuYkc1dKWqe0uv1rrQtuleQAiO7Abw/q
         ibAjNYdKnYOuteEossicOCUl5tFLH6THiBBya95enRq2j6oV2aCI0aYgtvtHjOuO8X+9
         aM4STmYrH9rWvl+qcEaFqN26QqkUnI1RyMqVvVu+0/eJVALOpF+c6pMe+dOqqnanCRLa
         7SSzMDV9MbIy0t1GHZ7q6k6h9SSo/KarkQsvF09MFlIRBfSdofdnG5qnGth99MscFhAV
         XfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608693; x=1772213493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q32v8WNXKb6NO9IFdmH4yaS1YUnL7pgZ8UnB4X5hSHE=;
        b=wJJAIRGvQzL//Bp6coj9gqPpVZJcup0XwwPQr8j7yDv3TX1rWxwyZQvgll16KYu0Eg
         GKO9SGWBvaRlYREGzw4PG+YxTJoGiAuR+S3dqRGWa4/bz2+TlI5I4+t75PTHG6bCD3xk
         84ksAuL+l0jDch69ZAto5mMmLs5ynOAKwnBVNyi5enhssAYrU3DDP4eGKgs6nfIBeUE6
         cV8zIAyirYWBUTFmt6AdfG0Q9wq+yXJ/4VtS8zo9NiWn9ZH2AwdBePDhDvA6a31zf+rm
         AiqLh2AWsh+iobRUupVz0Zsv3MEpERS+3Zt+dA9Hl/NVIy0H1Fv/fvqG2v+LgySKCNBz
         HWdA==
X-Gm-Message-State: AOJu0YzDP9G9QTr5grWze3o6k3RzoZYAADB4iGzznDfKImILB5oJ6ax2
	zgOeT29UllvtunRkV0BoTObzAIe+VhNxG5fhGAmEJj0NYZJOp2Bvuon3htZoOQ==
X-Gm-Gg: AZuq6aJ83rUo2x0FaCg/wf2khwn6uELI4Ngi6pGnQx8TcPFtcaMkI9rpVYXz9YLIdV1
	6vYrdF45irH6/1glBdOPZvOMsL+8XfPmaFeOz+FlimJ5zLRVUwFho2nnWHQHzxkqzNH0ihu1I1m
	zUewGE7sSmNy0ID10PSXgxOZlNA9NqkVypEhIDuec8OxC6IA+zN2cvdYm9r1/LArTrW+7pP99lj
	ccmy0gW5RY804g40JslVdxwEORXcO+miiVIy3cI+QAIIPV1mMBbRhIq7cbBh7/rnv656ZxTNt7w
	/d+4ruePF6CY2nt0RbrKtbmZDM8dvi1hYqFi64IDGRh0xNtlZSMfPp5lDUWNFlG2C7FBCGknciv
	ieA53BayreKNo3SK4wvDGh9jZgOFcnsB1tNPfooPHCjEvU/lFEbm9ppHRI9jVY+RqFpZQ9Ucwmb
	NZqVROSV/t2kvBrZvqBdcpkIGHy60hmBWd0J6eEeEQZ17d2x+qVdOfPc2Ci8KJab99XKBFwjjIE
	OElEjLZl8oqzGVaZQ==
X-Received: by 2002:a05:6122:552:b0:55b:305b:4e45 with SMTP id 71dfb90a1353d-568e48f2023mr206847e0c.17.1771608691374;
        Fri, 20 Feb 2026 09:31:31 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 02/12] doc/btmon: Add dedicate sections for timestamp and frame number
Date: Fri, 20 Feb 2026 12:31:06 -0500
Message-ID: <20260220173120.3418666-2-luiz.dentz@gmail.com>
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

This adds sections for how timestamp and frame numbers are generated
and explaim the difference between a frame number and a line number.
---
 doc/btmon.rst | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index e51001921ab1..de05a5fcd6df 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -442,6 +442,41 @@ Example of protocol layering in ACL data::
             Authentication requirement: Bonding, MITM, SC (0x2d)
             Max encryption key size: 16
 
+Timestamp Notes
+---------------
+
+When reading btsnoop files with ``-t`` or ``-T``, timestamps reflect the
+wall-clock time recorded in the btsnoop file. The precision depends on
+the source:
+
+- **Live capture** (``btmon`` monitor channel): Microsecond precision
+  from the kernel.
+- **btsnoop files**: The btsnoop format stores timestamps as
+  microseconds since epoch, so full microsecond precision is
+  preserved. Trailing zeros in the display (e.g., ``14:38:46.589000``)
+  indicate the original capture source had millisecond granularity.
+
+The default timestamp mode shows seconds elapsed since the first
+packet in the trace, which is useful for measuring intervals between
+events without needing to know the absolute time.
+
+Frame Numbers vs Line Numbers
+-----------------------------
+
+btmon assigns sequential **frame numbers** (``#N``) to HCI packets.
+These are stable identifiers for specific packets regardless of output
+formatting. However, when processing btmon text output with tools like
+``grep`` or ``sed``, the relevant unit is **line numbers** in the output
+file. The two are unrelated:
+
+- A single frame may produce many output lines (header + decoded
+  fields).
+- Frame numbers only apply to HCI traffic (``<`` and ``>``). MGMT
+  (``@``) and system notes (``=``) do not have frame numbers.
+- When referencing specific packets, prefer frame numbers (``#487``)
+  over line numbers, as frame numbers are stable across different
+  terminal widths and formatting options.
+
 Practical Reading Guide
 -----------------------
 
-- 
2.52.0

