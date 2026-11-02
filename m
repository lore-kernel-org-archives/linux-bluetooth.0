Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643181;
	b=MDUtYGgt28GBGO+L8qOdbjsQ2zuPN3/FHisYJtlBlhdm9zNTWPBuxf2w5JW9KPkJCKk9
	 A5sPKV4xBk00s1xRJcFSLl7aFwgh7JSqxdd5YvezSyOHVRL8mjwafPUXiqL2bluysBW2C
	 VYkpziZiYVyHZ1QM1oAlXNxmM3W+3OwReKOE6NGrs3AekjbS74Yc1P/Td24y1IAKTMhLK
	 4Jde/IfvvN0FYzDtqcoEEGqbSCCt3FQVNYu1g0xj/3dGY7jsuYYae8+YtDoF9TtiCU1E7
	 cvNvBlQD8n14eoPIpFdR9Qw42kTVpjV2Mh0ep/1BqmaQRrmqEm2SqJAwzmDNt44MxAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kCjmpEGkiwLV0Bv+udGETEPV+bZgSwE1N1nolVtmd6A=;
	b=AICqIlzgm4QXPHJYh5OnBTDTRhvgF9/DZeJAENnkhmm1Uxq8ugNzwF+hGyZp1kGBB2X8
	 i0klrFJqSOJo9oXY1z+7khqCeai9oQuR3KKgiPi8BEA0uEJsysWBE4gjl6scQ3cXoSIT/
	 xYpdR2Qlj4cwXd/to02GO+067FdfWHk/ij6FUxIuoKOFgWZJneTTcYoequD34ypeqIHiU
	 9P2C/1rOADa3JdCuKDy/JKOUQwHRGrZ6u5shI0APayaBhOn+XLgDfopwQ1OBX2F7CN2gs
	 IpoeIE1seG39HNJq/hwLegKhntj4lNG6/lLBp2xutro8851IyDuSiQibfGrojwXMiTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g61hdvyh;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2308606A32F
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 18:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2308606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g61hdvyh
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so2462269e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 10:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643180; x=1794247980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kCjmpEGkiwLV0Bv+udGETEPV+bZgSwE1N1nolVtmd6A=;
        b=g61hdvyhqIzap9eFPeAh4YTWPvVI8iDHmogq2u4rkdKOkt88E/1zvzr0m+nW5K4/VI
         0SWBS+xtk+IivM8iSopaF7B5Wo8QV8oo+Y/7onIVh1XX7Y63iaUn4E8gu3TfFwtOQOOF
         LHMM62TtIJCb5O/695jEApTJDhUcv/sYHW6CLoAuwLYiKoRkRanGfH7OmNLXQbd40FAT
         juSyJInIXi8DqT5w2kPnIn0ue5HCmo/0x5n1EkLh9SFm9bjTEsxCjAlXPqfQ6eH6oVhS
         +XubV0ItvpsSgn7z+rV6I/vazWN0gPBsbNMVZHJQPYO3XAFb42hsQ3xKEtq625jFsU5v
         0Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643180; x=1794247980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kCjmpEGkiwLV0Bv+udGETEPV+bZgSwE1N1nolVtmd6A=;
        b=BVir8k8QD+eVPugaYVVdHN3k5ZR9+PXIAcNt8t9NdCfN/kL8606I7nAl0BwVRW9nZN
         VnovYDcPRIlGIe0yqwAJg0fCzuaS5sJmReaKKc7WnOoC1PV6r8VKFfhGg7ZQlB2Hobp/
         uF/BzMkYCxGjk9p5STHVo3jqlTBwr7ZQ6HOP0N3nAjGVAt1mnm5ra7bDc639BYMh2cB3
         ingMlqRpXFvlYf3PtrOgProVO/gawd8466fxPfH3RNBdUMNn9qco7iiec5h+OF4S44sw
         15HomOKlEnfCnw+99fk68YHsD3L9id2qgEyQqGNuYs3LGICmERyrGQv0VAnX27ZDTGrP
         2NbA==
