Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029091;
	b=vl4p57/Tx8LMh1ZG0QrO8Nar4Nb+q3MWi2dVZqXh8dyPtj+CAfz05GyNKsEYF7AmeudS
	 zGp1R5dmVTACBJj7bcbXiJoM786Ues1/QniBb8b9UMrkj12edvsDJ5REhUQh1dvrg6mNo
	 MHQZLbigCYhox8DEzMBXfVWHV+ceuB1Hh4jcZtUNziWvR3stRnP5mw8pYpyuwYrgWuRyY
	 EwWUd5xJQ4dr/ZJXj4/WaVWIxSSLzuSOSDi5pmieOfBhyFDvHypD320GvZKFHD4rZl2BY
	 QWcf438NgLR9WJVKbrFO6YhxPg8z1XFvCMuvEqPSL0DlmvIWHdn/eTG3rFI98W2OMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
	b=a/TFA42Z+11Idwn6il/+F4cWuFmHwt0VEkb1+fV91SkwqRuFXEkgPUOR5toDiJkhiBkj
	 yNnSvx1QFjV8ddYnjPezQi9Uremu8mmFu2AeRvtvNrVkE9r46NOQxAHdiGSxg6szZTMce
	 RUudvrYXp1nm4Ld+/UlBe21WgSBagII83mb53iLJhkX7J4eaKR+V9woydsEWztRKPlpn6
	 UqTME9tCffNOqmAssc6hh6kAN+Uajxp0bb5fBhiRPd/aWXATJsrywIIFkWTWYzJsu0wLh
	 zvO3G94X8LULoOvXdH9W/M8mgjv75HrY47/0c2ssLptLN4jtkhFcZFmlyQQ5wmpUkkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v431GaRl;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB4606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9FB4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v431GaRl
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eab93a9862so386037e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029090; x=1795633890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=v431GaRlvGEromLanjz1PeKP2HHGsuTJ9R3v2Mjy+D8ib/42zOB7Jjg+eCDzgOTg0y
         aMaF3VBqZ5O9HQf0IGN5qQFV5mSsAsdwzzcTdNNRLtfxm0uoNrgP5hUnlW3u5z6S9fIS
         WFtwdcYHhm58+FLf2UXY+CXq6ozZPvcmdslj99d0vcVBucuqjn7NB97Xo9Do8qmKzcRB
         ZBcuor3dczsADv0EZsRbfeiA3YcWKWfpj+Y/dMEQVYom28UbEOyVBrp5NXVfHvSGUhSm
         9yz/CkdYosI2yOTfjDxTeB+X0YdSW4aSvaWPSlZPkGFYF4LAKru92YHM4Le3QzL6RyW9
         13EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029090; x=1795633890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=m+ZOfsIsvxENAIZbQ1OHw992kgR8VPSy6M+7u9GD1ke0AP2T6zLTjylKsGZW01P98H
         BPRZTf2DRKpEl1ixyBk2eWJwMzmFad0XjLY+QTeT34xozd3PbyvhbWG5oMStHPZnSM2c
         q3p46XS4E2Y3u29VtltXKmj8XTxxPpwJjp52qitGqLPBNcXMi3Md5wPOZUqTk1ONUWQ3
         qnVmhHyx9zyXBEZyOisiwgC1pGklYV9ItdlLBV0pLoCRdOFlh4gGr3e+LajO++SHBU4t
         mU3LUX3kUUq2Pn7rYk9ITtS8SP7QlEbged6IKU+ND7mMNbVYMVLfb1t4thxxG+pwKJ0Y
         KVXA==
X-Gm-Message-State: APuU4Z+U+FO4jxatmx56KIzKsEiQQrXYlnkLIkcpzbDbrO8E+520liwM
	TZjyXwMlVN0AugWaO+gpQa6qLh6vzrfkCO+qu+5WD4j5Yx8YLkVOkTHA/ub0A+uf
X-Gm-Gg: AYBFou0BO6SGzPl5p8OcmHAxZGcO8i3UoenO2Hz4131d2Y0oRNV339TfX2FJKkYPzXn
	H6V91dft4xNBud0CJaqEJQZZo0kbZBKkP5bRgbWveztYN/Bl/FYnMEVbpZuP9qyJ0TRGfKQGyGh
	btCB8z4r61Get33gFcb5paF3oeZ+TC9PW7HJu3Lqiv5x2TU4/xY5GGMvA8RjUp+TrgU1MnC1WCw
	JE1Io5SGiR3PuBzJgZGFtoQVBs0xYCArpwg385pOnbs8T/cHpsH1AL8w/wBxRDNqWq67ewxwn5f
	t5jlGpyjjhvtJEO1U8cX4W7zg0475QQNRUZabHSZYJ98hutz/fCwB9Ud4yD5XN90bvox1x8KX+5
	yI3B+AGWsTLrwwG1ssvzggFv7/pA8pJ41d0ETgG1k9z6nSbUyh2q49dCp9YB7IqDvVTuyNc9V8o
	cDuJy4YTaQMoWMTS8Kl8OvkSjOL+YzxrLR3a02gaoQTGSuNFNwTfXPjs43H4Gu4G0QFw9B+HCiJ
	qz45TrkmCaLjrrBT260qwIvCar7LDEHzKC1MjASXV8TXg1G2r+1Dd5zBYJVzHftKjoJmzWJKTMY
	zs9s2EtsjdyB7sYsrhlMMsvRM6e3mnOG8jZeUDxwEu7pX0WZAQw73OuhHK0jrgReF3gNEEBCEIB
	TM+Jj21t1c68gTlWrhhL9sg4CTF9SoxCJLpz2c2PjVrFOEwcRTZjspO91gmQif5Z6stEdavwQuk
	xCTv0=
X-Received: by 2002:a05:6122:4202:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5ee6470934amr1708285e0c.13.1795029089814;
        Wed, 18 Nov 2026 11:11:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 09/17] Bluetooth: mgmt: Reject zero multi advertising rotation duration
Date: Wed, 18 Nov 2026 14:11:10 -0500
Message-ID: <20261118191118.318779-10-luiz.dentz@gmail.com>
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

A zero def_multi_adv_rotation_duration makes
hci_schedule_adv_instance_sync() requeue itself with no delay, spinning
the request workqueue. Reject it in Set Default System Configuration.

Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)
Fixes: 17896406ff35 ("Bluetooth: implement read/set default system parameters mgmt")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt_config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 7a2cf893a515..51da6a7ac0de 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -281,6 +281,12 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * (32 bits), the one of the GFSK PHYs.
 		 */
 		switch (type) {
+		case 0x000c:
+			/* A zero rotation duration would make the advertising
+			 * instance scheduler requeue itself with no delay.
+			 */
+			invalid = !TLV_GET_LE16(buffer);
+			break;
 		case 0x0021:
 			invalid = TLV_GET_U8(buffer) != 0x01 &&
 				  TLV_GET_U8(buffer) != 0x02;
-- 
2.56.0

