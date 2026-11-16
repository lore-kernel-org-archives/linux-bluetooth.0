Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818356;
	b=wQrC+muNZGitnyK8Zzj+rog+eZUbNz6R1ePjWdYXOu7QoWsfdEuLW2bSScjvGATJorBm
	 vYHiaQ0o+bFNo467xC36k54BJHQHGl/BbESW2hYNXEmewufKinABYQM9Lw2uVuj0twKJs
	 fYsNHXe+CSB9LGowzHhDorgGTeUg3aeQwvI0If3aIDxOuD4Z7YEwFBBdMgzXP/v/N5fSn
	 IokH2AFmtY28ckE1P3UDHZU+dBMprzFZY6zPpnbm0A+chEZnI8VTuQBsn+VlNvD0iJnPZ
	 6UJlmqVhOpp34BF2Es5AAY6qrzZ+1y07K7uAGtAoicic99r1FNNjFO/0eQvilPd3Ddg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GSln0dgCtCb5NYN7ycmhGMDAWgf5IcHRxJsc0mjSO+k=;
	b=jE6jAfVeTaf8CjNMoT5dxEXQXgUWeKTBUqrLwmMMA0Bk+h9Q/XpeqUranwvbMJ9rG47e
	 9ejLXA2vcJk28d0r2PiV8oliwOkVAtqBUtMtGh/cjt8jA86UFoVqf8dPP6f67N8yscHxs
	 9xGFGADStIhWVn2PF4WEhnQMHmDz8C9fDzy81+ynkmqnJVSehHlXuYIIkqZ+mKwIs49se
	 DE82xC55a1Gy7O+VEVMB3ZoyvjYcmZyGyfbEow2hEm7GFpkrSypp4gQNJzfuo09Avy5GN
	 mqEionKx54f2cHPtEevDn5DKMv5OXsRzAXJb29fGEy7uTvhc8J0U9dysaw5ZOO1Jr1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tsFTamSo;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400E606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 08:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1400E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tsFTamSo
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so1571792a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 00:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794818355; x=1795423155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSln0dgCtCb5NYN7ycmhGMDAWgf5IcHRxJsc0mjSO+k=;
        b=tsFTamSomiR+GLKFISpDKDvQ5p3W01tAMOnHBeL5SoE0r19R8f5QdYLQhKjXs/FBYh
         feffXB/05XEHW5zOXdHiuXnyxPxduKmOYPVFik31hT8xlg5cbFlqXhmqOogWCGltks+8
         Ab+zWXYY/pv0F/2+zKktYs6rFgpa3g5wzYvXIjWfDWDxXHo/0YVPd9nkr8jUWwJ2bpkB
         mg958FFeq+ksp0ZHiD8SJW2A6AB2383yNeGxV0XGyfr+C85reeJ0OFCtub8Ze0O1mHBG
         /hDNFsjXu228ETzod9MfJIOU8MIvG1yJIAobkVH0pWCEEDkyj0ynmSISgKKwdccAjSRI
         52ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794818355; x=1795423155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSln0dgCtCb5NYN7ycmhGMDAWgf5IcHRxJsc0mjSO+k=;
        b=lgurIG2ngkNmxja1gwwyeCtJ3PIxW5O6BLcVmuKKxBVYr80+Vsa/5kcZhQd3pOgBTX
         UE94/AKcY/w5fpynz2ttic921y0OAgdSaavEGWXzhkEuHzHGaquI8hpWa5cNnN5vcoHQ
         NCV16Q+JKPC+kwTpTmytruWn8+YeIqiSmmILVeM51A0XWax6QiovH3OHMWDf4YZGexZs
         mrMQck4jbZul9BLWh6kHaVIrQeUpxBg40EZ9GRIgmsvaVaqFs8Lc6ZMcZrLXLPcS9/qZ
         jshgzda3RInPJeukHLlBcBE8yN+Yo0EZpa5AraTABaLDLJuxx/LOMKbPXIve5TO+Pwm/
         xyGA==
X-Forwarded-Encrypted: i=1; AL+hErEzPa6XToms6A1g9tihflD89YZL2VkK/afhaRx+L5Ie+SpuVapPqDXB7GK+ILTpGpGq0waDRgu1UtZdJqAvEjQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z89pyWy8mXicBHO0ZMunmn6tki1HH1+dA0uIf0oKEroJydPcelF
	uiu6Dkg08aYsU3qD0i/7jjxmN1JBJzVwdD+MXObi3i8/nlKO/yMItU4s