X-Gm-Message-State: APuU4Z/bXE+FerW7IgpbeisBnw032yTNuS3BftbQVPeN/1VJxHKZhkQs
	qf8knDMRmCkCEN//MJEMbJ+YFsJJxG+jVERRTTCa+tJ1tzdpz8dKHKAKLEu4XcR1
X-Gm-Gg: AYBFou07+ZJ6J9UVMwyKFLCX1zYd5+7ngJ15Pd3YPUXHM4prXSt2XHM7O9hEZrjTLTz
	6wiR6uLgIRutA8/GOW2PvhokGzZEzu9cmLLul6PnDA2jRs6rB0EwngSY2rLM1JdKywfpnbePqTa
	3pFj9eYpB82Kz1uxlpk+f2AJMMBxKeTDjDze4RF/4mte5VkREN7ae3OrEI3oi/WAFlgvcHLycKu
	p2YgDxeGbNCcPDMemVoIHbHyr+K0eaA1agDM88Zr/yw3VFUn/fSVH2jqYj7/CmsvXLpSOEdlRn7
	XlBUF+CNbsC2NkWu3fiqOMSiJpTjxlxxGb/3Zz/KTROeaazMvNsPlPDnjl++2n9inVfg/vch6Yw
	EO697M6txGjh3H19DCe+bEOJ1ssrU2ybq7VVsntK0U9sI+JXaw0rWh2v5GiCU+gc5rRRkFouSPQ
	9xnQLenUvn3/RnLUFJsZQgKrqSa3Scpf6qen++1H3RtmLtr4M53p6ZOYu1eU4hiqFPXmGTLCXHt
	+uxZKFUxLYq+6xLpiCgspHIDCmJEMU3rCp0Lc8BbbRiy8af1B6xVeo/uw+NYW7WJyMh1xjdKw12
	z8L1NHKggGQ7OVRAkDtLkj0HCrR9BvhOYyWdVMLZm8AVugadRc+1IKsH7IgZ1THrpHhyze7Njph
	qnrNhlc/eZqOAnkirP7Du+RRoteTlRzEJ8v2UxoDz+aH7ok1t3nAQRJYuOW+ZI2bixDml9mkEdF
	cXnsL0
X-Received: by 2002:a05:6122:d1d:b0:5ec:3e18:a8fa with SMTP id 71dfb90a1353d-5ec689cf4a3mr4691213e0c.20.1793643179333;
        Mon, 02 Nov 2026 10:12:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm10300208e0c.7.2026.11.02.10.12.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:12:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/6] client/scripts: Add bap-duplex-lc3.bt
Date: Mon,  2 Nov 2026 13:12:51 -0500
Message-ID: <20261102181256.2321329-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102181256.2321329-1-luiz.dentz@gmail.com>
References: <20261102181256.2321329-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Register a PAC Sink and a PAC Source endpoint with LC3, both for Front
Left only, so a single CIS carries both directions, e.g. for a voice
call to a headset with a microphone.

Assisted-by: Claude:claude-opus-5-5
---
 client/scripts/bap-duplex-lc3.bt | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 client/scripts/bap-duplex-lc3.bt

diff --git a/client/scripts/bap-duplex-lc3.bt b/client/scripts/bap-duplex-lc3.bt
new file mode 100644
index 000000000000..f1f20fc44e02
--- /dev/null
+++ b/client/scripts/bap-duplex-lc3.bt
@@ -0,0 +1,41 @@
+power on
+#
+#
+# Register a PAC Sink and a PAC Source endpoint with LC3, both for Front
+# Left only, e.g. a headset with a microphone in a voice call. Run on
+# both sides: the device that pairs is the initiator.
+#
+endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left
+1
+# Supported Context: same as the contexts bluetoothctl registers with
+0x0fff
+# Context
+0x0fff
+# CIG: assigned automatically
+a
+# CIS: assigned automatically
+a
+endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left
+1
+# Supported Context: same as the contexts bluetoothctl registers with
+0x000f
+# Context
+0x000f
+# CIG: assigned automatically
+a
+# CIS: assigned automatically
+a
+#
+#
+# With a single location, the stream of each direction uses the same
+# CIS, so the two transports are linked.
-- 
2.56.0

