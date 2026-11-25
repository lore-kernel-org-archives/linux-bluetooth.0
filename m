Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626158;
	b=c6LzfXu6Hpv+xR7k+6DuDL9SPYMKH8F0YxpgSTe6YW/Jtp6byIn5RxyM/69BT8h/nzHR
	 S7FzrDA4W6U0F7vi3FXxyoPYERtcGvDdOzi4jg9CNKNwIa6qCqFBQ3WKqRSFeR5Ok7VTR
	 +wFu1o53vzEvbAbmdKaNOdmwXKA6OdTg0W5/8kbN7Bq+CqVtzyC1uTO0YtxAh/btU/6pg
	 Qb3Ob6LKo0dwzwonORdnTRMUTb6qnWOKOQ16NTUpNx5Gl9SXshVeANQPKdTf5TQep19nv
	 D6ygJHkEkh/iLSsyqv1SwKwrc3HJXLL3L/zPS1chzsa2rwbObaWakkBPszeFwr9hm2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PjLK88ML88j7FnC8DztMEdbl/fQEL1AokCLS2jOWttc=;
	b=DfYQ1VkEuWVhMvfgIbFvI1HyeIlOCJsfo/NTEnQAo4detZFR91QPO2PvphK1ZJ+nxpMV
	 JgEwpG24EQc4ZYkUihmG50/WoTfNc4mWtDDwbtAC01fq0dHmi3ClPdCvP0p6W3pOtYRBi
	 ExLs3vKUinnKZ++WG+VoeQJGyTHY+drjle4RHu5UrcdTV7feor4IgF2Sm0SnJQ8zGOsTv
	 uvVmYNK5oFB2VxYKkWrEtx7Qz03E0m9Tu4qm1qhykCAZppvM2miF+9uYhuVDYMihqsaz0
	 nS21tT3C/Jv0cuoUZhnhGd1RInZ+3TLknqqYsHex6ouiBQamp4adrE9QhRbppoRccyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=puZZaaxb;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA7606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EFA7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=puZZaaxb
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so54021045e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626157; x=1796230957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PjLK88ML88j7FnC8DztMEdbl/fQEL1AokCLS2jOWttc=;
        b=puZZaaxbFRR3FOfoAJqwua0M/GqAG10fLBKTjO65dchNIRtSUbKz6SNQQCWITEWxVI
         T+9JLZWFEl3ak92xYMT6VYj5ZtNgCGj7IsI5S6CPf+rEQX8SWEUicJD+nzw7c2tWus+k
         8IRc4nMfnwiNlVFqJMqmWMjv4lbKqfeQjSNsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626157; x=1796230957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjLK88ML88j7FnC8DztMEdbl/fQEL1AokCLS2jOWttc=;
        b=qCjRF6xeGETckfr9/9j3TU+Qlh9xWn1JF86CeFMKxoh8lzavzjPtW/wnHWDcIsgNJ3
         eBQxkYy2Nc2YEEHi7INR0AP6rdcJfOhyusS4rY8AUVEHMFlRQD3Rd1hfHmkAqMXCgdUf
         FlMVw10a/BguZ/jnWqdLUx5ZfipCR5BW6S0AWI6iwdvpIuCclEC27spNufOrpOg3f6L2
         rExBZc+Nvrkt5jNo2qaTxD7ARfxC0q/4w0yDkrM0wJ5i+YYu2kxo3GaAAWMrwHWIwDq+
         9WTI1G1AXgn6YsHaGiAr+AfokTGd6qG8SU/DTdOWff4L9vJNrl2w+AHZuennVKkRrc6q
         L0pA==
X-Gm-Message-State: APuU4Z/PLE2mnhhMDRHkfpE471VbQg6J/BQOk61icBNSiu6b+xIOpSep
	sOEZQZKRswqh3/vYM6TbrDop8HhO5Qk/Zj6Z+07v4Ma+cD0BpQzkFJxcbhV6sn42pTJZyUD2DUU
	bRHcg
X-Gm-Gg: AZFdTZcDon4UvKYGxnVDSJJCVykj3nE2HPjLpP48Wug+yOEgxZGoPphyn1u2fGeZKi/
	I94t+mKcvQjlWiPL8Eu6x53BoPWigYca+TkKUBbaCtQBqqyLTb80mHWjGvUMbzwfOi2JBUa/8Ik
	ST2p4YwDK5y+pGpUCEJXRVHMKNSSD8rDef1CrdPY5N/i0fVttHRiJCOIlD/9NALkqm3l2PIwVCm
	mImeVIQBtndVatJmMtkMLPYsDZBiBW/SwIe+/SVYP1PpnqMTHe3ZnjSre2vYCT5OXw/V0uPKL9w
	MDAe68sN2XgfpsizbUgF7LcGDBe5vyPcdi7Jydddow/86TPCWmrE97YDWsaR2zLFKezatjdXVDx
	Otm5Tt4EdHzeLi/pq27HnE+lFW7j+7X2zk8GB7DJRhVDNULa7DRQCZcY4pviBUIEubbkyAxfhdW
	+Gn4fRXZhA0uH2AuEZaLRBfD5/UB9KqqyWW+9XPi3X2gVc1vuBxT9p+2IcVp5lWMoyNZTVaVxE6
	BM1T+osYlYktjdMr/okrB9qgJ+DxZm7P+BJf33QbqvLJlQsI01nO47kLfRq5rkQctZwxq6619T0
	2AwEZyaZZctRY763SwXvl0Jfn95DM32S9SxPv0QGESvEhwq8qZIfzWrzibg/wi3lP2BxXLA=
X-Received: by 2002:a05:600c:638f:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb8881a2bbmr340844635e9.17.1795626156802;
        Wed, 25 Nov 2026 09:02:36 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm728785135e9.13.2026.11.25.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:36 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
Date: Wed, 25 Nov 2026 18:02:31 +0100
Message-ID: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_bap_remove_pac() looked for the PAC in the sink, source and broadcast
source lists only, so a broadcast sink PAC stayed in broadcast_sinks
after its endpoint was freed. When the endpoint owner goes away, like
WirePlumber restarting, the next BIGInfo matches the stale PAC and
bluetoothd crashes:

  pac_bcast_config (endpoint=<freed>) at profiles/audio/media.c
  pac_config () at profiles/audio/media.c
  bap_bcast_config () at src/shared/bap.c
  bt_bap_stream_config () at src/shared/bap.c
  create_stream_for_bis () at profiles/audio/bap.c
  bis_handler () at profiles/audio/bap.c
  bt_bap_parse_base () at src/shared/bap.c
  big_info_report_cb () at profiles/audio/bap.c

Fixes: d49ea14f70da ("shared/bap: Add support for BAP broadcast sink")
Assisted-by: Claude:claude-opus-5-5
---
Changes in v4:
- bap: Start multi-line comments on the line after /* (coding-style M2)

 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc28de52..9404bddba 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4864,6 +4864,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
 		goto found;
 
+	if (queue_remove_if(pac->bdb->broadcast_sinks, NULL, pac))
+		goto found;
+
 	return false;
 
 found:

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

