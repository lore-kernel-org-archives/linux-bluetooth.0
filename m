Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946838;
	b=umcHr24yfTU4iUGdx+GPXr8c5iqB3wAVur8v6ewaXE4jvKmShZN2L/niYknyhijuA157
	 OnW0gRryf+oEUSD7Xdj06flGUyT55X7/FIjIv8YdMvwvN/S4JWizyhU8nRXtMAhOJRiJV
	 b7ygwKZGlxt6S5u/SZ73FTi2tZI1/iX4JYwxoHf34f1Q/J2nMb3P9gcW1dzVjr9w3rGR2
	 a3myOPlzlowLyaHzJp9Mt35KOT/Zic5ZWFOsx64PJqwRqc3vNLXEJTK1TYCWl/VW8Lc2D
	 pybVYnbq3zoYKEP6Cab/38FqMNdckMeFEsOddc1K+nwsV9s8pyRpZ9Kw4h9jGSQEuSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
	b=xsA7P+YXmwBYCO7+jhbM22HUQK6Uub/iOMgu3iXzPU2uqmylZ77d6ZPbBwuWgt7/Gv8d
	 Gfh2zQw/CO7ndvUPW9BtIjOGwkka8JuJpqhlg3zJdUq3bLZPRTz72KZi+hpaWnxOzTGfm
	 1lWDVdJ5D/7V9u8L+dzcvYCdZkVLJFRTRxQmVDY54vg+N21hkk3mN1pYlUQYYe9WH0RTZ
	 34mXxVYmFukOYhbxoJqwFKGU5wq7KU+GgxrOLYZ+fCeXraZYEMduSK2p+mZkSWQWrDzyu
	 edeOaZ6CHwF6plgMTjG21gOsAS1RmfKzUYlTzdD/4CvI8zAzMJKPR+4ndsom4YnyX/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlvCynth;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA59606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA59606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlvCynth
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2eba2b74aso105086137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946836; x=1795551636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=wlvCynthS51Fj0hdbKm4Gf2f1WKCc+yMgFKC3Z5tv2Z1/E3Wpd5VDFmhIiBFJWuWHq
         QOdBoBD0Mpq8YUFoaT2wh6HV7VnKFMPVmLP7vmkJrsZs1WouUO3c6LCnSI3Dd82PpLdt
         WEU1KI7xX8/ltB2Wy81+74GRbsoQp2w1zS+9tPKY6ggm//KEX0nJVXIDlYQR3M/5ptUv
         7Obx2kLWmANx8VZ/o+v9NCOFV4kkHs32/tVeu+woouKQtTUvASJ0JV8/dNM0nj8yWT/m
         o1d0YDVGGcaJtJPQSqobd2//tRsG9dd2kkfTlDvpTMw57565AXhfKdkW3pgh1T6FftjB
         edcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946836; x=1795551636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=YJk4lr1N8aHVpqKTB6z1moGaOPnvw6b0z7dbFzN+US5fd8Yfx5RjkMD3Hp6nVWsRPm
         rx5ECVGx2XsLft1JvtLWvdbQ4lAm+wMNsFHOK0qkmvl+BBONl4Da1saZX7z61Cst6Rnk
         yUhbtMpZaViI6idAOAwrCjYn9XXsoD/M4Bhhfsm264AxRzVhTcGLCPOZwrkziJ3bUs5I
         TxAK7eG3YyY8rDnoN5wtxn12D2ec1uDF9SaO/jTk0FKz4DPfejCOnYjBd8qtrbHnzHaE
         5hI/lHIG5bvFuxGEnxZ3HoJBl0PBjOQl6mGgqQqIwravDsoE5F7nEoKEYE4jfNGwhFIB
         MH6w==
X-Gm-Message-State: APuU4Z+OAAqbgSWymaDNDXKTmWlDgxM5un3KhHHV+H0JI3iW3PO2UoxQ
	qirgEiw5FbIsE/TYQ6P7o0Wa1+Xl2J95ArU22HnVh5IeUcBNYXZJvcOWg3v46A==
X-Gm-Gg: AYBFou3D6+Q+3KKIQWcNIBprmgU4aXYM3gg6qPOowryVMJHsN3MeCrXY1yRVcyHlOmP
	xJe5bGxzFNsQ3fiGXL7VoSFo9XUvLnRb7XqpTX5WWlXWARAvlm0WdFs98fA+b4YtwLpxPlxasdR
	EKdD3y0NYL1/JL7TkH/nuKLtJgmK1EOO+0OYYcweG8031T9gmdqwPvb7khQ7h/3UWyRzBAxJPsq
	/ZPS2qg/D+9KV4wcTnle+y8weXxC5j3czkE6lHEotfPLQvx85VtkaVi2qjZSW0/oxjYix4CGNmP
	EzUYB5BuMaBKEtlvVYCHXNEFpmZHvsXFu9EQyHN8WIdWwbgqWxNzYYAEHCzm5aBbAGDzuChmW+Z
	4yiBOs/AgNZNre1+/psWyVKmIUFLsl+HFG7CgP1IJgly9CDT5Nohvm2oaWnYQ7NZHsv7ScdXRHY
	2rj3EZTDMGbWtd+XRN+z/rdwMHKbi8ww8HjA9EuxcoOIgpxZf8fGKDTaihPhTp3iP2f591oo6vk
	0opUfLzcHpHdsJAHymBeefwYRWneJhlx1CnNH32u97+6DT9EHE5mPB8z+xaIljfpPo93tIicQiA
	62+9Awe3I6ksuP2et1cpH0duuLBiNsCSjgBGwhRN5kEjxKwuoSl8Qwx400vQBt6+Ch4BT32FWo4
	s9iyvVHw76vQtYXXKeaAMC9HcLlPN568I0Y9MqUhndWJFrT27+RNlrEFp8ChJ/Leo3CuGjzOEZM
	qE+qY=
X-Received: by 2002:a05:6102:4426:b0:7cf:61e8:c508 with SMTP id ada2fe7eead31-7d6ba465f8emr57697137.21.1794946836412;
        Tue, 17 Nov 2026 12:20:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/17] Bluetooth: mgmt: Fix read_index_list() buffer overflow
Date: Tue, 17 Nov 2026 15:20:16 -0500
Message-ID: <20261117202032.3848411-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

The first pass counts only configured controllers, but HCI_UNCONFIGURED
can change before the second pass, which may then write more entries than
were allocated. Size the buffer from the total number of controllers as
read_unconf_index_list() already does.

Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)
Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6ed3bf6f1738..fc0be4ca033f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -444,10 +444,8 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (!hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
-- 
2.56.0

