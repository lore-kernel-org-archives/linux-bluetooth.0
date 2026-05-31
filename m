Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A935677E
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780267312; cv=pass; b=KSEXt1rfYnnxh28ysdMGJ+jf0g5CVEsRUCN1qyybwaT4S9LDfpKeP3axv+nLGAiCoGM97Ld5bK2mhsmICNfKyIGqunZrRymdEG5BK9VOZJ2tDP2FHLbMlqA6WRBS7lE+HfoyoVfyV/p2bg7uasPTkjxj8HIwWXOV+dyvtD2Rj/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780267312; c=relaxed/simple;
	bh=DwqmmYGhzLJZcKctFbT7fQlI57XOCuUvJS2TlMvi4UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/fCy8nQJC7laEyg7DHmwt9ryIs+GfsQ7GopADBlAxN8aw8roODJvTgeHCaS04F7YtlhcYchJkpXO+huoCY3rz9qJZm2bsfLGKKa2Uk0L6oWgvJpydE9mnNAtHsbY9NCmYScRRwpr7y2rzUAnqHfRxjOWqZSn1WbuM5oec4wxIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/cG1AeK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=asuJOGG5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/cG1AeK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="asuJOGG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780267310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
	b=K/cG1AeK/u0z8AeDsASsIwXKNfY1+zTcl70hKkwoCdr3vVgPCvd5wW/vyBEHvXaQ9h5hrc
	J2Gt+7ughxrEdMKVCJZrmgUqa5QK3HX+Vatg1SPv2N4iNFk4BX3rJ6pedyIfIvIGp3+HhO
	DOG9dhyfkbWFGPYL6d/yc64l0OeoWQQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-hmfyRtmAP9meqKLMnDLz3g-1; Sun, 31 May 2026 18:41:47 -0400
X-MC-Unique: hmfyRtmAP9meqKLMnDLz3g-1
X-Mimecast-MFC-AGG-ID: hmfyRtmAP9meqKLMnDLz3g_1780267306
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5aa43c27d47so3186661e87.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 15:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780267306; cv=none;
        d=google.com; s=arc-20240605;
        b=jGNnzFFlX/x6Qyi78/WvZUs1/hNctM91aQe6GuffmNrC0ThT/0hj0REoIojOSH8mmY
         27UTK8QXFriUq6PJHBmF4j9hBTDurFFJ66RbA4FrQijINrFzCkEujwpG2KiOiznEj8Pb
         I2iQz9hs5863SFojMwlccdyEjNnUqRcME+jmFRrjQjg1ZRFFIfdsM8r6aXByO8EPgAVs
         cyEpdFAtrcJH4Qk8YNfATHWmpZvwfdHtASFPEVIQE7RGy0wwU+wWeGWGGmglIoeXb6HJ
         z8kCStYI0o85NXe+Hl+XHjJSzjQJ8AWec2e84mzh5oeWXFYKn01C4mv+LFPi+GmwumLK
         OhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        fh=EYm3D1yUioq/k3t7w/CEgWpbVZVreL6mxNp2ix6iq+A=;
        b=aKUo2wp94GxWOUFgIjH7n8WiDCLkCzKXfPG472FTzvA5U3nOIkr0mV9pjnAwzkiZaz
         SZ/6HTwxFT/JWjb2uTUrrleGWheY9SDjIPFq1fgHSDNodqUeWryfc6uoI5KyGzbIEoQb
         /0dk/IDAKxI0pnPxhfR1TjhHRWthENYvgBT+xcZEKSVhwYWLSMF86tSeZ9B+fJIhAbh3
         1Eq4Pk7GDh9uVfyxT6RtTb6NF8nojCazcBADjppjjZz4rbOWEBvFpF+Zos1ypCRBDV2J
         1qhIuOKa4BmVurFFagfxqko3AAYqjt0rIHtODhUbbVEln5hld9nLVepidTcktrt3K1YC
         e4zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780267306; x=1780872106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        b=asuJOGG5Ik+X70IysGdueIpobpCYSEe/esN26gT3Z0vJVThLoj7gKsee82cG2EpCi5
         A1yBepsAKfxLZNWa3OcXzDGQu8whGgdXzi2BAPrN6BDPVp6a2WjpaHtXI1VuIswdImMA
         OS5ZEoCdRxD4ikZ9XRP84KspwOXo7viFs7FATe3Jj+NOP8PJbQx0HVrkcWkNVoLfJjOv
         dVNa8xjhTwV91vNSk9pJ8JRyz0nnaVGjjKhdngPrBhQJAhW0bvqstscXfn9ann70rbBn
         TNR+q08Oy0ZvwRQl02NxZWQUKYa+5qTkSfQTkSauD/DVwdcf+ZIDCKa3wJmSpZMUmCGP
         V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780267306; x=1780872106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fE4JU+gsz+ECemqk45eUb2e+nliPviu8zBW1jL7IQco=;
        b=W/KAojiExLxlFzdpUiwhvN4ExtkyRn72xcjVsvn8g6UYcrjasXA7s0vGQcyhSUP2H/
         QR7OQvgKS1q4HWKJYGWHT0cvFqBlh64PxgzF/J+rF+PlfAgEHtTULESGZ7YqEKVhy0aP
         kaS6FtEWKKkxCAlmXDg+STL97Hiaq4bPiEHSh7eDbAqSXgt3Amdy9qcl/FJQFZ247jgK
         0BlzoTXXX3lI/I0YD4wToepg6/JiD9m0fysNeBA4FmaN1O0N9jtvsYuRST7UDMmY9xln
         67HsJ/JYA8MYvfuT4S9XgwTBTa49r2BoUIcPR7cpcMDAWbpade+HM+pRQYo3kOOI2BFt
         8wNg==
