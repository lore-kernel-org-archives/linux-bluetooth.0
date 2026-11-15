Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770371;
	b=NRiwqzC8PXpE11nz07LG34Fpyn0ZxsPLaDaNoNJyc9W2Dg/UCrj4w95auktrl+4WIUJe
	 BGzb/h+sO1fTfWWOHO4BjP1Dj3y2O/687haahbJ1QE1n1nuR69iGFmnfzFIQTkGValWsI
	 yiTzb1uy5F4JrPKu1pdHotnYCvxiDzPAvl7oS0sB1B9HcSgdSvBLHH6ZD/EyueNej698s
	 /ky6muLUBHdXQ41lJuA9kYK5JyPHvlqwYImQSbEjYr1qvikCssWJd2yI4JhEEvQenukja
	 Mms1bwmE7cjhhvZfkGGcSzctFv4iu9mII/tDxB/ZFRbRTlf9FM1cJpF+nfTKnFaCjwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rXWeIvYTRoTsWxCLSB7XcOeCQxgK4LpPAVA+4Js8Ulo=;
	b=YiHD63UhSlwhcf6tTYj39rJkiGBDqrad9hfjyzIisVlCqRhKurRE483WxdwPmfbVLtHx
	 jdlmq40gHXTiVPmBO2hEhKR8Y5kMMVbuSZ0DiMoR9bQlff9ZtPaH9H4C3cfwm5IZiIa7L
	 j8YLYgVLS2rw27c2RG9E3G/zGZGBqW47Ti5qST8kyDco3+KMZY6czUcTnOdKby0pgFcxR
	 HqXvNGxSTVKvAqQ9a4GRWW6DqHBZgHc+bw6X25aAwhGdxh+2ZCV/PgRsYEPSOIL3zhlKW
	 HnwHkmK03qoTKIC9KO16XnuOaF6PbZFabntZbKeiDDXS3hZZKT3soXI1A0S4QINrFbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFCDXc35;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57507606A329
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 19:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57507606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFCDXc35
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1346832a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 11:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794770371; x=1795375171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXWeIvYTRoTsWxCLSB7XcOeCQxgK4LpPAVA+4Js8Ulo=;
        b=lFCDXc353drcP0VhXxukiRXoev8GYVbOQJE1cLqe1/jJtqSRbl4QdZ+MIzI7KHqyMp
         oqyyPv4FemsogmCjW1/jHmwZkDMeV0fMc9QWknlHqSA7aGfpiEtJVCQGns2qgXG173ad
         Q4rS6fGSCqNP66tDpFbrvXvdUx+zX53m0ZIOYR8s0kzUEQw2m072xJIY3zoWN4wILnuX
         FKX+q0f7Ca6docMc8L7A3eBp2eU1fRDoloyjmWZRNdFahzRO85lJxxAgLvha2ImXIBEB
         cMDSHxYyFoF8UBPIf7zQne7KHp8eb4xXN2fwbLh3zI6kLif7EyVXGpieA5lymPilZuHn
         jZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794770371; x=1795375171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rXWeIvYTRoTsWxCLSB7XcOeCQxgK4LpPAVA+4Js8Ulo=;
        b=WkAQiXUbU9bA4qAQOqBeFoydW4lH8lhf4nGHvcxE1foazZgAz+EMYwthPLdxKo4bgX
         +QG8ksrJcMWZ+IQIfU4Cs0Z2m+Q80hemJf7KpYHyrPmjB/gjzcduzQBdS+ayfeKZ18Cq
         TlLa266pq1v7eZZX0r82+nh+lSRpj2gFVLMalAOM+7Db9BWnEweT90FA4J51LCBBBsk/
         PfuA63hbz/1v10kiD/giNZo8nT+wHJ8AFjiTbNwT+qUWm9SSaGdf0PmCDZgi2XC/3VXp
         pKazBA0LDv95G1kesbXiRw97NVMS6sgiRZH3mVIPsCorApWJZ5srgPBX7W7ZfzN4zQky
         4y3g==
X-Gm-Message-State: APuU4Z8IJdkYhG+m+UQUQUdxy2wg2iNX+tKIXGwN8HSdYE60k0zLexu8
	kx+GbOFosQosh+8P9zKLp+2WopD5Pkv5BOpIRNzCQPT8JjjuXR9RYLlm
