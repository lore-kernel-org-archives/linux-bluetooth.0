Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D372388364
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543115; cv=pass; b=pDmayHxsw4ZggsEJTT131hp1UfpA3QjPk35iQErcEffT/MUyiyq2EGCc5UY8G9p1QpfwF8H+sUh9n8r7FQVA67Q9y0ZVK77tQb7QSVRR88fE5ZJF8rhbI7NyRwCUqMuqnEj953Vnc/yFtAAg+1WLHJ3GovGrsGs6FsVlmisLyog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543115; c=relaxed/simple;
	bh=2YVz1EaXSIcehCaO1vLaiIGLbULTBiMQDyz1OJk29Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=io+mr8JHA7DIJTnp9eWV1kUSZkuyQzul1jGSdFjiUIO6i8jXeL4qKZpipqxB1vB+MOPGtI0q1LkeQHOn6mKqMIj0z1FBCYE5enDL+3oi1dAxgKGHyAOvADy2Z2p38Ib4j7FcjkNKQJJHM5MnmrkIL/gNXvkODQMYco4rzdiha5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rka30DYC; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rka30DYC"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso1318668d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 09:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543112; cv=none;
        d=google.com; s=arc-20240605;
        b=KvYhcHPzBULFmLG4yrnukXYgDfp/i90a/Wy0Giz3OwiyJmHhTNuatfLsXQXYHXGbeh
         79S9CGgLOkxGPLwsy8JCsb7WaB7/vlip7DOyUAGc8l7E3mhf5ezClm0qo642tXFvxbUl
         NYu7DJ5tPw/dRmk1l7POavtQGNwkufHF6VL71uQDvjE9QZz2ixIglp29yTktp4N5o25u
         cSm9zzMMPYXc/dPuPF2YqJ2z+vt/9IVOtssvfHFaLO16O1za8Usaf7YyM03s+l6Ep5w9
         6cz6a0qWO8WT6lS8aUYYevVf2PhZuvVPVi8a8LUuC12wgC+o3/wNKTShQTkSz92YE4TA
         +NKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uCaZcQB/8RPCzPA7ZYHjPY+l//ZjVSQc9zL5L4IoL/w=;
        fh=to8F4+IxHdlukxeuEmeY1/rpbpAXZqnXiYIbOpNE6b4=;
        b=aqZFXjlovv8iJk4DgGKPgTCJ3SXcszQmpUZW/peryVJa2MSQQFupVQktTvgwa1XPHI
         xVmoTUry49CVhnZ193j7O2EzbG5tLiIZxpJ2PWsdglZizJMArPWvDHGzCC4dj4n1E9qn
         kBW54Mx+k+5Z8fZv11G7dMN3hhbM59nVXR8DipAiz0pt+a/3Ol/qH/P8agD1QD7+ltsz
         e1WhnlRNKeCEZTU7xB9YfQ9ZHFbfRb+6OCVE2S9D9UnloNOTL+GXvru0F7/Jz1f2vBxL
         LRoZoTa29+uHDn8LHdeLcjOnIXmDTzTm3u9LRO1nEBQRNL4//iiNiXfNADvfJpf2TjuF
         LsPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543112; x=1775147912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCaZcQB/8RPCzPA7ZYHjPY+l//ZjVSQc9zL5L4IoL/w=;
        b=Rka30DYCh0bHnUNeQ72kGlwWQ2ktHnzIRT0K71Io/fQBoyYHifc3+s8efkSp6RR4gl
         dirAXXUTVwtF/fGsN0vzxA/OAZLVn+V4xUrfM/xbc75yVv/QOA5KTCymBQSiiWLGTKnX
         23MwLs0Xy0UE7tcPzobYX54Hy0e1QlFPfzSxhhybFmYi8F0or7uowp4XbXSGI5SKm8nJ
         UcJUttoLe+978e8FpF3HUPaZUrDMTCBP2CZRo26zuwUL4nCCNaB136GnsHT/uFHCJ6rq
         iCgivcXbOxJkJb+x5Nzez6eYnDjOwAPetzTNsu3efV/uCYs+2cYxKQUjoX7GcC0Hcg/i
         a4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543112; x=1775147912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCaZcQB/8RPCzPA7ZYHjPY+l//ZjVSQc9zL5L4IoL/w=;
        b=MmDwi1ox6wgWrAL2GUBUV3Pmh+wW+pPozXRmSfEaUC+a5WHThtovrqjfeMDBpt9LTg
         mj5tNTHQp4Si8PYRkF9p1o7HVxn1Q9ODfD10aYBMdASlDKTTXhOBtBh3sSfOK+4Coi9P
         AxiClKBkGCbvly8JBEB5eWeH9NjpFXplEYx8Mp/m8bgRD8IE0AOQlT/8c+vmKkQTF+OL
         LLU9zQclBHh6sW2n9W9Yd2xinZ4b4Eo1kdN7BzTIMctw3IHOX/IjiW9xk4JVwi/b+exL
         43fCdkwnYfldARgG0PjTSz6mdPO9Mj8MTIFT6vWCbE97G5FlKV39smd1zzPB4T5sAWoN
         YCDg==
