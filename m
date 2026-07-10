Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E33148DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712683; cv=pass; b=r+mC7ZAkvt0RgCnDELNMwciHne2b1AbXBrhaYknE6h9VZkEstmAEt5uMjvHeuQKmyd1af9y7UoWJb2/DKLE7nnZxVv8rdVCBqpHqASoNctVzmmtb85UywL5WWbl5Kh3ZgoRD1aLwObqA90FdhRPGcRWbJMyzC43BdQsj2TXU9Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712683; c=relaxed/simple;
	bh=IBMmFTiOYjAHnLeT6vKoILm9oAE3dwvSHnA9QN/51+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9Q2LLzULyxxofI6EfzqyhNdsxiKxcKghiYdJYGJk/mEUxwJzTbf2MLQjkA8QQEg9EYgsI9IuHGQswdHtXwASaNJD/fGXcc920IX3HNxQlrBhOSuI/qft6mrsGUTM2PaiMzI0YczpBbPk960k8Rr6wCfYe7ZwkiLftVtddDcJ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP8Axusg; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP8Axusg"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664b3831a20so2322761d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 12:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783712681; cv=none;
        d=google.com; s=arc-20260327;
        b=qwWnK3Vnc8jUjLFC6pgXmHlY8w3kykgpuROPc6FP4qKw1Zc6yvHbdItj95q1EBh8NX
         +lBqz3hkZbL9gkd3AiZq2MfWaBCOmD96b6ZTtnxUt2r2vh9SRn3j8XJTbWA03E27YbhR
         1gUM+1PlmEk2EGTUzMaV+DgzJZqA9gXR4DTlU/5EbpNyoF3LJwSQE2en+Kq13v5mxvBY
         ktC/7aJ8l6v7ZjqrwczJQWRPbamx5Nw41BwdhIkv0QZkjs0jYTo629IS8Y3tFAFO4feW
         ypeFmMGlG437AeuzaNpUPtOUWs/X/U4WpdI1fKyu7+geKV4xjBP7YqNbKhKawJWz/7Le
         fr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=akj2BI12UjhtMRj3V7UfJR2AaiqyGnwA1dx3Ve67Jeo=;
        fh=yj1ZMUw/S/ki0/JU5qGPf7X8rHWgi8RLIG7Ik/B7log=;
        b=LenBMK5hpVa1XJuvu9VcnvHEzKbvdwiFkHQgvK2EUhKFhnJnfkDbiv7/KJ49eRJzPf
         n4H4nAyfAbibbaGBowzBqycc/RQUC2GOYnzZJQMlQdjCoE9Nt44bo34zk++bFY6MP7e4
         7RTRnK2raTms/Yo8QnCHzNN20WUlpZb7QQnr/wdIkWQLVvGMUGE0/6YoF5MJAAsKeo8t
         kLt2R8vkqFQobWaywFUhLAuvLNwFFPKbSJrB/JeiBaeEU9UVbfXD9qCXtTX3wVvb6DWk
         vCKol6mzW18JbmeCH8dCTgwZWHuS+5wkj0EmApqmG68j7z9X/x4MWJsRu7XWpiYQ9MTR
         jDBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712681; x=1784317481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=akj2BI12UjhtMRj3V7UfJR2AaiqyGnwA1dx3Ve67Jeo=;
        b=VP8Axusgho/OqPyVWnOlLXV9pZ3IRfVnzuJO/4UOG2S0QlobMZ1pBotQj+hSciLLiD
         h+GVt/adfHEOH8ioOfJbG4M0j4nnd1LSHPoVtLA/GNp0iuBaJZB5Idoj8nsd+8GQzxUU
         lcpJJL7khVYxZqnwJeRs+yFKyHO1N1S2uEkZM7rTX8w/T5LEnLFWCaX1QVXAGVQf0DcO
         yVYg4kR/S1zJwLZtLHrnCo9ke7ZMcHE2Gh8fJqcxp0tWORDstv9c3vZQoxzfRA/bb7YE
         TYCTfr78TsUrGtJSIEH8p6XC+f2jcm9YW854bbLQmNDIuYBby/Gs5zsJ4rF8wh84OYrW
         +LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712681; x=1784317481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akj2BI12UjhtMRj3V7UfJR2AaiqyGnwA1dx3Ve67Jeo=;
        b=kCS01hG9pV+JqYFFMJMpzCTCiElnJEe/35hR6i2JuR5qgBwKfyiYrIYS1WdKz8FVnR
         NMYLXunfykDM1CmUlAu4m3VqygJlmfqMA+ZkhKRw5dZZGA6RV61s0b/X9ZC3KDlnpkSU
         kQQuvxET29oBcJh8mh2eY5ctPniV+CqCz3gVxBTeOb5ckW3F5nU0U86fG2qpE/++7pMj
         CVEeA4C7wRbp0EpCNYvMnxoeXDFXtQGTJL0Lz3JkS6l/LxJePYAE7cGniT9HqqpDuIfn
         Nm9UBgDrnkSHqJLGfGRljLTDSO0o7dsF/ct3OSPCZnR3OFN1+7Xaw+TTi5jsxNwUcL6m
         F4uA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8961WiLkc5s7U0G3lI6D74BaWBknSM6UZTu+p5ak1o7ZyW4MrlRR9L/kAMFfYAavoWQSTtlsPDPm5zeo6q04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3V8TSeGRnn7d/gG+Y1u7RSBHr5o3Z0L2OCvauEIA55Lbqraxh
	gpzowEu61SPBkdbCII+fTfefNNRvBbDyhnjaAH+O4izSQk4d3s8+KUZDlERTAV1AFRej6EXlh+k
	pnJ8NJxIRc9icl07Dfyp1PS2TwIdNiqHbXbvlZjqAIw==