X-Gm-Gg: AYBFou2QYsdQYGvQlhC383O1raLmMjm6H5bYc9LoHm8yc6D3ZPudbVQKkbYiDM/VIJQ
	74muss8uu9AtYQVYef8IPiMMy9qGbyhMbMC2bjhdd2T5lCJHA5wppoQ91yQaNNwjV/JY6iC0pGm
	uEPOQxMHqvCojo8zipk7XG3XOUHNvwBPgkPOQSyRgy8PEUI6Uqn9IU2TP4rZpHxzmAwa2QxW8u7
	6bMROlQn6BWXnnDj6Kk6frsazb9YuDwSFeUK2GysWjq84wl5nTugQGf58zYMjATWBf+MxrhtVpL
	emWmE2NDMb54PwwsX2XFYFg+Hq9Q5RqR+Fy6MebY01bhxGJ9BO4XFJOdzPF2J2Yl+9+cVwbG/wa
	Y2HlH0f+3OWFrkLnkuqxqU6gUznyFzreXiYXLdNwYz4f0TGa2/uBC4E5SzA8dlt0MS+gJoD93gd
	OQvvgkPCEvZ5nu0mRulnlywFS3anK7Dht1AXhuvkd6vSbSNHapPhsgqtNbsTP7nTeio4MZiKK8b
	4pOhnP0qusWDdpMKOCmzY9yJoDbL9GI76areyalJyDc1ckO2hyBW2plII/2RJri8Bemy1U+8SKN
	b3+wXUkTSGVKPfFPDF64zu8yP3EQYOLEa/PmXaGyzuwj9Po+HLhoEg9i9b3B
X-Received: by 2002:a17:90b:28cf:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b1b0a3e997mr7620270a91.26.1794770370581;
        Sun, 15 Nov 2026 11:19:30 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:d1be:2710:af83:9beb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b245f0c3sm6972378a91.0.2026.11.15.11.19.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:19:29 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Hang Nan <2122295973@qq.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Pauli Virtanen <pav@iki.fi>,
	Cen Zhang <zzzccc427@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Mon, 16 Nov 2026 03:19:08 +0800
Message-ID: <20261115191908.3646-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <tencent_D6C2C07E8FD8FC290CA9F9AB237DAE4CE505@qq.com>
References: <tencent_D6C2C07E8FD8FC290CA9F9AB237DAE4CE505@qq.com>
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

Hi Hang,

On Sat, Oct 24, 2026 at 08:22:17PM +0800, Hang Nan wrote:
> before the unlink and drop it after the notification.  Lock order is
> unchanged, the child lock keeps cleanup_listen() out until then.

[...]

>  		if (d->state == BT_CLOSED) {
>  			sock_set_flag(sk, SOCK_ZAPPED);
> +			/* keep the listener alive across the unlink */
> +			sock_hold(parent);
>  			bt_accept_unlink(sk);
> +			parent->sk_data_ready(parent);
> +			sock_put(parent);

Whenever this sock_hold(parent) actually prevents the use-after-free --
i.e. cleanup_listen() sees an empty accept queue after
bt_accept_unlink(sk) and the listener close drops its own reference
first -- this sock_put(parent) becomes the final put and runs
rfcomm_sock_destruct(parent) right here, while both lock_sock(sk) and
the child's rfcomm_dlc_lock(d) are still held.

Unlike l2cap_sock_destruct() and iso_sock_destruct(), which only drop a
refcount, rfcomm_sock_destruct() acquires the socket's own DLC lock
(even a listening RFCOMM socket carries a DLC allocated in
rfcomm_sock_alloc()). Running it at this point has two lockdep problems:

1. The listener's DLC mutex is a different instance from the child's,
   but both are initialized in rfcomm_dlc_alloc() with the same lockdep
   class, creating a nested same-class mutex acquisition.
2. rfcomm_sk_state_change() enters under rfcomm_dlc_lock(d), as its
   __must_hold(&d->lock) annotation states, and then takes lock_sock(sk),
   so taking the listener's rfcomm_dlc_lock() before release_sock(sk)
   also inverts the d->lock -> sk_lock order.

I caught this by reading the code rather than hitting a lockdep splat in
QEMU (the window between bt_accept_unlink() and sock_put() in v2 is tiny
without an injected delay, so the final put never landed there in my
runs), and I have not established an actual two-DLC deadlock for (1).
Still, existing code already drops the child's DLC lock after
release_sock(sk) around rfcomm_sock_kill(), with a comment saying
rfcomm_sock_destruct() would otherwise dead lock.

Dropping the listener reference there avoids both issues:

	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
		rfcomm_dlc_unlock(d);
		rfcomm_sock_kill(sk);
		sock_put(parent);
		rfcomm_dlc_lock(d);
	}

The reference remains balanced: a child with a non-NULL parent is still
queued when the hold is taken under lock_sock(sk), and this callback
sets SOCK_ZAPPED before unlinking it. If d->state != BT_CLOSED, any
concurrent close of the child must go through rfcomm_dlc_close(), which
waits for the rfcomm_lock() the caller holds, before it can set
SOCK_ZAPPED.

In my QEMU/KASAN reproducer on commit 6b4b543fa187 (stalling krfcommd
with an inbound packet flood while closing the listener), the base
kernel hit the listener use-after-free in both boots, while dropping the
reference in the SOCK_ZAPPED block above survived two boots of 826 and
831 rounds cleanly.

Thanks,
Zhao