X-Forwarded-Encrypted: i=1; AJvYcCVMvhsc4T+6e9t7QR4fBo1zLjn8suP4UTnudLDPZoeC2ItDsr2C3yYhlltsA/otCQDAhMAQguV6aesnFaSBAZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk7kaTpff9pNNKVTOM8TdW6dlU4L+FC3n8Xbmlm+cJbDmtYSVZ
	MjR69oRqrYELkU2CNlrmlZQlqzCc/+0y5exzwmkbkvNgrZ2CaL9gVRcKiXv+/9vJqeEIc5y9DlG
	UR+KkS+WJOABkSX4HjWT1xKL0v1RjHq4Kldr6
X-Gm-Gg: ATEYQzzldl8g0csqHNVChZ8JJNOgTS/D4GdPQFRPDcyZguQap6T5tLkiSQQ41fH6GLS
	hgxwhN1HWSrfCBygGli1K8s/ehpiNEg8DAYWetBVgtbTtmdgpHy9A5OlfQG5szqM1XjFA4k1f2I
	BSQnnHhLX2wZC9Fqin4/l5o8HefSB22LSNDKtXBbTvv1M84daL63ALNvqh7cFtqh3DfyH1IEe8A
	J9U0YYxHp/GBVE5ljJms/LWjYdC8/hpSFs8jAR2PkVg++nsEgEWh4wqbk+zFWe7LIowPBQDk7Qc
	triAMo0Qnd8FryBlpuz+Pe0rFdz1jJIUzirrUg8cpXD8Z/3IJw75jmRPXZ3ziVFJSdnUdg==
X-Received: by 2002:a05:690e:dc9:b0:64e:8a89:626b with SMTP id
 956f58d0204a3-64ee6181225mr7901696d50.78.1774543112502; Thu, 26 Mar 2026
 09:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-hci-init-fix-v2-0-a974211d0224@axis.com>
In-Reply-To: <20260326-hci-init-fix-v2-0-a974211d0224@axis.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Mar 2026 12:38:21 -0400
X-Gm-Features: AQROBzAQRx2TWkn6L3FHJ35Z69D5WOOUoxvFE8iPpG2u8-iZaLzo0jHv3ETfs1I
Message-ID: <CABBYNZLpO1tB0BTX+HTVWAeCzi9vxu11sLHTEUThN1PTm8BO5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Bluetooth: fix race during h4 bluetooth initialization
To: Jonathan Rissanen <jonathan.rissanen@axis.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Thu, Mar 26, 2026 at 5:59=E2=80=AFAM Jonathan Rissanen
<jonathan.rissanen@axis.com> wrote:
>
> Hi,
>
> This series fixes a race condition that causes hci events to sometimes
> be ignored during h4 initialization.
>
> The first patch clears the HCI_UART_PROTO_INIT bit if device
> registration fails. This is needed to prevent the second patch from
> introducing a possible null pointer dereference.
>
> The second patch contains the fix for the race condition.
>
> Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
> ---
> Changes in v2:
> - Added a patch before the fix that prevents possible null pointer derefe=
rence
>   from being introduced.
> - Link to v1: https://lore.kernel.org/r/20260320-hci-init-fix-v1-1-e1960a=
41baf2@axis.com
>
> ---
> Jonathan Rissanen (2):
>       Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error
>       Bluetooth: hci_h4: Fix race during initialization

These should have Fixes: tag included as well before we merge;
otherwise, they look good to me.

>  drivers/bluetooth/hci_h4.c    | 3 ---
>  drivers/bluetooth/hci_ldisc.c | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> ---
> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> change-id: 20260303-hci-init-fix-9657128a0104
>
> Best regards,
> --
> Jonathan Rissanen <jonathan.rissanen@axis.com>
>


--=20
Luiz Augusto von Dentz