X-Gm-Gg: AfdE7cm3MDVhfUyxkW8TWmUmrQjkqTKPWs8OV5Z22OMhlbx4NcYpuq+oHq8XLuKpkxr
	cuH6QpkTAXB3gCUuxt4C22pRz/nJ8ALqo5V1RC6sYQULKOnLNEZoyHOfDHl/D3aLdvFZT/ukm0Q
	USPzLuzSV8BuEF22GB5NdAyZ1MjZPWyU1D8LKL6cJP+p5PSI/yGo0eBjpUp1PBkhEJNR6jHUme1
	7s+KzcFw6d7x2v1MnCgHVEZpSmHX94GFvT8t8kmyrIJFOqYGb54egm5LslTBf3EiItvgZMiYHnc
	c5hIEnBAe+8YD0Panbsu/c+PeHeQx6mKgr87VvD1FJzCWSmnUJXrJHUdQ/o=
X-Received: by 2002:a05:690e:4385:b0:667:ac1d:16c6 with SMTP id
 956f58d0204a3-667d7cb7958mr389516d50.81.1783712680953; Fri, 10 Jul 2026
 12:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708121205.756886-1-lgs201920130244@gmail.com>
In-Reply-To: <20260708121205.756886-1-lgs201920130244@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Jul 2026 15:44:28 -0400
X-Gm-Features: AUfX_myK1h9kY2wPnlV_n1-Yf8mH_FXA4izfJeX_4NMhnxE_iaNPz6iyrekrDW8
Message-ID: <CABBYNZKekk2X3_cM3OVdhn+Q21_ABNVpG1Mm9JZ5F7wcZ2i3SQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: check end fragment length before appending
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guangshuo,

On Wed, Jul 8, 2026 at 8:12=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail.=
com> wrote:
>
> ISO fragment reassembly keeps conn->rx_len as the remaining space in
> conn->rx_skb.
>
> The ISO_CONT path checks both that a reassembly is in progress and that
> the incoming fragment does not exceed the remaining length before
> appending it to conn->rx_skb. The ISO_END path only checks that a
> reassembly is in progress.
>
> A malformed ISO_END fragment can therefore be larger than the remaining
> space in conn->rx_skb. In that case skb_put() advances past the end of
> the reassembly buffer before the fragment is copied.
>
> Reject oversized ISO_END fragments the same way ISO_CONT does, and drop
> the partially reassembled frame.
>
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  net/bluetooth/iso.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 793a481d7066..f5ca8db3c206 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2639,6 +2639,15 @@ int iso_recv(struct hci_dev *hdev, u16 handle, str=
uct sk_buff *skb, u16 flags)
>                         goto drop;
>                 }
>
> +               if (skb->len > conn->rx_len) {
> +                       BT_ERR("End fragment is too long (len %d, expecte=
d %d)",
> +                              skb->len, conn->rx_len);
> +                       kfree_skb(conn->rx_skb);
> +                       conn->rx_skb =3D NULL;
> +                       conn->rx_len =3D 0;
> +                       goto drop;
> +               }
> +
>                 skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-=
>len),
>                                           skb->len);
>                 conn->rx_len -=3D skb->len;
> --
> 2.43.0

Looks like this is already being handled according to sashiko:

https://sashiko.dev/#/patchset/20260708121205.756886-1-lgs201920130244%40gm=
ail.com

--=20
Luiz Augusto von Dentz