X-Forwarded-Encrypted: i=1; AFNElJ84hjr73XOdSQLJJpyo180K4AkKOQqg7tsKhL72Jxe6vf6dqmH4NDrYdUdkcywLMgb5XYVgNWGcFSzIRgiJgZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPeTVlrggqZWPeguflCGpGdRptcvi+0WXFFD+HnNhUxNwkTnIn
	dcs36e85msWCVu5i8bdHGmpbCZNfCro4UFlD6wY94nins2TMyvZk7szg4WuPbDOsFw8h1Oinef6
	cVyLL6LRMd1LtOxj2vBQLyB0C2p5cI6DCzIkmGtn7MtXA2tpuf1K5+v8dH5aUfDNufAKYbj4Ork
	CTV7uhAUTZe+zsSCZ5k5b+5X89asZ7MkR0U4Vu551Tte6T
X-Gm-Gg: Acq92OEwbcgQmrgQ5TW01K5zqAoPufVcghnDDwr4bZZn7sNMVKQu3UxWW8DfRi7pxjc
	QhnTbiglwjl7OReK0rFNN/wqrnEOe9HI4oqeY6QFP+VqSunzor2IYJbGaaI4sfmmw9H9C/W6Yz6
	InWmkjQhyH3VEELwmr9l/TjqjbB5iDaisD+/6Cwg0C8HQ5rbMDYPudQZi7J04lQkbPEKQYjaDxz
	JYomN/vjIYiPKlIb95vr7q8lcqa7xz/rtOIhh5iWIltlvK2Lg==
X-Received: by 2002:a05:651c:23c4:20b0:394:642:c648 with SMTP id 38308e7fff4ca-39664eaa587mr13988521fa.7.1780267305625;
        Sun, 31 May 2026 15:41:45 -0700 (PDT)
X-Received: by 2002:a05:651c:23c4:20b0:394:642:c648 with SMTP id
 38308e7fff4ca-39664eaa587mr13988491fa.7.1780267305279; Sun, 31 May 2026
 15:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 31 May 2026 18:41:34 -0400
X-Gm-Features: AVHnY4LJsPgo1bw4BMrZmqSj2uYEh9dzW3bfFOpiMMU9XPGtTORtUTQD6jb1c5c
Message-ID: <CAK-6q+i6JsNA0twRp29P_wotODGr98rxo_CcE0n_BAhH_ofUsQ@mail.gmail.com>
Subject: Re: [PATCH net] 6lowpan: fix off-by-one in multicast context address compression
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 27, 2026 at 4:19=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> The second memcpy in lowpan_iphc_mcast_ctx_addr_compress() uses
> &data[1] as destination and &ipaddr->s6_addr[11] as source, but
> both should be offset by one: &data[2] and &ipaddr->s6_addr[12]
> respectively.
>
> This off-by-one has two consequences:
> 1. data[1] is overwritten with s6_addr[11], corrupting the RIID
>    field in the compressed multicast address
> 2. data[5] is never written, so uninitialized kernel stack memory
>    is transmitted over the network via lowpan_push_hc_data(),
>    leaking kernel stack contents
>
> The correct inline data layout must match what the decompression
> function lowpan_uncompress_multicast_ctx_daddr() expects:
>   data[0..1] =3D s6_addr[1..2]  (flags/scope + RIID)
>   data[2..5] =3D s6_addr[12..15] (group ID)
>
> Also zero-initialize the data array as a defensive measure against
> similar bugs in the future.
>
> Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression=
")
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index e116d30..37eaff3 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -1086,12 +1086,12 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 =
**hc_ptr,
>                                               const struct lowpan_iphc_ct=
x *ctx,
>                                               const struct in6_addr *ipad=
dr)
>  {
> -       u8 data[6];
> +       u8 data[6] =3D {};
>
>         /* flags/scope, reserved (RIID) */
>         memcpy(data, &ipaddr->s6_addr[1], 2);
>         /* group ID */
> -       memcpy(&data[1], &ipaddr->s6_addr[11], 4);
> +       memcpy(&data[2], &ipaddr->s6_addr[12], 4);
>         lowpan_push_hc_data(hc_ptr, data, 6);
>
>         return LOWPAN_IPHC_DAM_00;

Looks good to me.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

