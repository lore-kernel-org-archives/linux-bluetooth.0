Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029083;
	b=vU8+YCZTMxYWTAJYxLBUq35yxVrf1AL8/QrH7rw5S1m9+BupdrNpm/Z6Sqb/B7bHtDut
	 8u5s+t4qsWJotfc57rUMCZdPjwtSnCA7XQKoxWwFP/18JkwcQTrg9QG/V06r0+uvo52J4
	 jxjz5+LziGead6pQpiFvdN3BERFf4yvKETQRjuPgkdMh3YRVoYzWsmgHjDe7sDz82AZ7O
	 SbRMSLJamIi9VwnrDPqHvHBuYfmJ15beX6kf8A0JRfE3JlPyR6TmfYVS25ApirQTvEnWC
	 PM1O4Tm1RJqfPSpxJXj4lwTDRqH3HkECxG7zhGwE3Pfz6DH5A+YAIl1+LBBTLHYaeBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
	b=WodOhiRlUtjrqR8O9gOFxxX9G7EG8d/yXlBIEpHRV5Wnaa3bUSUP5hjNQesbuG4Ukoxj
	 9ewIpGTdYU75jbIcZN7lfXSwxkHwPv/9WmWo7z/QA69etTBfYg8oejQgGmwWUNyuDB4Cu
	 ExbjNHp4RYxa4VcVAdRguQ5cFiVfq+epHxKgC612WezuOEF/0HckvQPtcCEIr37LjsyOK
	 KUnfj3sbe6wFYNKK0LN/fnT7D35dcSbhUyahxlsBoe4t5P3y4H17d2PaX9llskOaPSdBq
	 gpot4FVu6vHpwdAp5A0Hy1lK7f8Lby3khLR9EswjJeeU+PMi/0Cz0CGGxPXtON9i1Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4DtgBAZ;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CA606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3CA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4DtgBAZ
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac01ff101so512172e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029082; x=1795633882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=k4DtgBAZQsIoGcYYtOQ9ER3ZgwzbsHC1waF1wXRgJ3BGIRLlrcZqo94hEYH4uegaC0
         xp3RgcC8+b2ExSiE6dxdRoWBxivXmETBHyT1UOZV+anSulLcXZvdyv9JkS2kWdJcet04
         kt0IeqtzUhhSmGDcTp06VMQKNE21O6/tATY4UY/SAgsdt/DL+ww7QXUGjGW7zyBQZoV+
         yOg1LfXpeuJIdLFjNcQc+OK1RWp/2MArA7dvg+MPEeFFecwj9vYT+ap83Hum3Bar/fj1
         sCUe9BNIFB0PIeltcIrCA03pI7V4cTNDx0Xz/vBlIL0OtEuVjsZk1UxO/Qi3v8zxNk8H
         iiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029082; x=1795633882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=DYnYQvzpIZJFCg9FAUzFJI6RzJ1yqQm2r7jR8kVvZc8qaqYkd4ezBJhDdLWYFlf+De
         jj1PKYB3ZRCRuj1cWW2OYZLMNi9/XKgkz8kwzBjBvTBCI0cIw1vlaBEZqnLKAmPVlmZl
         VtZ7Q1RVkvs36GFSV2v8RZVGFzV0qa9UfMjJFcUlLSwDcn+JF6WY5gEB50Z9/WNQxije
         Rd0XMZCu2uIkXy68tRv3xvAAO5BlNJlPBa7XB8SwU+gVEmHw4bG4qVfca0axjhliKUrh
         e5C7N3aoc2QDNmOqIW6tbgZ8LhMq0KlVIz54AfiXmKVzXEag2B6Fz31fExF9Ao8mYQA7
         kNYQ==
X-Gm-Message-State: APuU4Z/XGy6/M1p+nmyYK3fk7R4dAWtuc872wtnBYKe7FHOGO6L5n+BT
	nnZoXY5i0Z7bb7omT1ZYUf2ctomDveXVmqKgAdJuPAaXPhwi+nX6tZfCz0pe5Mnq
X-Gm-Gg: AYBFou3CNyru7MxrOfrgKXV/KYUIx/UiMTHbMFV61ipn8qX84/RA82UBCz9ThWMAK3L
	VXeH0QkGTQBZ71wwgb7SAydYhnWs4BoNu1asp395g1o8RofWJf1XdfcbJvhxIAZ/7FjHVMNF5FE
	AxYPz3IMZpMsvRLnOxfyejU0splkwlOcqNE+dFmPpoVtT8hSroR2DSXTblhfID4nmJ7W306uqI2
	Y2CevoQDbbkP3Z5uXNmeayuOj/MRIAoAXr7Fe3RMYj3sXCZ6KrlsfOKpy4Gp3PzO8BzU5mpN8d2
	tnhlgScRfE7ijcaeo2Pi7WJPrBXfM9VIcD+FNDL7Y5mpz8oljr6DkXgKBZZSifZV045Y/g7+VmT
	8sHef63uaP7hug3rk5uYb04J8ieyKESc//GbOSKlohjjjX24zV8RrPjQC9IpB957RUcUseqaSDa
	np4gE1GXy3GwLOGr3RLa6Yhna9G4GF0PuPmObrYZK+IUkTt8w17N9D9rAHdgM2I9y3IbJp/ULLl
	uZ54GSGfuI/ULp/2MOYSYdypR464ebDXUa3DzvtR0RJ65I7a1FhNDivKchAQuVJQXvezgiVagVJ
	mXB1lIMRzn6goDuHxm+aUfLiyxfMfWtkZKmxPKwRzXR+T6/v61NN7sHdTSLFyimRmPSApT0Kqxr
	hbT0h+FnHDgc1wLuQQxnFJB8BDhulIt3ccA1/s5KtKzhPoOWWBEDZzrPmdGfSIHduaNMJn4QgSG
	1VCBc=
X-Received: by 2002:a05:6122:2092:b0:5da:9b81:1aa4 with SMTP id 71dfb90a1353d-5ee646af57cmr1663302e0c.5.1795029082349;
        Wed, 18 Nov 2026 11:11:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 01/17] Bluetooth: mgmt: Fix read_index_list() buffer overflow
Date: Wed, 18 Nov 2026 14:11:02 -0500
Message-ID: <20261118191118.318779-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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

