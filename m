Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416344;
	b=x9WjWGUoj4d80MWxK3Hmyr1HnNWtoDxxWkCYmVVGck4hCuSV/NQXUruyluR90mvHk3cM
	 CIDkG/u9wfAmTAPCvxW+qr9HRsh3zDSFNEYytJGPErr7N3jZnsxA2bhO16jAYNkRp7ZZd
	 Biml5cwnM4DfRy/CAe/j/L5En5dFxFd3fR1OQegAb6XDIOuljRcNy3mJnvAZdsPaQyTyc
	 GAzB1Tvw4wFk+Dl2R36EcISvZsg8qzEgzOZMh8MnBna+vG8k3J1tWxlH9uwaidVbk5zKL
	 U9zkbpCgXRDwYoOvaF5YcWHkW5pYOWyHp5s7nw8+JpqZANHMhHbfclngPEwrulRrwzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0eBWPa8cQr7cuUwqTChMeav1O/tEZ2Hf5f5RCzHcADw=;
	b=a4RpuG85WhU2bYM416IIUio6TCOyZ1jr2y681APnsQWcW43WEh7xQHzGcSDYKgWzNcw4
	 CgNfTdhKfmAcSXxukkJaMeuUN1d6FIpTqTiEKdpGRfKRxf6T/rhD0t58D3gsDMWpcmG3C
	 1Wa7bNE0VIEUPDI+ApTZD/Dg5bmw1yCQjhpcDKTXQwuu3uDxte1IfHFb0uUN6phPu2aCK
	 9VfIhz90rw8Us8QuS4g65jT9nnEnE9MSt8H6eAPv3tbD688AH87CJG5MpUdTl+Jn2Dp7X
	 YBqV0MK+cZMepibWw8pWt83mRvnPawl44WfQgYMjXkV4mVNx+McDIvNTz0wHADDtB9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C8GBk3ll;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C95606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C95606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C8GBk3ll
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1764474eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416343; x=1795021143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eBWPa8cQr7cuUwqTChMeav1O/tEZ2Hf5f5RCzHcADw=;
        b=C8GBk3llfslZqof9TtkFEutxX9Q6ya1juo9QQqOdr1ZFwJXx6glCMwi+tsd+vicYAo
         xF08ddHEcH7Z4onU+jGYvaZd5oCJNgvmdfyUl6z3Huk/XcSXP1kxFSZmvoU5YxnFqHMK
         cRwAaTcmbqYwqgd325hDhEC8nt0R2l0f6s0kvBZuwKAQ/lyfuZKiRbAXqJ2EO1TmTNEU
         QdLMm1nGYJjQfZNTP3gxgcmnUWfw6k7X97gk1yc8lAcf1Knx7OFIafz6Ny07U3hxSsBE
         bumPftwlaSzZhc7V4BAnddudwnDFEN3EDQ+clFJ7sI9BQmP/7Sxjvc0H6k+lMu6YCpXc
         RX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416343; x=1795021143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0eBWPa8cQr7cuUwqTChMeav1O/tEZ2Hf5f5RCzHcADw=;
        b=IL9bmO2IZmKhvw0f7c8t3sqzj+JOd3kcxf+icU+Sgl91qqtv4qSv2xSeIKgcRk6p+3
         ex3T0ccDYQ6EI10H/j8jt2/O7hYzQYHlWC7n4xkOdx5GNswKvpeMwiN/M3HgQCFyEjf9
         aGZA62qxYQG8irkM/8jJmSKkCIi/i5iQniXwLtQs0WnX/Zoo6YAo+SyHzoH3nVaGvMlF
         eeiLSNgVLjKGH4Lty9UrrJWzOlr9EfhYp4K2atFIzUFa2kj4ClIfbwFZG2E7b29nG4h6
         w6qAU9xLu9Dpx/f+KOliHYYsAbZZuJNc3OX1LHoW7JWaHCSxbsJZDEWC54Hs2HO+YN8X
         kywQ==
X-Gm-Message-State: APuU4Z97bOJ0m68qrbDclEQY1LVmwvFVzKOtOUcsZv4TrrM6a+vrZBzS
	60+tTiCiDzpXHpbsJ+oEZ2xUgG+nCWI/+Z4WptbdybhvnxfSfnJ9HROxrKa5T1z3nxc=
X-Gm-Gg: AYBFou1XdHbY/z1/a1fhst+kzAdmoeSAUn6ZsSqeUgpmtQkQmOmhPG/ykP5BG0lqC9H
	968SBHrXp17+njH3cpNJiK1fHhzEwK1xRXlw/EJfRNjm4/4PkJT1OGRI31dalCZDzj9A6+q+Uq4
	xNU+fvvkqsCaOK/kGA4faAXyyQE4O1O4kVpU/BDXxfe0lQbuKrul25J9PJgzi1Bdz7uU3bAIuLv
	gZVkd85iGNPzHtvMzpJYIjvkDvwMcrNHy0vrOc9QKRvJ/CGUu3y3URzo9UMbTCxwhTH0Pc0Y+SE
	MKxj9rSn62uOS00vxHsd0uB8gfG3XlB+Q2RkTFhr/VAApUi2Rqvx2dW23NiK6gez7IHGafW319T
	iI37zTUhCTdABmht1orgwPpe7H118HehgukdWHx5dIrGsXrjlPOtjg6iaoUNdQIGaccJtDJvK7O
	Kyo54h9d1z/rb2agwwAvQgTLNMX9mcVr0ZrQ6M45aTPTXJETYuNy1i31nucE/ijaoWw+XsmKRSJ
	uCcB838fYYh9KAK/Tpx9rpXa4es8MtulfuImVVya+SR8mp5ePpBIL316A9y4hIa5mpUkcfeGSII
	tsS13OtteOQ/ho6rCuGcS4rBd9LGFDdy/lNlomitECVFGSe5dWct8Aigoq5SnySqKaEgZGN9kVU
	=
X-Received: by 2002:a05:7300:b50d:b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-37686d341f9mr4275618eec.29.1794416342949;
        Wed, 11 Nov 2026 08:59:02 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm21054406eec.19.2026.11.11.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:59:02 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_event: Find the instance owning a terminated advertising set
Date: Wed, 11 Nov 2026 16:58:59 +0000
Message-ID: <20261111165859.829141-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CABBYNZLOMQxS4dRQxQaS_bS71p6YWS4We79bQ--A3dapEYRK0A@mail.gmail.com>
References: <CABBYNZLOMQxS4dRQxQaS_bS71p6YWS4We79bQ--A3dapEYRK0A@mail.gmail.com>
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

Hi Luiz,

On Wed, Nov 11, 2026 at 3:47 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> While it seems sashiko didn't find any new problems I wonder if we can
> eliminate the double lookup since hci_remove_adv_instance will attempt
> to lookup again the instance, so instead of calling it perhaps we
> could free the adv_info directly or via a helper shared with
> hci_remove_adv_instance.

Done in v3 with a shared helper: patch 3 adds hci_free_adv_instance(),
which hci_remove_adv_instance() now calls after its lookup, and patch 4
frees the instance it found with it:

https://lore.kernel.org/linux-bluetooth/20261111165133.827594-1-weihong.guan@gmail.com/

Thanks,
Weihong
