Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A8322B87
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099293; cv=pass; b=MujISgBl0WFcCgGg774CRIWWnpPCSJ3r894IEGuXK5L7kiVIiqT/lA4chozEBua6sz+UaRBGyyb+8RXozd2CvMdYgJnQIBp0iikqhxLwcnvjElgxWFMkQwNivVR8WSwP+wBIOTGDmZrehhUgHO5K2SDHlyrV5rvcJKH185/dFZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099293; c=relaxed/simple;
	bh=5kV6iFNGicuxTKDDJc/EVGekxBSczS+4Mat5yEFx+l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3/YJIIhFW83KfzKL9ZTsGBFvPVyH3xHJfAjkRJRkES3cPKe+zjc3bTJWW3seSq9x858ahYbxJ1Uww503NrzTpa69sY3E2Agsw8c6IP+uajXk/708IJpw33IUkGDYHcUvzd8ubhDaWK9ihGQ/jrclGFJLee/6gckOpGsR8f4kRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hus2PS+c; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hus2PS+c"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501d32b04bso4346966d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776099289; cv=none;
        d=google.com; s=arc-20240605;
        b=Itsc0T2WGje8unwrulRy2oKCvQSLgWklnJpMz0ru5ISDcpUh+1eTcRq91QaW21tdIo
         eiObngGNPQ6eIK8uIacMgugj1dALhVWqGCrkere/9rL9IrFpLOaGYIi5Hh185HJQjKJz
         QMLGvYoMKHtAAHR/C3aVlof2SrxnUkkNiEt8vnGwzK8fYwrCLpEdkQ17H3uOPJw1i2ph
         DyPCNKhtm21foHVTs3cuGIXrdcYHxrYK16IxaKyUsCDSrHOeLFgaIw6/+ikJg5io1KXQ
         FcnT82gvMMSK4XUg7CoyLJ5b9yEFzVIY8NkSDk6sgkqQtJjZKrq3nYC2Nr5GgpVOppmP
         C2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cNUtJWbfSs5U7nwiUTc5lj5CNXuez1kU+/kO/bRgnhU=;
        fh=PeOzssJ/43VGRrnsaH8Dm/FjC3UjwiDRNKAn3gtAkUw=;
        b=PildcYNx8U1GC8pO+UjRlUtWNqI9Hs/w/ibE7xnjCj2DHTc8Fc99rcJiT9cNr5xfg1
         bwEu6E8PkeT3RZyvR2bQc8EMvr/WO8Fm1pW2sGvwl3l9kHooo4ykr+tDFzkVHPEiuezy
         zhIvede/8L2MU61g7lKVngGZDz2nwKSFFhKLVuEyO6WVFrdGDP6FkqDdcR4WvjmU/PUZ
         /JJx3hU9zaGUT2lw8HFo6vRUxuTQOS7UowXN4CDwjTCSdGW3CoFseQRM8lX3AyID/o3R
         1YxPK33ngmlRwnih94R3i1w1kbuSRnFv2GQOyfZvQjf5OOFrxyGuqIrw1qQkWBiiChcg
         LJAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776099289; x=1776704089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNUtJWbfSs5U7nwiUTc5lj5CNXuez1kU+/kO/bRgnhU=;
        b=hus2PS+cwCrT58viZ61YiIVHFaqfqcHVJEib9LQLUDhkoH+NWQmwdnI8exYkY35crv
         cW7AxubJJ9sfncl3gT1q7KZMVZAKohh6Tfv3MXltqvbGo0HaNmYsv9QpuklR1OYZP9jg
         W6X4WkA4llUxa6S8dBFgAgxz+OrR5PtTzxA4ETF9ZaSYXvDgq9J37K9wmAOPGfr81jB/
         CEN12/22xoY3mm9Z7VqUjIjcF61OZMYlvDw1/yd3k1iVWwcnxGT8dE7lLGo8k7oORo60
         +PGk1lacMojt5TsoELjmLVWJ3dH8wzAV6qhzwxHac42Sl6yYlv5DfIuI8o4NzmhO2EAH
         UeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776099289; x=1776704089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNUtJWbfSs5U7nwiUTc5lj5CNXuez1kU+/kO/bRgnhU=;
        b=owlRWGZyOXDzHNreR5PGz5mC0/vnIaedlvRgUpvQnVvGxkXhvb0OdIup+rrJ46btq6
         F437xXSMYf//ExKa/cdCXF6R0JguvoOW6lEpnLXF2YjhGvgTCLoSW+AnWyZpZeQ9hPtP
         0zzjvUgfXW++NgLIGNJHluFAou5ZIp+IxoVHFov9fYJyJfD1V8f3hGSoXsjD1K/k8eMG
         2ek0DlFyXIh1lDKDGPqiuBGQ4v0avX/lLzf4aJbzdMkjKJFmQ7hsDG1vt838b209nV4y
         VwQSAiGss+TPsmQRQCws9fgXMmo44eQzB6j65/ende7DtgQHgZY/E4N9syvC9XiAeYis
         oDaA==
