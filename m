Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941868;
	b=ji7KfrmQk5c/SqkrAfUTprypqctweqTcPZUAdIF6c3isJWIVUWfhW/8Mwmhb+TKJ2iCA
	 BGEP9H2V0LZJRPYmzoMINfk86lb4M8CAH4/tYSCfURoSfAMW/FLYPfKHKCxGN/DEWr5YK
	 TeBPpZhXogr5TBE8nPxMr0y+3EFEGUdvkNp7EKkAfrF72cAoQdee2FeFZTW1nOGHWWJN9
	 Ic3z39zjY2XajgkwBhWQU9Y38aRFvWXnvJCcqt5O2yGXg9pm++n6Ncu41Q+RN2lAOfkMg
	 juvjmWvW3P0b6OVSE3Mt9uILsl7Uun2sZRn5po1p9j3eb7UNVQbXK3wn0TnerXOqW1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
	b=kxMnHItoJre4S9YO6DN3KKCPBTBufOh0w00Lo4zs0NGKfLYATn2+7hftJvLFwSbLfTzo
	 8PpObv3atfKT3PDSjfOBtom8w4IIsBK1mNcFp74K8ceWCM36nbKBapqeARPUdhWKbS5mn
	 8GEM2BMvzZk4iavt67csh/lyVwONOvD5exinVFkTHJf00gx/4b8e2v5/AdkWeoqdwmMWg
	 GWBK4M4ciqlF3EKzC4TJR9J0rw1qkh9St62cOTOWFCFOZ7Vm4XxXlifyvLRXKQfsfTSE0
	 mKVJ+lcd0748NqIR/2KO63i79IFyuBjBogItJ/GjDloswlIOcIAcKWecVGZD2JYFl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrhhQZx2;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058E606A895
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D058E606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrhhQZx2
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2ee9e7093so38632137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941867; x=1795546667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=jrhhQZx2LmSB+1Sp8Rf4o1VnMO/yUlzDYKFXzE74wIO6BekK8oMBq6Jy62MIeFI/c8
         3arw868jYPgi5ddnZcqbntN5YdW6UjZipWDKtkH1eepg2uAkXekvYhyx1a124E8FZBRB
         CPLjd3gnbiv0lBGKIZ5fe+B8U732wBw/uUHZ+JTPlUEfYKVe/t749HQCLrOUit5vTbGW
         teHv+8VP6U36nJzwcyuG71XDzttM+mOBjqGq2KD0X/EC0GTEzheXQLch/XpZaHHPBvmW
         WSWuw8VFF5vOUokJLm4g8+FEorYWPsoGrqpBBBtULJNq8zvEaVl8za+I3RMccnwrf2FS
         vMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941867; x=1795546667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7dpmPpZSz2RHH8e6hO3C7W4vF7/inKqUq/GXpVelWQY=;
        b=oxncwl+EkmCwjopBJFs5CrNFStAtltBrSjV//IZ4VKm/q7PGuw0m8k05KhUnDb+vaf
         /Xy8AwXQvoBmvWWrbJp2x7R7aUfAk4OQEIaBvvR4BBYZR+JVXNYe29lDUstwRKzH1WVj
         fncEd/rzTsKfhKc/AZTI1GgGgnAc3YBRxg3JF8oBjvmL7utTMcqk/GbLC2NFUfbeWAaw
         duYIY1xntSgt7EgWoKuxcslzeZ9G3AP4pfCqCq5600FpAPf7s5Z3s8r4W2OSBx9KF0W7
         7y8oOlT9ygRr49AteqQSFGoPJinByBYneeX+MkP8I9ASM+gAyICpsU7HkqIUQv42zI21
         IMRw==
X-Gm-Message-State: APuU4Z988SFg5lGE0S7EMYrQoz83xHaBb0lnKVUDmamtqYLH55YMUe3Q
	A6N6m1YgMQkzF6y+ztYAoUgyNsCBRgmnmNbIp4pzoFYoP+KK9mtxNEPOidw5CA==
X-Gm-Gg: AYBFou2pNmJ5qF9KiwcKn2YcPPCOsoIXT761pkFodyoDN37LFD8L92FoKza0vjjJZMB
	CzF5reAAsPWhW/YJ0YN+LIStpQRvDbuCAgxghJr9IcTYPwyj2BjPCp2znAJ1haJfb9N3vQC0N9H
	1Z7bRY2CTqZ5KlmVHlPjvEagdGox92pBIWYh7uqv3RiKmGuOtBcswDYq6Gqcr3fZV2u7m9u4Hft
	C9wJxwm//CjwY2tOZm93td2n24Pcc3dRbUbojAbNsTfwhYJhv9CUCFojti0eJiYp3LCeBLEmHX/
	TuV6wBW/x+99NAf0moPJl46tJOaNK8NNMwBCm22JjsH2MrkJqQfYvazYA5uxAduvKPR3/H8A9Ar
	FlaekQRt3zFdye4XmuDWvHyihXNMVFEhx1pVu95zF1PX47mVlpIm9pLFfpjjLxz6/BBGSD7xSju
	90QKNZPcdXBT352wjyKOAARIapHmpQvrFNPhwl753YwelCQG8fBXBL4eu9ZoQnU4J9V0JySivZ9
	jufjExjSLMBJw9Zww6W7YEqjDqfqf6qBGHq3j7Aq4CCPyRg5sikGuoL3HAZ2zuveF6Y6lscBwQ8
	mF+F67JZteBGPcNYi+J5S2Y3+E5bI8OO9bxKELETLL3sibwKQsZKJm1h+s7FKL8oY0YUdqB7KW1
	Kjjt4QE83nIN+gb4EVFl9T7AEyePedc+kaooUvm2Zxhy13cPUWOj+UygD/iMo4FUa4ShSNgfVGX
	1dz5s=
X-Received: by 2002:a05:6102:4426:b0:7c1:5862:a97c with SMTP id ada2fe7eead31-7d64d874efbmr4159751137.37.1794941866854;
        Tue, 17 Nov 2026 10:57:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 09/16] Bluetooth: mgmt: Reject zero multi advertising rotation duration
Date: Tue, 17 Nov 2026 13:57:30 -0500
Message-ID: <20261117185737.3758255-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

