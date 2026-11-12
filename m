Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500330;
	b=YZjMwqytHChnE6xewGhHtFyFPnrTIAXcayFctdg1U52U5udA42Cf0xNwX2yXUS52DUgZ
	 1b0tBMctxaRvxTvt3badzynViIHQRZDnTXosLfsY86rIiYlsbdC8dA1orlhIgW2GvXFOc
	 8h9rty6SH4MQoRvdLmHejpF5rSP67fKGOKUw2a7bx17s8rkAFlsh25eP7dn6LE/4j7RBA
	 v/MmFX90kAe5xHI/AKx/aPnWNq3wbiVHqXLJVqwfyInqUAxnq7EbAdrlw9mSpdzoGvI1F
	 TvNBf2QTkBUYChkAEghN/xPuRteDfDC+S4W9Gja9bzBlbLKO58e8pQN+/ut1sEojOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4nva8r1Bdce1vFBokpy/40rMuU8GnBa34iO9dH7gHyY=;
	b=VBEP5zJLBak/pEk/5TpENMrCLvW8vbeQIgSpmZSKqbJGD043quaKXh81J/BXc4Q+90cs
	 f/SCmRYUSE9gUJd1OURJGNJMrcYqeXFZl3WWPNSY9BtdTRDjAofuzPzRXqqnlwhrgml5m
	 5D5QZFGHn//RE/ZuPrzA1n6U94+V5wccVbQtgto56OQOp4pM/U5RLrSvffV4+PrUjzmar
	 e+aPO00AamtvabgwTaAVXgqRjbXhOw+FRsUCEcxx9FcPZ/ahMKJXa/ULUnDecGfFJkiET
	 0uGek4b3ScgobV6HaT9SF1yCF7RaH06C5ax4lDLQ6WXNSDXDolIgJUzysUIKmsnuz4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irFJovId;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27664606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27664606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irFJovId
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ea16d8072so34013556d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500329; x=1795105129; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4nva8r1Bdce1vFBokpy/40rMuU8GnBa34iO9dH7gHyY=;
        b=irFJovIdoZTf3w0MFACg38mgTUwOHfbgepZ+mG9pR6JfeWl7eqPGbLb7w45XA3Xfuy
         ilIWTGDrkIB6by3cYo65v3IfW1Aoecbd1cQaEYoUGI9G42KU6bhGeHyx39fbiZmGb+Fh
         2BRvFkf+Ma0XQkEI/iDHCT2yzlJ6SLX3jiH9y9bm8Xvm4Bik/RK/WI+ixG3gbGxmnIHR
         zePzs+lAEm6J5o+frtf/C5j1vv4aGKQDAp2ESDv8Xv6IgrvnVnnbWXRb2I31wgQ1i6bJ
         aCqTusRa9FqmL9XntZhj1NlcGj/a4Oo7t3zi3k3Q9az8bAX49gfYzmsA5OSTImnfX2+D
         4ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500329; x=1795105129;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4nva8r1Bdce1vFBokpy/40rMuU8GnBa34iO9dH7gHyY=;
        b=Dq0zWbg39tSlDMN9M5JeLx9J41nI8qO1kqsEt+T9JvgswW1NFAd4Bb7OxILhPwqluD
         2DabWVb4ZE6JAzn0fWEBqgL5Pc4du7PVju7v5Mj4Qs+6qfucBdsr9YPXOl6rMMoqy7nn
         SVHjYiL4hmEgjaFqVlId4CVCHDHOTtIR0GIKE4BPxI/JG3iQmjWhtfO1P+JXzwg1Ggsl
         6doCnISrehCFjCqHfBR1O7NJfbLqg5rdA7lY9/WnRxZjCoB0AxHZJWGyzbYOYf0CRw4Y
         tp1J8NtI3CSm9cm/wNmz1QNRzZsE1DCd3qfQIQG+OFIpaar7nAAo+7DbEtYKxupIW15a
         Q3Ww==
X-Gm-Message-State: APuU4Z8sUCVSDZhL7EjyXmOwEzEZLGLoesGCuwfUwV104gh/fIdesT+k
	rkrI8a7gkvhP8lWlTilO0SF5ct/KFT1OgyWXPO74i9ApSKFh9adbnbL4iSYsmxh9
X-Gm-Gg: AYBFou3mprKNmBRgAknB8EEa+TzABNhnoxwHcE3KO6Eg/yV4WufgeSn8nb5k48+rMjz
	kT8EZ03KZrO99t28rPLXTI744MsWsboMgILEcChXf38kFbFMbGUm7ErC0XwJJdO/kLx1EAsGvXk
	Gows/6R3yOsS/NRPb41wc47HB4YwPuvfcNItys2Eg+dBWz2wELi0hJcJ3nSyuBHjybDPLQBktGw
	06jfRd0J1YHR8Jl86tkSENyXosWFsIaDaDY10W+jsvQWleqq4gw4OxNnNnrHN9izWd8sDvsXTXe
	4L6TmU/L83geiQJC59M9XjtA+0pai2BhKRaJVBBr3Gb5axSyBQl2iAgDWF6hN61jdUvdXZxeceB
	fxZzUl9U9f04Atv3LqK72RWaasckOy5nUEbVnUXC47d3vmo6pX92IE1KIOKr7E5twHRAGceNy9j
	ap0kXrCvbUcO4xJ16KpSfNRyzzTc8Vc3HbfZydpfRe20bQjmdHQictnZHZz7u33KSMRXpZ+gDGD
	1Xrj4GfCThC/uaB1SrivfUDC+4mic1zyprHDds3qC2ecYj4xouS7WsESDlfRA==
X-Received: by 2002:a05:6214:3199:b0:91e:8cb1:b84e with SMTP id 6a1803df08f44-91f040ce67fmr95327706d6.24.1794500328517;
        Thu, 12 Nov 2026 08:18:48 -0800 (PST)
Received: from [172.17.0.2] ([68.154.79.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f11e2cd01sm27502756d6.38.2026.11.12.08.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:18:47 -0800 (PST)
Message-ID: <6af5e6e7.d2b3e211.3c5acd.5a1b@mx.google.com>
Date: Thu, 12 Nov 2026 08:18:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4821565533165051291=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RESEND] shared/asha: send STOP without waiting for a response
In-Reply-To: <20261028133034.261833-1-cochcoder@proton.me>
References: <20261028133034.261833-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4821565533165051291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RESEND] shared/asha: send STOP without waiting for a response
   Pull Request: https://github.com/bluez/bluez/pull/2727
   Created:      2026-10-28 15:20:40+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4821565533165051291==--