X-Gm-Message-State: AOJu0YzoIoGkNNj5s3owgVA2FDvgA5NcpgEwxBc1++LbXQ5RyeV094cN
	rTgkLRfecZOEG/w1vC+i0N28fPg5DBvNYGRzYdk9qHrGdf+5tKqtRY+dzgG7pj2r/LbytLklgpo
	R9r7taFqOTFYnLmQ3D3BA8hs2EHVAYkk=
X-Gm-Gg: AeBDieuvKjBmzHbxeUi1S6dQcvbTCHeoXVDWhJs7Kwa6SfmIYpryLS5Jxs+W82iJ611
	jYY5V3Eyd/PODjOqLrMwZabIohkxh+qlv8eEqTWhs12j8DwAOvqZTn5wJrrTSCy9nlHfoNZytSb
	kFRRbYmGJ6EeNV9fetkyhbUbb06qzXp8OHbYQKIeEtARW+XbpPcAEA7nI87mRzxHVTMEGLwGY2h
	anBIm+wH0hyTG8pKdJcTljxsKtoF9Xg/I84X2pUC/PamQBjeFJf0eL3Ari6E65R4jYzPXTzoiNB
	z0baaCvPcRdxV1gxwniMPPSWdfVO1IzmI37BBxukGVoXOCKjgaGOh03fnoChdQkleHBMYbP4M9r
	OM3Lc
X-Received: by 2002:a05:690e:5cd:b0:650:2257:e085 with SMTP id
 956f58d0204a3-65198a9dad2mr10243176d50.30.1776099289449; Mon, 13 Apr 2026
 09:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413084442.68604-1-phx0fer@gmail.com>
In-Reply-To: <20260413084442.68604-1-phx0fer@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 12:54:38 -0400
X-Gm-Features: AQROBzCUdyJnRc2hV5DCu--HmtFLY8QZT3G_oeV7S8IMF7qqEA6_ot9mmuV0rpY
Message-ID: <CABBYNZLDsGPtbEGdYkg2daFkxwfAGdMy3Q8Z1578FhC+WMdeJA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bnep: Fix endianness in bnep_rx_frame()
 extension parsing
To: Dudu Lu <phx0fer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dudu,

On Mon, Apr 13, 2026 at 4:44=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote:
>
> In bnep_rx_frame(), the extension header parsing for
> BNEP_FILTER_NET_TYPE_SET and BNEP_FILTER_MULTI_ADDR_SET uses
> *(u16 *)(skb->data + 1) to read the 2-byte length field.  This
> performs a native-endian read, but the BNEP protocol specifies this
> field in big-endian (network byte order).
>
> On little-endian architectures (x86, ARM), the bytes are swapped,
> causing the length to be wildly incorrect.  For example, a length
> of 3 (0x00 0x03) is read as 768 (0x0300).  This causes either:
> - skb_pull failure (length too large) -> frame dropped
> - Insufficient pull (length too small) -> frame parsing corruption
>
> The same file correctly uses get_unaligned_be16() for identical
> fields in bnep_ctrl_set_netfilter() (line 110) and
> bnep_ctrl_set_mcfilter() (line 156), confirming the inconsistency.
>
> Replace *(u16 *)(skb->data + 1) with get_unaligned_be16(skb->data + 1).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>  net/bluetooth/bnep/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index d44987d4515c..2d1cb2061045 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -332,7 +332,7 @@ static int bnep_rx_frame(struct bnep_session *s, stru=
ct sk_buff *skb)
>                 case BNEP_FILTER_MULTI_ADDR_SET:
>                 case BNEP_FILTER_NET_TYPE_SET:
>                         /* Pull: ctrl type (1 b), len (2 b), data (len by=
tes) */
> -                       if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * =
2))
> +                       if (!skb_pull(skb, 3 + get_unaligned_be16(skb->da=
ta + 1) * 2))

This change seems wrong, it should probably drop the * 2:

https://sashiko.dev/#/patchset/20260413084442.68604-1-phx0fer%40gmail.com

We should probably use `skb_pull_data`, assign it to an `hdr`
variable, and then add a check for if (!skb_pull(skb, hdr->len)).

>                                 goto badframe;
>                         break;
>                 default:
> --
> 2.39.3 (Apple Git-145)
>


--=20
Luiz Augusto von Dentz
