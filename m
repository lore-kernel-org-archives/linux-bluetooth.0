Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34142282E1
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026882; cv=none; b=OQsRenLLtri+L+kCMdyTvi/zxz7mG83Ddo3nmhmZ59gpoGwAekVctu/l7cOldNpWd7AB5qi1BdwA1hcXvMEh/oZQriRKd0IpDmNkTx29hNXTa86PbyIjeyr7LcdZaj42OKF2NKhS1dZVAI3qeiXKG+LUGte6f8Tll+xc5phZVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026882; c=relaxed/simple;
	bh=dMR5MWgAyHm9SkZ0drnohm+311naRTx5K0NN2Zjdxyc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R54uyZot3MOL6EJuidcxEjD6EWMH8cPyNYIPopHeee15JhBnMSzg0y1Z8c5shAmUjUZwabgwZhqneVt4vFHuplc5I4hCAt4/w84dFPP5H1SbAddL7N1U5bhFqVZetY/02W5Qg3WB1HTb3OLxWfFr8/X07Gaa3/4z8hK52Rt2ucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htSuftz6; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htSuftz6"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-930989f9f81so405027241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760026879; x=1760631679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOfiJtH+MMKlRL3K70Jdp/KnIs7rinxUyP+McD79owY=;
        b=htSuftz64w51oR8gHZWSbMydqETDB1UOd9YxNHdwKFuFRYu/7VwH1I3qmfMX3oaVZ+
         amGyJnpXNLkYcUd4YMsiZgAc2WZmjcZauxBkAhPaciYRJyvVe0MhsPT84LBPnQE1mpMi
         OrCLfyFmQ9k99ns3CeSFzPL9cDvPalJHDQjnfazgu7R4N1Ksx/Km0r1PbaqPdgJuC4MB
         r/zBYvcIEga9wRNKi4KlqP2G0Ep3bjU06n0LtjqjXyCJjhc8S7jB36FYYysrwROQgGro
         2ZgROH77K3OgEU5tloXc9f4M7B9p09A3YP61cNzc0gmYLVVAU5+qZ7rp2QJ1LLLlr/cD
         m3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026879; x=1760631679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOfiJtH+MMKlRL3K70Jdp/KnIs7rinxUyP+McD79owY=;
        b=aB0x7GpJGtF3EicO+/rHXzMOAxFeP1tCgq9ThDTJ3So4axMl5jQUFQ34Qv+w64AdvE
         lHxTcCtODgG/Vd9o5K4bCOwyS9afVhCIC7YojoQ+ZsqQhBjQ2WkZfJ22pXs/KxHzORbl
         fJp8qsGgpMPSgv4T4dTo3q5m7NEeL3dkzdShDCJGhfJ88RPXQhW54IUtxBK+nzkcJUyt
         lV+LRCEQQbVgfXVY+Bx2r1wJvmVUpIn+nIUEkJfVHzC798Tkkzx1aNtqJcmoN543uzIs
         FcUUQRus/cc1l4hWvsCeV63Y5RuU11iVASCnWrLy9Fr8BpSXkvP35519gpLV2bGu09Te
         kiMA==
X-Gm-Message-State: AOJu0YylZlOuq+wTZ9OzoTvm5lQQulMW2QjM2XU2LL9O0v78J/ifn1M3
	L6I6n/VugVBx/VbCEa/kZ9nNsG8d9mZM8lVVauk2oDqjxXspBT+UFhc+G6Dmlhjj
X-Gm-Gg: ASbGncunrJRJ/1/L2riBP9Ggv9c5h5iQh+QdS1xB4yVi46Bmxf7V1xjakvDsw73jovr
	YL1AkqucTurg9PmM3Dhq0VX1JeFr+l916sE3w92q/Ouz6JwcQIaGFqsngg1n1fxo+OpSISssaj0
	dQ6GqJJ+SybiqTH+RCzqCVJU05Fjkdu9aw2ZLrihHRQft172XDhMclnZZofTAk5spXKlTSkV43m
	SgFMy4eYbi5pBgYIi4VMqED3TNarcOXDiqX11sYXv6egp/xaf5As+xakyz/gN93kZzUPaoAdKd8
	KfMjw65/3tgaCmKjN+0EOEZWVZrQIAUecZmsRXbYll/MPjhInlDXCvjfGslk+g4/5ItDctQR/GN
	nzL8X46a7T6KOqFIqqo9g1uAsN50GrwlQv3Xw+ybVlHMKjSMZhQZntkTU60rluMq05ZMVcxQeJa
	ykcLlxYEGm/tZtywB7bP/qJo+d
X-Google-Smtp-Source: AGHT+IE6gWbYFGsWimrYYRBwzGDgJmLvMmiCVtl6YJYH5Id/ttRtOFtlO5CIeX4EIZZfLSfbgFh1aw==
X-Received: by 2002:a05:6122:2a44:b0:531:19f4:ec19 with SMTP id 71dfb90a1353d-554b8b7ec45mr3653070e0c.9.1760026879296;
        Thu, 09 Oct 2025 09:21:19 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce69b52sm5454703e0c.12.2025.10.09.09.21.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:21:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] monitor: Fix instance where BN is printed as PTO
Date: Thu,  9 Oct 2025 12:21:09 -0400
Message-ID: <20251009162111.221677-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes 2 instance where BN is printed as PTO.
---
 monitor/packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index d0cf7c5630c6..dd808deaa79f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12503,7 +12503,7 @@ static void le_big_sync_estabilished_evt(struct timeval *tv, uint16_t index,
 	print_usec_interval("Transport Latency", evt->latency);
 	print_field("NSE: %u", evt->nse);
 	print_field("BN: %u", evt->bn);
-	print_field("PTO: %u", evt->bn);
+	print_field("PTO: %u", evt->pto);
 	print_field("IRC: %u", evt->irc);
 	print_field("Maximum PDU: %u", evt->max_pdu);
 	print_slot_125("ISO Interval", evt->interval);
@@ -12548,7 +12548,7 @@ static void le_big_info_evt(struct timeval *tv, uint16_t index,
 	print_field("NSE: %u", evt->nse);
 	print_slot_125("ISO Interval", evt->iso_interval);
 	print_field("BN: %u", evt->bn);
-	print_field("PTO: %u", evt->bn);
+	print_field("PTO: %u", evt->pto);
 	print_field("IRC: %u", evt->irc);
 	print_field("Maximum PDU: %u", evt->max_pdu);
 	print_usec_interval("SDU Interval", evt->sdu_interval);
-- 
2.51.0

