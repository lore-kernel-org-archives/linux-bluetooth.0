Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326578;
	b=ijjZijl0l5lWR3CpHPC3GQ/XDZeKJ2WhzjK2kKwn3WqogZsN7SdU0HtSztlzLd0Zk8Jh
	 1B0HSQ5UZXvI+ZZz8dm4Hp+w7Ene9Fz8x0FmeFx6W6xPOu3PpR4uycAXE+F/kguQ62Xcd
	 0SAAJmaI4G1laI3YoS+tQ0IvlTF0dWD1X5B/qt7EMIzHv57tOLGd86EtF4eQYVtPduIPE
	 aHQTKrwbfhLY9GcGwI/S7ezylwtmEIsJ1FrgjfLFNigjUwqkNEtygBbMROWkg6bfy+MWT
	 thXcdKvvSJu2fawfExiwioiLBkN0nEE3vwxEbufoaK29SHZDSpKSTEemSKDgIXNs4zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eMWWH/LmhxSxst3n9cf0bG8rsIDAnW9OaCDvXnJIzO4=;
	b=1mfYOQwgz8bh/VPoJ8CmIYO+6eDfYkomLkGNw2+uU3H2lpkI1a8oA1dj5o9IsoZjDIxt
	 b/TxR5PUrtWzIA+RXXxv3bgMK606EJRbeC0zCfkGhcGFk647mCHOsCkQ3dCKBtvbfRnaU
	 cXlQHuSWsPrsOYDNLPA5CGit/hMkJrzk5YwuDg0xKDtmvuff+RrYFbTRPMiHEteeTw+67
	 TbKRCbSnNKA6wInZgeCS9a5AFYFir4cPGlWGxE0BWCxF/3QnUoGTsD32170+iaOyi6nKy
	 7ujrQiIK++NiGpn+1zMbE4hbGnxJcv5nxcTU4DRMVGKxddK8k8zUOJs5PZ03WvTacpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eQH7VsXR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37B606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A37B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eQH7VsXR
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-53656465d1dso1019875b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:02:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794326577; cv=none;
        d=google.com; s=arc-20260327;
        b=gj+BcY7rM75Aov2Xo1AHYixM6VNR5FL/+AOs1exL7yOk6GaxRC8X0LTKDIKEef4i3n
         qXPvtaaMjrtzHhUbGOrX6W1xdHsjF6XlE2WjPYAxd9/uy3+xDRMyS1ugkuKGn/NieQnb
         8o1YZTptmcQ9wbZZKNfn4HzDrofpyjfYliT8O5xPg2gfwG67Jbed4ZYDGsdmsQVOdWP/
         7lLRJskpUxrfGromOaAthkFMdMqC2xPLkxMG5+US/+yPSibJQddcycq77ZWnWsw0pkJy
         PTGr/q0U227PnNeairRLSPBqV5gqDsAZbAQbW1cPAw348kr6sej/mfKysCSt/0Oy+i+9
         ZJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eMWWH/LmhxSxst3n9cf0bG8rsIDAnW9OaCDvXnJIzO4=;
        fh=Ca5a8utZiKF3gy/yEam5pubj+3vWOPdRvkbhypp2p2I=;
        b=n9ToA/FNrxyZCAzwfxDR5g/kQStzt7vvjjjqpfsNKyLIZJ6bnrHsJKvBdt4irP0sJL
         7acQ1tFDWfMOLsihU5FaMKBY3RJloal5h3o0wC5U24G7d45Kwa63sRgI7RR5xUoNBbVV
         3aB5lfvAqjFCseEOcGnea68PLuh42ylDEDnWPaRbC5fVyyt4B8TW0KkIUUhe9p26bFtN
         jMG5WH6qMuARBPGOPJk8Adx3diTceoM5rbUspjCk7wG6lWWYtPZETRrxn/XUHXGj2U1z
         unaHoi4AOKJIhAYW3hyuPg9Son3V/AMM4bldKTnSDHywHI+OlRmgQjDOAAqaMV1dE1br
         bq1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326577; x=1794931377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eMWWH/LmhxSxst3n9cf0bG8rsIDAnW9OaCDvXnJIzO4=;
        b=eQH7VsXRGRfZ17pBA2K+Vz/hfFyKWY3cFF8H1IZAsJgtBd9DHvFBLIkU6dPoXfmOZw
         zUI73S66Mv1d44ltUPrz5KDBNvt27M5o6nwvejPT00I8rGvr7aV4L+nDjlV7ozlPr/8Y
         GTbr6pvD6cO+evJwhNqGvoZWqNBjMGwQk4Ka6nUX0ebbCk7BMattF4GRiSnvMXSs+lX+
         JQkX9ksYugz6b+SumdxsxZyj/d0MlBByor2QQy+nBzncsvrIrYpwIvF5GOiId/lz/TWu
         Q5GoZbdbf3CWZpUHjs/yQYQIu4D4e2ej7Niw5/iOQToBDkEWzwc5iOyRi/CYV3iWjxYH
         YVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326577; x=1794931377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMWWH/LmhxSxst3n9cf0bG8rsIDAnW9OaCDvXnJIzO4=;
        b=iQF3wD2NQKULxcclhGrcwp1EQ7cs8SVrkua0xOBv0MrJx5NeiU+Y4lpvP1e9sLXiAO
         xusrDbKfzdzYDtA6X5+t3hgN57j8S8EiHIQIVBnfNIx6owOVQECLrNvJINGN7VUcPCgA
         VheuMxnN4ll8ISzJTPY202DINvh9QqFJSVxSHO/cMdIo/EEhxc5CRnaQXgxM2K6U9lJM
         gSogZMca+jekPzGmLiXtgOwvlWh1LvC5eBnIoRUz64uWwlN+095ku1CagmN2yWQ6Wf7r
         f5D/4wBcxi+WKZsnJUKNBPdBNj7z1H341ZRpN3Aaz9MI+YAOEGZ/vNszTjrt1J12Azuc
         Tz7Q==
