Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF025B0A5
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jul 2026 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785073089; cv=none; b=k03NxJT5SS7Ij+PxGoJN0cHPX6ii+VRJAA2rKxql0Ar/Q6YdEhMkD6C4nE1I9fgsbNvwmgO7HhV90I8E8FXXbJllR9aJDkck54iO1bOmWLX6FdFNoSeqRui2tBdA4825p5COnXqWDvOl6gNk1qzzf19PU2QoZh+vdljCE0FnPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785073089; c=relaxed/simple;
	bh=NCIHeDIA/4OImcgoZmMiczVVh4u0wDhubbPjsAOYTGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L92U957qCaHYmIJlEy4kfMgZiXrVLdHsJoAikdFnr2AVxcXnbM1T0eghUvNy7uKcfmKcaXMpGfpImNNexNiLBXgEZ+s/4ZInhQTl7a72kiu2iA4HKlIDlU8E/O5AWAtQrmMG3M3R8P+vLiEf46Emy+6u5HDfnXO3/MpS0Q4nki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhnO3xQu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhnO3xQu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1424764a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jul 2026 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785073088; x=1785677888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jysWq3C3ThJMdK6hdhgg2VKXM1RyHpRSI8wbIXfJEBQ=;
        b=OhnO3xQuNdqSujl0XWl66eTW9UCsMiwo9BpnV7qEdSh7OI16dnS46i2Y9nNb0Pdsxc
         lwiNbQ8Sl2tpwMZ23xSL0gC8gieMkzv2wlbFgY3ehy3kgtN8O1qMegdJxP815KjgDUKA
         Su/iM4f9zCBxZWauu2tkTqijtcC6aw9F6vU9fl/co8kyDfTq9h7qF65oN+So8+1dTRJQ
         MN3B9KaOoOvf2wTRNJrXF9mgD+UwKBTcmgWdLkrU1GGaYtzTByG4TN3bht0KVL1maUsU
         5zRhrTFISXogodbfOqNBY1vWGFOdPSX2Ef7sdNyYrj4ilnkDWU3tkPJjlSMiCZ4eQYX9
         Eu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785073088; x=1785677888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jysWq3C3ThJMdK6hdhgg2VKXM1RyHpRSI8wbIXfJEBQ=;
        b=rShPA55abWWFaalz6m/fBB0JmzgicuCvGkSERO45g9wbDjzo/kMJxXgWVgKC2Wi76O
         QDFwFSrvh3P0ORsv0zF2/Le29Q0y42LTPm5lXj9ZEcShIGleDzZTGYt8r7jLH7i/RtBp
         1DTeYg2xfz9fa2zrdtfQrbXE4AZiWUEWB+CF3WlPmP+9yrwn93C0DlsvTeHGrBxs5xV2
         CCUYH7FbhEJHzj3ZuSRFW/jocEJI4Ti3aJVY6pBK8htQ6c+2vpO8bqdQfvb2vjEf0JvL
         Uw4BZYDD5Hzzbl4mRh8u2IUl4AdpnMt7rvFUKinQ71hXRYwzVQcUog/XeISNVUw/UdaD
         mQIg==
X-Forwarded-Encrypted: i=1; AHgh+RoM+Vkx378HvWg94jhqZD8k8HVcYlzKT+opUFMUx6itDz6+qCIKfqy2iTqzsV148WbmWv2i9A8UqBbWY6kO/gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXFe7khmmELHROTtuB95WwnBLyeWKTgHkYbYhAz0AT11wlOZX
	FQ4OzfAQwgdGoFDvyoUOYtDfw4Xl8hUfWtM5HiKf2g06CdK2PXBfmhAk
X-Gm-Gg: AR+sD13k2DNzS6G7Cr6KhP7GuyNZN4RaR1tNDXpUS6Quaj55rFwbCxGFtLNCVJyabbC
	8GwlunpJmRKakOdKStAA2WWlcnfQCkXw/k30t4k+27fiEYpqZXonnYBAOMBsKLoOJicPSfVY99m
	qvy34i0E0YpHuOs7rK7wc7Qt71Av7ZMVk7F2jqYTvAj8x4ur47oTOrsL1QQrgjBpGXVuLa9/2F+
	c3ZPHOoKVHfBzcCWoRlvEAD0LM/kcupWyBKX93R0KUL+7OksCiBimCavY4Mq/XLv7qXr9pKw3Jh
	1xMo09XQUCiBC0Wfka5CrVgTlNGo6CnJCyTnU79/fqLI5X76eaGlEPC2ANhZdoKapMPjUbDSMuT
	RKWUF+2PJnLDDivVZSKTSA5jeQGDoy6SlkjyZsY3Hq5mNZR8Wms7VudgCXnG40o1dP6knGw==
X-Received: by 2002:a17:90b:3b41:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-38f293cd1b0mr5348250a91.6.1785073087936;
        Sun, 26 Jul 2026 06:38:07 -0700 (PDT)
Received: from beelink.. ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e53094d65sm15280380c88.13.2026.07.26.06.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:38:07 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Baul Lee <baul.lee@xbow.com>,
	Pauli Virtanen <pav@iki.fi>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SCO: fix sco_conn double free on outgoing connect
Date: Sun, 26 Jul 2026 10:37:40 -0300
Message-ID: <20260726133748.437733-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5e2a239a419898c87e80ed360b06e287225de00a.camel@iki.fi>
References: <20260726055431.42350-1-baul.lee@xbow.com> <5e2a239a419898c87e80ed360b06e287225de00a.camel@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pauli, Baul, Federico,

Thanks for looking at both patches side by side.

To connect the threads: the "only socket owns sco_conn" approach you
pointed to is my v3

  https://lore.kernel.org/linux-bluetooth/20260725195230.967546-1-qwe.aldo@gmail.com/

which is on the list and passed sco-tester in CI. I found and
root-caused this independently and posted the first public fix on
2026-07-23 (v1), with a /dev/vhci KASAN reproducer that races close() of
an SCO socket against an injected Disconnection Complete. I see from
Baul's patch that XBOW reported the same issue privately on 2026-07-10 --
I'm happy for that earlier report to be credited (Reported-by, or however
you and they prefer); I don't want to step on it.

On the substance I agree the sco_data access needs serializing, and this
is the residual UAF I already flagged when I sent v3: with the over-put
fixed, sco_recv_scodata() still reads hcon->sco_data under hci_dev_lock
and sco_conn_hold_unless_zero()s it, but the clear in sco_conn_free() is
not under that lock, so the read can land on an already-freed sco_conn:

    BUG: KASAN: slab-use-after-free in sco_conn_hold_unless_zero+0xbe/0x160
    Write of size 4 by task kworker/u17:0
    Workqueue: hci0 hci_rx_work
    Call Trace:
     sco_conn_hold_unless_zero+0xbe/0x160
     sco_recv_scodata+0x13f/0x490
     hci_rx_work+0x3af/0x730

I'll send the serialization as a follow-up on top of v3, along the lines
you sketched: clear hcon->sco_data in sco_conn_del() under hdev->lock so
the field can carry a __guarded_by(&hdev->lock) annotation, and -- to
avoid the "SCO Disconnect - Success" regression you spotted in the other
patch -- give the socket its own hci_conn reference that it drops on
close(), so closing still tears the link down while the sco_conn keeps a
single association reference cleared under the lock in sco_conn_del().
I'll only post it once the reproducer is clean under KASAN and sco-tester
passes.

Thanks,
Aldo
