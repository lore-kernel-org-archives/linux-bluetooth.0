Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970C37E302
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069889; cv=none; b=moglRuif2JNQI7E6+/wXghT2QDy//30Mo7EiUImVZUHD0BX8Onruy8nAjmkYpLqg8xTSE0ccEP6hhO5FjHcgcO2E4kBDRFp9SCemTROF8cTrXnuydrn+NtZIuw9RFC8DL51AV+Pcm8QGhShYh5KNDqMT/FKY2hkMmiNqeOXudD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069889; c=relaxed/simple;
	bh=+iLs6Ia1UEj6NqWKIOapE6QAQfYFTYYxPN4UgTdaH74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EkXDLe+OeEmpJ3JTePurYkPogiejlk0OqWI7uzd7Wx0jhG4leByesp6qQls5mv+IH0ToSj46mqGEfwB6P8eB1hfgdJeg9mFWFyuA3exTRx/KONebaHauSks2A7CfX7AZjdh1G3znhCRfWnxdDs8IuORvjZlw74L4C1yWQyc00pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p95eOUu6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p95eOUu6"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1960323a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776069888; x=1776674688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcrKjJni4USetQypTM13WQTx/ZJ1t5tixxD95yInrRE=;
        b=p95eOUu6j+yNakXtzRFkSGulq8FY6O9hPT/mF9Cm9kTwIB/h0qP2wYtmImCDrZXkgl
         RTZgEdpimpq+lWnJNc4bsmRRmllP2I6la/5zGjPz4O7rshjyWtrVHc54Uy1iva4X7JYU
         VwBM26+QTn/QhoY1xX/73IbvNw8gD+D5BaYru0WrjG6tOVo8fQFKbta8a3HM7i5EhiCc
         HsLHW7NkBjtPatmyM1Zz44nR/rS4lq0kYGVXQrzdTzriOIi7F/AqOy8zzaKyuNnLjPpE
         u5YbACoONC6nIv5zP8G04iH8h2cmbSC/9aknSYbzBHUOXFSb1OOsLxGOFlovRravt2eL
         d5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069888; x=1776674688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcrKjJni4USetQypTM13WQTx/ZJ1t5tixxD95yInrRE=;
        b=Q5NZ2xNO9+bjgalyZhvbQKwxcHN8J+izHQjBhxWev1w+tOQb1orgYOBQHnSMMR0PHF
         OgCNZR2GCR3MSzMoUC3cInHYYU+7YdjUkXk0LN9njiYgab3r/BVC0v8gC3je5+wq8JG1
         BA4wXzzQCYfQIWMua9ZeBNZTb+9O0+2fwKpyqjCK3oH0s0hxVVjEF3vfebBwMCp8V3my
         PNKPABPLVzDTbTSaSG3IrY+J7rwC2RR4AkOn2Zl6O0UWKIFMXVzF8O8yTbiZxk2Vu7DF
         umhoAtSOdLuOCaGBJxXrvs/doGeCR1gycvIm2Y5v2OMfGsf5Iqe25P0oiiMjGr2+Edrf
         EqEA==
X-Gm-Message-State: AOJu0YyIJYvlBn9D1yeg6eXFP7QoXzJre8vCK7aYwJ5lmMlDy/3Hyens
	VhKzD4xynWYlitQB+mtiWxxJg+x50uBVIp1PEWqlLvC4ZfxEI8zPRDHhmzo80Q==
X-Gm-Gg: AeBDietY2Sn+6hSBF0tywNKEvSoP9IkQ55h6oBicIakXzm1k/7iXTpD07oqEuAaMDMa
	dHI0+PGCX3td+O1qAYjn9b5WjP4frIp5+KyPtGHjq5TapzBo3Wn5+CP55P+uNVf8RXuVhLWqTmg
	9Hww6BSlk/RiQCt25F102r6wC00w4f0Q6SC89SNbDrdaGyBSdtO8n/Y/CfWkauBoe7nGsEQvSVb
	TrTwe9f+2J+2J9sNSx/P7FCCIdX5y5THUm8V2TpTXJsOYMZ54d81IRqLVTjA6RKua4clRHyyy1W
	ucfCNkZmCv9ZaDpx45O0R3KmkHhsvNXjvBTGMySaCAwB4rg0bkw3pZ3JBN0cc91f0scC+VpcE2d
	syZQAco1ZbKB3TXVvzQ4BpwFDTaW9cUnplM8Zx0RjbUOiaVE5hDHNiUPOlWGFPZdmmzjD1jKV+h
	K88k1C0kEoIjeYLjo3PdFpNuPqIVA3SbGRzoc5w3yeWVRUpSWRb628JYwIv0qejljY
X-Received: by 2002:a17:90b:3a8c:b0:35a:1762:92ed with SMTP id 98e67ed59e1d1-35e4285209cmr12656513a91.24.1776069887582;
        Mon, 13 Apr 2026 01:44:47 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb2f077d3sm1685019a91.5.2026.04.13.01.44.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:44:46 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] Bluetooth: bnep: Fix endianness in bnep_rx_frame() extension parsing
Date: Mon, 13 Apr 2026 16:44:41 +0800
Message-Id: <20260413084442.68604-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bnep_rx_frame(), the extension header parsing for
BNEP_FILTER_NET_TYPE_SET and BNEP_FILTER_MULTI_ADDR_SET uses
*(u16 *)(skb->data + 1) to read the 2-byte length field.  This
performs a native-endian read, but the BNEP protocol specifies this
field in big-endian (network byte order).

On little-endian architectures (x86, ARM), the bytes are swapped,
causing the length to be wildly incorrect.  For example, a length
of 3 (0x00 0x03) is read as 768 (0x0300).  This causes either:
- skb_pull failure (length too large) -> frame dropped
- Insufficient pull (length too small) -> frame parsing corruption

The same file correctly uses get_unaligned_be16() for identical
fields in bnep_ctrl_set_netfilter() (line 110) and
bnep_ctrl_set_mcfilter() (line 156), confirming the inconsistency.

Replace *(u16 *)(skb->data + 1) with get_unaligned_be16(skb->data + 1).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/bluetooth/bnep/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index d44987d4515c..2d1cb2061045 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -332,7 +332,7 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		case BNEP_FILTER_MULTI_ADDR_SET:
 		case BNEP_FILTER_NET_TYPE_SET:
 			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
-			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
+			if (!skb_pull(skb, 3 + get_unaligned_be16(skb->data + 1) * 2))
 				goto badframe;
 			break;
 		default:
-- 
2.39.3 (Apple Git-145)