X-Gm-Gg: AZFdTZdyjf/y/jAlkABiFZMl+3orbRep0JOE1HdX14krlBWoyh/PchIC9ZtwchE5wsM
	Qu2zqmnabZpxthQF1/lll3d4zK4suQ3RlFYh7oEZOzhef7VS9kh/NyMmuy4jYihcBAYemYU8EbC
	ZvzEWUTEkTDLjDC3F7ADpIALr1MsO4GiunUoqOhonfw6q1zmxRd0L93MedFm8YnEU/O4fBQAj2F
	wboLmiRaP7YU53PD6wIviyjzclpR5CMunIW91OSVkVo02eFUbLeTZmB9K0QVNIg40+AyC1Bjg/V
	e3J1hF3EdYlI27FhPnPV6pa2LqFN1JCHF5ax9K2UnehJnPK6jTtGc2BunUVD3V72RzLAGm4CWrg
	xf21ZWrpJW1rmOnFHLwyDGBvZY3WwaaUL6Wl++cPguBx3/HlAWYZaxcg9tmwh2aunJlC/usO6QP
	4HgpWaz2/BsJfqnsal+em7HEzERlkJIZGHqtOX7gcZmGJ5jpPpuS2BoxJz9UAhbrxw2KnoOCPXD
	HVA3jfzllnn3yHLFG+jEjj+EO7GpUY4Mg5rrn48thR9eYiqWgy3fV8zqBmC1CsRL0U9tf9ZuWDZ
	lll2bR2GqtSAj/kZ63yGJdVG2ze6MiMuzAji2AGrEINVAQxjNFbL0Aj0oz0=
X-Received: by 2002:a17:90b:4f85:b0:3b0:91ce:6720 with SMTP id 98e67ed59e1d1-3b1b0a1ef3emr8998420a91.30.1794818355362;
        Mon, 16 Nov 2026 00:39:15 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:90a:5f11:9056:5eea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm20238697a91.15.2026.11.16.00.39.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 00:39:15 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	brgl@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_bgodavar@quicinc.com,
	lumag@kernel.org,
	mka@chromium.org,
	markus.probst@posteo.de,
	shuai.zhang@oss.qualcomm.com
Subject: Re: [PATCH v2 2/4] Bluetooth: qca: Power off after unregistering the HCI device
Date: Mon, 16 Nov 2026 16:38:46 +0800
Message-ID: <20261116083846.85334-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <179468159400.2456.12381703314197227930.wcn3950-poweroff-v2-2@michaelmcallister.org>
References: <179468159400.2456.12381703314197227930.wcn3950-poweroff-v2-2@michaelmcallister.org>
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

Hi Michael,

On Sat, Nov 14, 2026 at 06:39:54PM +0000, Michael McAllister wrote:
> +	/* Drain HCI setup before clearing protocol readiness. */
> +	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
> +		hci_unregister_dev(hdev);
> +

Moving hci_unregister_dev() ahead of the hu->tx_skb cleanup also closes
an existing race for every hci_serdev protocol, not only QCA. Since
21139b3ac62a ("Bluetooth: hci_serdev: Fix use-after-free in
hci_uart_unregister_device()"), unregister frees hu->tx_skb before
hci_unregister_dev(), so a concurrent HCI close or reset already inside
hci_uart_flush() can use or free the same partial frame. Calling
hci_unregister_dev() first waits for that path via hdev->req_lock, which
hci_dev_do_close() holds across the close.

What the series leaves open is the same flush-vs-TX race on an ordinary
close. Your HCI_UNREGISTER early returns keep hci_uart_flush() away from
hu->tx_skb while unbinding, but HCIDEVDOWN and HCIDEVRESET both reach
that free through hci_dev_close_sync() with the flag still clear, and
hci_uart_flush() does not stop write_work first, so it can free a
partial frame that hci_uart_write_work() is still sending. With your
series applied, a test hook that keeps a partial frame in hu->tx_skb
across a close reproduces it under KASAN: a slab-use-after-free read in
hci_uart_write_work() and a double free from the close path. The device
reopens and transmits afterwards, so this is the live path rather than
teardown.

I have sent a fix for hci_uart_flush() that stops write_work there:

https://lore.kernel.org/r/20261116080538.66575-1-enderaoelyther@gmail.com

It is based on bluetooth-next without your series; your HCI_UNREGISTER
check in hci_uart_flush() goes above its new lines. With it on top of
your series the same test is clean and the device still transmits after
a reopen. I will drop my narrower unregister patch in favour of yours.

Would you consider splitting the hci_serdev.c part of this patch into
its own commit with Fixes: 21139b3ac62a, so it can reach stable without
the QCA power changes?

Thanks,
Zhao
