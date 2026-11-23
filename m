Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472615;
	b=wXdexNeWQJLgzLiDTcacot1H5JFOgovpOQ6ckbWu7RHPerKc2c04EnQQN/oIGcqoANUT
	 yEydWU13bbB/Ne48X1D6nlM8WpDc6R0Vd4Gz12B8ArXjw60e1p4lsP2CFE2M93adboj25
	 wD7BcnR5r5755QB7DHY+XtmWNen0UNy9kR9WQctvF+h7HLa7SIqbL4/IRelWvnWRJF016
	 uyfu5crtrbljT+8r812zn5cPEAUVknMTOmOapKErZ3aEohApuzvKnvKGFPDzjcJQL427E
	 0/ryI3qLMZRgegvDdiuFcsW0Nsxh6XwR7DeBzz9ZkJca4zH6NTuxxRtgUgAx8yQ8X8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=drsU1FRqvpnuGlIqqCSL7ktsz/4zuJvayaaXiesZHh8=;
	b=hixtHXIT4Xi5P8WNUJKx0ak6m+A0wN0IdcuSJY5wXArGgYCYDB3knAOLKe9DRhrhbBu+
	 APPY4mPNKpwGvPBqAwBSAXuWOUwYOilmvrudze7ZdO/Gb1a4lmJyWeP7ABrwv3D0KwXeH
	 FFpXEjgiDw+2JvGu447FqFuylRO7ptqkhhR+qvy993BiFE17Lo0mlBByYpTjYP5TRlxHO
	 oTYhgHlijozNNhj2HwhsFYPiBc7gBKgKTOE/fDknnN8zoPyzpJXseN7hzbtSbAg7emklZ
	 Lb9iKqHwUonOyf+NNzvoEjAZDrs03SJpcDYKI+IOBhr1nlLEzvDkEOsG9jcjCsx5+cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PK5ZBwwH;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD6606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCCD6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PK5ZBwwH
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb76bb36c7so3269265e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472613; x=1796077413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drsU1FRqvpnuGlIqqCSL7ktsz/4zuJvayaaXiesZHh8=;
        b=PK5ZBwwHwjSkbmubMKSh9+K9e/HIngKHq/3/xqyPuIieh2+DPcbobmIl7r1kLHQ84S
         T0uJaNbNLKGMIoXK4HTN/tl+CV431z4d4CkupiyBEleWTmmtjOz4hGOondxv6Ep38a1o
         jSoL2rUpZ+bT2Mo/AWtZ1dQWn1YBJDEZT7lEfvn6U5G5YKTeuulirp9D5Y1wA3ROzRpk
         Eaj53dsEMbpnEtZzTmMyR/QL3BJkGDhj7LBeQK8ViPMd9CMNLCkPqoQGJs+O2x8ffd8R
         eLLCJGvqNcbozTX59SfwihfND0YLuqslz+Wey12I9Jy2cOvg4LRTYHdjGzJB32sso8NW
         Y6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472613; x=1796077413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=drsU1FRqvpnuGlIqqCSL7ktsz/4zuJvayaaXiesZHh8=;
        b=mWHcNOqQDW+1aaD2lPlf34r91VPkWo7/HmMC9sB5EL4C8x+P5oFrI8giptVSzwAIX6
         8F/IKTw7HCalXS0/sl5sffrlB7iwkdt9tpgkAz234cLOGkKL12qvYpfsZe7trD3ZheRu
         zijuNKioaID85Kfn/kneluikVR7mwTTqLDQtTPtGk+3xbWtFUpfxnI7BBIJXZuMRrVKZ
         dtesyO1mWEMyEWOtwkAUVWJErmVi26BhNtZRSfQ8YIYfa9XUrRUCiVKinh75sDJjLD9l
         NK4DMNU23CjJkhIRs45q/2pDmCgnRo4l82ZCGjM4LnoMP2y1wUQ3u/iQf5qWHtUL0h0N
         jbBA==
X-Gm-Message-State: APuU4Z+rrWv/5Vh0O2dVLtILXi+wWBzMSw/NSi75tThC0x423IwUX9nH
	Z0c6Hk8Wjk1LPn0xALwglngWeysYIA83Ode+47+/1EAZxhfXFsA0TpkrgEnfpw==
X-Gm-Gg: AZFdTZcIKbNevFv6dah3Zx8HZ9lDLePSpc736K5bY4nFYd8+BrRB3Lv7ILeDKjFCwj6
	xSJlE0OmzPevCnbY9Rx6e7NBAFk+0pXGEpDtdW1Fctu+Rm6ArO0f4DpQRAqlg8Ue4DxrnjIe6/M
	IE4NG9SmcXPjBXjmKzYfsjA8nA7f0JR3u6nY5S/aEib4XqUKCCICaselEs4SCnSi8OiWWfMrMJ4
	HhFDett0Kln6AgYRYTPzBCpMxK//Ye1By+4MXKRYWWuwH3TOU/5HjqTVQ/WrsZ6p05eFxFW1az4
	x3pnL4Xexu32kT38O+OYEGC48Q5ib4q1iC2y+/XABUMxExMzuAJd2kPkG4qvthZu1M88Wwza2oQ
	KioUJqlL7V8VX2yhCHiXcXJuSvJc0UFbCTodMsjglLsQH0OAeWTLbQTQHeHj8bIBezg7tbz46oL
	j3X/PMDVjA3Pw6rxf4qIbMhstPiQbe+uXt+mzR67Sl8V+cw4MSxzoeTxmnPR5Vnhuq9ld2clej3
	h6IFVJ9WUFdM+OZaRObbHW2BVPTE3ZEiVy4cVmorpUQYsY6qbwWYcucQwjU12gygz4n199SEReZ
	DiNDkJS64jUzNZTbY328QSpeealpl6WHnwdDuhuULth6h690
X-Received: by 2002:a05:6000:2310:b0:491:2367:1dca with SMTP id ffacd0b85a97d-4b3fd477a9amr6547073f8f.3.1795472613151;
        Mon, 23 Nov 2026 14:23:33 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b398:6b00:c303:57b6:d70:952e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm23019015f8f.18.2026.11.23.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:23:32 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 2/6] monitor: Fix reading Flags beyond empty AD structures
Date: Mon, 23 Nov 2026 23:23:11 +0100
Message-ID: <20261123222315.223450-3-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123222315.223450-1-rolandschober1968@gmail.com>
References: <20261123222315.223450-1-rolandschober1968@gmail.com>
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

print_eir() reads the first data octet of the Flags and of the Security
Manager OOB Flags without checking that there is one. An AD structure
which only has its type, at the end of the advertising data, makes it
read one octet beyond the data.

Fixes: 854c945433fc ("monitor: Add full EIR parsing support")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index bce3bb819..4f63cc0fb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4437,6 +4437,8 @@ static void print_eir(const char *label, const uint8_t *eir, uint8_t eir_len,
 
 		switch (eir[1]) {
 		case BT_EIR_FLAGS:
+			if (data_len < 1)
+				break;
 			flags = *data;
 
 			print_field("Flags: 0x%2.2x", flags);
@@ -4534,6 +4536,8 @@ static void print_eir(const char *label, const uint8_t *eir, uint8_t eir_len,
 			break;
 
 		case BT_EIR_SMP_OOB_FLAGS:
+			if (data_len < 1)
+				break;
 			print_field("SMP OOB Flags: 0x%2.2x", *data);
 			break;
 
-- 
2.47.3

