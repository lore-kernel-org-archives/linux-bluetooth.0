Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B1D23E25B
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492892; cv=pass; b=sLNnK5Qij7x/188Gb/mtup19Apiu3QKgeFU/0vX4iDd3kFLpZet9SUOn5Y7q3MB9O+ZbdF02GaEeYPJzoh7uiSNOi/eqoDpLQ8M4mu5ylWfaVWy3ZpANl3RAzoOVSyGOjo0atmjmKKNpyydw/I9Bly5kV+/BtIUP+H/0l9bGmZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492892; c=relaxed/simple;
	bh=z4gymTGV6BiMiOHHpj5GTolc7Qp1ch0N0uJWIjJOI5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gECoItbi1qXMHMVgx/PayWwZqvBewVQd3ZWm6db2AD+xfysSMitsyeMnS522ywvJ2fc4dj+bLb5tn/LMyF6zIQDK7geTECMPa/ZOsvZQzbhyTWn2hJi+VKcXNmmksIg8W9HlDDN1CFGgz/vv1cd++7vn4Qda+Y5lc4r/Wsts1l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJISwLZT; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJISwLZT"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662fa4a4470so1420909d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 09:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782492890; cv=none;
        d=google.com; s=arc-20260327;
        b=NzRKAavZviz+NM1QLyXybqBFLWFmNLz0qA/kJHbcBN4FcTKrs8t7gy0N+ChkBFijgl
         ePg8Y9i8x8HQ8veACPEspCPjuMfPg0DOfvqyCbsriycDBNSNiwwZmG85WCpzie3+vTjc
         2qmfnRYmp69N4orfVOYywgSkuFaxyRk6/bIUWUgZ/Eey6Rg/1E0Q3YKDvaCH7jgllz37
         dJzPcZ7oFFfggRbYSYXU93a3bVKZ8+2J1EWBb/c3p4/tX1UVVrI7W5vLmilEMk6dpU5u
         6Pb+tvIe2PUtpQYgGEwVb40ubXaNtoYCESa2qcmtraiazOTIZdIeNinDHhSQ5jmbpwz4
         H3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z4gymTGV6BiMiOHHpj5GTolc7Qp1ch0N0uJWIjJOI5s=;
        fh=bukYCJ0lMozyuDaWhFzutp8GWUFUFZlXCHsOt4kpbuo=;
        b=BXF/7X/7cCh3/hXanJaHNjaeI5kBK3t7RyBkK3Iv2FygnP6whUPA1vz2FuELH+ggF+
         IbwIWl3kpTvKhVfgIJyrZIiMGuiVu+M/cVM2dYl9rUwJ31p6FQh4z9cBiRfC9hKK99iI
         iY5kvHhwnQ0T8qV22AByGk5uPQpdyejQxEGgP+Q3dct0qh0hv0MHxdvkwiy0hldrHD8T
         i8TSAKP8AXNcKD+3Cb6PJ3mrPoJB38b+kN475neTlplTZ1rAuIGdwWEhTVlV1fp7zslp
         vqcUUTUWzn00byPNTMkmQYMmtBM6bYVkKAzttLMsDEoETngYEIDKeTgvEZCMZb3JXVtf
         tByg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782492890; x=1783097690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4gymTGV6BiMiOHHpj5GTolc7Qp1ch0N0uJWIjJOI5s=;
        b=OJISwLZTy7r55ev0Z3RC3u91wzoWgfPJot3PIpacIPAk0zSxsTQWR9AlOpaaJuScfw
         kzs/9as4oXluMorPuvm5AXM7QBZBOeIPv7jzBjJSd21Kv+t8N+gAoGpKMEK/fl8o1XtD
         OGZpd/HTfHej8s9aLVDLXg7YtKY6aTz56hZu1xEzPiNi1KRdyyZZTSRoJbf0BU4FqxfM
         gDRx+2aEnQZnjBS5I+u8LC0w3cxscfhoTiZ22hCB5WWm+i9t12njJuC4NeqmbdDUbltf
         5l3Y6L2rzfLgGduAWpi6kQNKOR6YBIqjtXGCSgHg3mwYZAWCbILgIYsmKo6gZ6z0AzOa
         TcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492890; x=1783097690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z4gymTGV6BiMiOHHpj5GTolc7Qp1ch0N0uJWIjJOI5s=;
        b=bi1noqa8Q4JCeob7rQR8boEVG76dPd2mv64cOPxd6C82lu6m2HHaFxPFMyVXNg8R4b
         i1m7CafHXVzLdL3+2/FOwKe5LpxphTAzMXGf77d/8kvO7g34YuWa083M0AcEaH7CMszy
         skcKD8gmAo+EsuSyFBQsE//o8P8zi97ftHpCO6GgQY80jJZLDukOvLjlImEOBg+O0qAP
         38Iw2amsyvMBTIDmP6BQMpyTgef+iFl5pWtyN+DTYje5DmAbinOegzCjvB2SYcM6RCQl
         wHCr2c/6v3sPuDKvCwvORo4msATT7B4wZ4k1Wa2JDUsXB7osHJtpefpXBE2YEox1Fzi5
         Do+g==
