Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AD226D18
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518162; cv=none; b=W6dTpGJEjesn1eTCxYmM26vzYUIkx6uzLlXvpEKANh/xS/q8FBw0wD7L/wGv3VY9DHF3enx4T0X7pq2ukI/KVCzertFDtEsQW1Te3/cF5ie6dpSaK7/tqBY0F7kH8ocCoCWNJA0NPr9Hl7FNvlHoVmTyW65y08I4gZmSy1+VJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518162; c=relaxed/simple;
	bh=fuUQdX6CZRNZEMmwOUyrN7ojoLw4NDfO/mVJ3T02KTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cihqk61uPgbwE9PoKfC6tt4NRG6JcFatBHPe08aKNanTcPJ4pF4FWHfTfdtTDuNrhJfoF29/trpF6Nrhl3aUA36g6aPvWWjsq1jkBwTWFPal3mFfR3hY6qAjRR/bUezS6hJ11leYQ6JjywqcfeWUoWZWbm4qeU7Cd8l/QFh18ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkzLvftE; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkzLvftE"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5673891928cso555556e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518160; x=1772122960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgpWV7SaCAkmBJJvYVr1KKBvX2KdlgsaiXoeBQcaWzg=;
        b=SkzLvftE3bsM4q5a/FzwSlis0Xv6XMObwC8dGV/oyJF8zqWJAOrsGN+AkOQhOr7jVD
         RPk+YWydJ6vd/Y5P/hWeEEhoPhlm8/7uapcrAuQ/fLlRNDQA4f12qapP1ivFJIn2fD34
         ZLdViRJEFOwZdC4x5a6og91j0z3gbnVbeBZMfQpK0vohj3Q7OnAEJ8qXBmrUubKzUdev
         u3tjWnOEZOyqFxpk8fQx/H/tIF0bd6mMSbKKT4JAmumPx0wkWaXY5fqunCbWpSrmy+9g
         Qv3et9H2ItMlZrqPe0A6MPyV01DsxsNzXAQgZIc6X1nIr4LLVU91mkKl9gu1toibzTYw
         Fqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518160; x=1772122960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgpWV7SaCAkmBJJvYVr1KKBvX2KdlgsaiXoeBQcaWzg=;
        b=igdiWdLgsrf+0iwAnpaodMX6XQ4SG2A5JSqNfn/YzSJq2hhLIOLLiH5wh81PpCtkuX
         0V+Fj9KHMSk6Uo6TL9XA/EZ8HDbaSEg5lVmrq2Mwvm/jnUu/drQVdOf8V4TCJKBx30/w
         59zhT3sre5XxtzFlWixqp4gQKYbl3Ch7Ksr42zbOxRb7D51SNzlHO+Q60D/N88Jsbdy2
         LZSTYfsZ+NvsB9P2iJJQg0f/umXf8oKskdT1ldMwwUJ+wHXD+qOT1zcsLbEkyEbDigkE
         MVNFfun1gXLtH12juPlpw4Q2wIvSjE2q+qhrLvdCRCtL+v+Pg2AvynIqXxzWXYDrvhy3
         KoQQ==
X-Gm-Message-State: AOJu0YzjJp0H94OeCGS5bmlKDB8G4ukHz9nLuZHaHHE+zjjkuKbieS8L
	CTlxVJ5jKoNSolm8kwzAQ68XbyYoWaR87eXVyy+iCT4hb9c80RtDMsAS6C8AKpsX
X-Gm-Gg: AZuq6aLW6hoVCXFABmeQ1mcv7CtVVSbDX3NR+Qt2Vn8MigKKyg5jaPTCdoJ0MltmIdo
	d32lqIBkHzw/A1E5Vznsy5eDr6RL08TdJ/IGSyd4DoU/QUBOzclLZlaO1zqd2h2g7K6edh2fVRV
	n7decNehWsU2/qa5tmx6osjy6Fsx3t0FjcHvpD4fv9z+udSqi6aCfDgXNJjDlvXHnuU2Ht9WjfX
	YsG9/co6GHZeFSQjvlyEgxBciFQsciUIJYu873TJRpbswoXHqA/gz62xW6DQdbD/dUyXBAvahaX
	uHAGuTJRURxMS0zGkDlUjFw+33YWLwWOMmis95aNHd1GQfjM2VJTGc+MPs7hQ8u5cntbiQSVnVv
	XRZF37qfWZ9srkeLd308MHog4gXStuxyihQ6kuP4ccvO+aDj1dVXlBa1LxecO5qY7wuCE65FNey
	JgKi0IM1XViBI4G0UJiiwYZFBERLnePC+HTu3q8582D64PbNp/Jdze1CsvMVbhgvIW0TYucXefp
	FYblm0AphEBS+p0BQ==
X-Received: by 2002:a05:6122:65aa:b0:53c:6d68:1cce with SMTP id 71dfb90a1353d-56889c2a979mr6314496e0c.16.1771518159445;
        Thu, 19 Feb 2026 08:22:39 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/8] doc/btmon: Add missing documentation
Date: Thu, 19 Feb 2026 11:22:23 -0500
Message-ID: <20260219162230.3074355-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing documentation for -I/--iso and -N/--no-time options.
---
 doc/btmon.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 11d98a93b4b0..e51001921ab1 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -84,10 +84,15 @@ OPTIONS
 -T, --date                  Show a time and date information instead of
                             time offset.
 
+-N, --no-time               Suppress the time offset display entirely.
+
 -S, --sco                   Dump SCO traffic in raw hex format.
 
 -A, --a2dp                  Dump A2DP stream traffic in a raw hex format.
 
+-I, --iso                   Dump ISO stream traffic in raw hex format. Required
+                            to see LE Audio isochronous data in the output.
+
 -E IP, --ellisys IP         Send Ellisys HCI Injection.
 
 -P, --no-pager              Disable pager usage while reading the log file.
-- 
2.52.0