X-Gm-Message-State: APuU4Z99SJOnEVUIUo629rofkLdCIKsP1GCM+1hxzoFbkJCpOGtFmktq
	iH7+A9Q3vIIaaDV1DGA9qYCEYMNbhxs9JoKapXj+ytd9quOZfP2nPLA5m3y3VMzGjQ/JEmw8znl
	xz1q1UTNNMYNC33eeox9B/lv2/+6F+I0=
X-Gm-Gg: AYBFou2GK490uAJR0pUx2u05tp2nzAqBQD1k6XZcaqD46vsFPRSKs3Ccy0c0jmJhUo9
	H2ohbtvzP8y+Yd4XxPITjYOVFBe2eRwnsMEKzeoLqTT1elZqisH1nh0nuA/Yas3V4nCZCU0hbOR
	Uf7nZECsrDiJ9tdltZrZ8warZaFB6KBwolu1KjeSTmMc8+JrL5boAE/9M61qFlN3D3ffuNpANce
	zW+LtVSwFO5+dZvwqN7h6vpg6wNp2ZbBnWzoJqWeYq3wokPpMhNmTTIFXLq4pHIznVlD0snrCs1
	vCRJ95RBtQyxwbnSb0H+2JE8vUAaZswOydfmJErKWcFALujFKO4Pr0h4x7VKWKGIqP0akLouE9d
	/yZrlpCYcNITXuGCUeydGiDk52hbwNZwXasiPfXVTvYXsRPaMI6ne7ZJbmeysa4Mtm1yiL0GE9y
	RQIezUzXDm74atCgARtdzx9Y8eyup5Els37o+9O7BRrKZ34PfGZXIQk6Zb6FI=
X-Received: by 2002:a05:6808:5391:b0:4ed:7045:d3bc with SMTP id
 5614622812f47-5683cc7ba5amr2364865b6e.32.1794326576833; Tue, 10 Nov 2026
 08:02:56 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023132421.1889022-1-weihong.guan@gmail.com> <20261110151627.625640-1-weihong.guan@gmail.com>
In-Reply-To: <20261110151627.625640-1-weihong.guan@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Nov 2026 11:02:44 -0500
X-Gm-Features: AclHuK-lTcbeZfIgCIjwbyEGj-aXCPida_gnJjtA0HVtnDg3JAV496Kf6C5E0s8
Message-ID: <CABBYNZ+h_7fpuKT1aa0EOEEzsJbNDRxgW5nBuWV33u+8F-bfAA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Use the advertising set handle, not
 the instance
To: Weihong Guan <weihong.guan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 10, 2026 at 10:18=E2=80=AFAM Weihong Guan <weihong.guan@gmail.c=
om> wrote:
>
> Hi Luiz,
>
> Gentle ping on this one. It still applies cleanly to bluetooth-next
> (hunks offset by 10 lines), and both commands still send the instance
> number as the advertising handle there, so a controller with a single
> advertising set still can't start an instance that uses a random address,
> or remove instance 1.
>
> Happy to rework it if you'd rather handle the ownership of handle 0x00
> differently, as noted below the cut in the patch.

Looks like the following comments haven't been addressed:
https://sashiko.dev/#/patchset/20261023132421.1889022-1-weihong.guan%40gmai=
l.com

> Thanks,
> Weihong



--=20
Luiz Augusto von Dentz