X-Forwarded-Encrypted: i=1; AHgh+RrfodvD+Gq44pLkwpFCWISEMN+kLpoLnfBwmHHAA3wOXPyAYF4QqG2djt0Qf8GTQMk1V4bsbmecCziKh/oAdnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+sz47pkkobvinuXkqdoDqNxD2BbaCGiUFtJln+26+0ajXR7e
	TlbM41Yq3Ly0tspXuWUYCy73HX6z46KGde+AH4pfg0IOu5YTwP2N2PXoAZPY0B0oNtm0xdY3ij/
	DmCQIO5z810hcNvRbFRwBdn+THzg3ZTk=
X-Gm-Gg: AfdE7cnFH/VphdknyHAATrDwLtwqAiiuvO/us+Rz2DtL4aKE02XCDTbehXPs5o3AMXe
	9ZUCGw+BiAG7uMqInuk2zNn1ol7m+Xu6OQe48e6XdWQf/qdRTx6uXjUOyqP8lNWXFZjaQW6ctpD
	wPthdeAk5uLeObVfCCNzIxeceNuhFDCIJaoz8vkfc02QvBO9+geJDgmi8Ha4IHluBa4MdvojVR6
	L2DdRkKUMU4zZQAiOsyKXyZEEIYBKvlQdqL5W8tnuZNJSpab9pBWjW94p1RwMf5bzxR9fjYed6M
	nUEpfs0RHH50JxLp+3Fo6d3fh0qW/O+CNa3gC4KlGngmdcRxiWLoJAmT
X-Received: by 2002:a05:690e:408f:b0:65c:477a:2ad7 with SMTP id
 956f58d0204a3-66487e02906mr6126812d50.25.1782492890243; Fri, 26 Jun 2026
 09:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
 <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
 <3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com> <17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
In-Reply-To: <17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 26 Jun 2026 12:54:37 -0400
X-Gm-Features: AVVi8CdVv3HHwGMLXRaGH6j7p0AAQgeoBhar-UCT0NoarWVa66KqAbaQhtDgliw
Message-ID: <CABBYNZ+rR71SKUEuZBTf+E3SwRNzV2-s-zt8EwNJM3PSx9qB_A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
To: Rong Zhang <i@rong.moe>
Cc: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>, 
	"patchwork-bot+bluetooth@kernel.org" <patchwork-bot+bluetooth@kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Fri, Jun 26, 2026 at 7:19=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
>
> Hi Chris,
>
> =E4=BA=8E 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 GMT+08:00 10:40:54=EF=BC=8C"=
Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93)" <Chris.Lu@mediatek.com> =E5=86=99=
=E9=81=93=EF=BC=9A
> >Hi Luiz,
> >
> >Could we revert this change?
>
> Please don't. The fundamental goal of the patch is to make MT7922/MT7925 =
*usable* on affected platforms.
>
> Moreover, almost all recent AMD platforms ship with MT7922/MT7925, revert=
ing this patch affects quite a lot of users. Almost every AMD platform I've=
 met suffers from the issue, and there are plenty of bug reports.
>
> Intel platforms never ship with MTK WLAN NICs, so I can't tell if the iss=
ue is reproducible on them.

We cannot really remove it anymore, since it has already been pulled.
Therefore, I strongly prefer that the issue is fixed somehow or if
there is no other way then a proper revert patch must be sent, since I
don't have any hardware with this controller I cannot really test this
myself.

> >
> >Sorry, MediaTek wasn't aware someone submitted this change and it had
> >already been merged.
> >
> >MTK believes this issue is strongly related to the platform's USB hub
> >behavior,
>
> Still, I believe that there are some interoperability issues in MT7922/MT=
7925's hardware or firmware, as reinitializing the XHCI root hub (by logica=
lly removing it from the PCI bus and probing it again) doesn't make it reco=
ver at all.
>
> > The product lines MTK directly support haven't reported such
> >issue.
>
> ...or did you mean none of the existing AMD platforms are supported by MT=
K?
>
> >
> >Disable wake capability would severely impact wake on Bluetooth on
> >MTK's official product lines.
>
> Could you kindly explain "MTK's official product lines"?
>
> > Furthermore, this patch looks like a
> >workaround. There should be a better way to handle this issue. We hope
> >this change can be reverted.
>
> The issue is severe on affected platforms by making the Bluetooth interfa=
ce completely gone. IMHO, we must figure out the "better way" before revert=
ing it, or else it's more like burying your head into sand by shouting "wor=
ks fine on our platforms" (TM).
>
> That being said, I think we can narrow the range of the quirk down to AMD=
 platforms only. Does it make sense to you? If so, I will submit a patch fo=
r this.

Ok, then you guys please coordinate. I don't want to start requiring
Sign-Off-By (SOB) from driver authors because this instance shows that
response time can be very long. Therefore, the best way forward in my
opinion, is to have the issue fixed in a way that works for both of
you.
