Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793290164;
	b=DHx9I3VRUx1VZ3a1BijanwpvU9eK/5Q4FfCo4FFnzNpxJbggXy2P3uIz/k3b7aLupS+D
	 7xWEm8PEq7hZ1+nMqHccKhBqsoe5NmtQh5fSHouR6lFXSSw9mTGvMY0EzDef8+XsjtvRc
	 PgfuVBBKyEz4iSFya8qdMs5YRhzkG57VJ4Qa7mqfT0sSQMSEf4BgzdGHxdO5lBRlnbGwW
	 gpJOI/NfsVEHjnBxuXCVhc9nZx3vzayu97A/A0g/fb8nGIjehGRs/A5qFhFjE29LmjYEb
	 xBxwxbLndE0Rf8ZIQgQoXWojh18t+GigyrW4HxTXKpPp/7HrdBKreTIk6jCD56m4IsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=epB8RoKxui81tx8KuP3TsTIU8ktJzNyauUMdiyfjpOg=;
	b=jnowxZIvwkyHm9G0BaCBkPv78LJRsYaIQEdDzajuo/wJs+NAhjLKSYKq0rk0u2eLihkG
	 FV1VrHUzPdH9KUb2u7p+WfK7Qe8AweBqOFxR/VYPQdEcRH/GFx2HSKQ4fYnQ5dvw6lTAC
	 blX+aww6EvudjCzW3Ih38EDFKn4JtlTkKxqE5jif7XUI3aKIeocTD+K+4OULh6Bc3o0xz
	 3g+kLXYERWP3KkfBvwLJmNpcN1UJNLFdbKHF0iPuAHDRJkZrMpvD9Az9D9l7hxjpzDL4W
	 RU64pWhTYDX9ttCn+JL2DaImBLPzpAZ9uKEsrWcu/voQ8E8Dq3wvxuove8VnYvNRT2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdHmfZmU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F772606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 16:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F772606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XdHmfZmU
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b05bf699easo23844747b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793290163; cv=none;
        d=google.com; s=arc-20260327;
        b=B/jq39JbnfbJm9Y1wo9uiGyzERuduz6m1pIDRak+ZpcP70ok2VjYOm+Q1V14GW6kvZ
         BuH2t/2oZRvH43fUhVxAu89PeqVONMYDRWTPF5h5XMtErGjvlP2wQU9MzMZzmFc6iudZ
         Aw3oAHIL278Z2a0omsErPbGO71SR5x5l8bD/9gm0EXZZAT1cimZWj2c853wrRhIaN3e2
         y1elQIYZ2+BPiOjClWZuNp6iF8nltpb6SYKzBbE6v6EZcubqDu+OAVCxMbAHCBEsR5aG
         fvYeqJqAujaBg464ZeN5fzAMy9j6LrMdCMHAKYmXKU4Tv5KYqisH+6mkAll9oqc19uP/
         q5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=epB8RoKxui81tx8KuP3TsTIU8ktJzNyauUMdiyfjpOg=;
        fh=UmuMtuhzut2ONexYcEEkTbdXeU9Gb26lzxfylo5uyaY=;
        b=ev4rTEhVSquPzvY47/ke/9rNmmejE/0bceLyPiYOEiE9gpg8714QftInE6plBLg0W9
         820up4UqaI1M/k1Ov9yuodTAzFOlIeE2ifKGS29cSpIyHKEzxIgXxHFCp9fNxV/2equd
         cQXcI1EeO2FI5qwfCYFbw3w7/WfFfIGRUi5e3qDjCf10rvilieDRLMI8pwCRVqHwekr3
         2qnbpMRvRN2o/el8yrG/BXO3MOZdKsFEvgTO1jhW509EezJAzO5whWeLcHs5PBmw1SXq
         361WDyhlYRlYF0v7IfkWWNPfccDtHihoWswjWgl3Athe8JwMt63SXOtezDg0F9/UbWO4
         K9DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290163; x=1793894963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=epB8RoKxui81tx8KuP3TsTIU8ktJzNyauUMdiyfjpOg=;
        b=XdHmfZmUHaYtadkK8mCBg6rwoPDNBVSyW86SO5+2wkMAAXlNTo/xBN1h9EAjHQpGPG
         PMM4YwZkRdCMnOvqvDpxYyjWdE64vgmwNOKEw8Bf0sUd7Zgv8EmOyynk/H2TYWTuyW8N
         1QVJmaAnM9jvbUmaOMuwgZQZyJh8rNghYlzpTCBq0bcc0Vu4LLeZKxsAz3+YmXvzIvRn
         nSr6iSzEwrX9FZZwj6koh2AvPknLMrNo9QuLk9wZJS6svBHtk7p+1u8Mt+zeBPFB7m0+
         P06pyH/i578wl474LfGZ/Vc0RE6j6IuELN/8oYeOuweiUH2p8Q79SNBRRQRB0XV/Cxeu
         8U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290163; x=1793894963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epB8RoKxui81tx8KuP3TsTIU8ktJzNyauUMdiyfjpOg=;
        b=bhOlVp01cQXmgI+bipSx8sBoImAfPDCeLheikoyndd6kj9ll7Lut42qF6qjBqtXnvx
         /Mlz2fzyHsCketm4DZrpq2+XfzgLGzE6gtFH1XskTWYJ9r813WyUDokjfYzJlU2XL1TO
         5PsTqmSzlId+sL1D8QoUIjqp2aJ0UifxYNbshibmVMUGG6VKJNkg9UeQ9Jf+oc441eAZ
         JLouhGm8tRQjG4gCezcPnqd+R3dHdrGabp48hCf4BHFVyGFn0eqgwWTDReiXssWg8IIk
         orL8ogUfidjk2ERur+3InF1fufpK9Io508TmvwNewGQ8hcJ86o8pmQ4bkJTpDrh0tS0Y
         K/4g==
X-Forwarded-Encrypted: i=1; AKwUvBxYBMUlKJMEe3TxCUvvpIMEyQ/wFVh1q2sxmiP8NgKAllrlP5gZ1yb1GiBXR6jrQgui2E1i8PptVCFz2Gzicjc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzASyroFWuU//cd6FfuUwa3LHLqPdpLH4T4JCTpSp14kZDsVyv
	nL/YSdYdmGU47JGXpC+od52hBHQmGlGHi1CofsqQWnpeRlr8iKORKaTp72Fl45/kuvsMFlEUtGJ
	dsJUw7fywEMRDn8P256V2FvrYWVxjXxk=
X-Gm-Gg: AYBFou1AWqZJuejX6lcSZE+7TX86XCstaLoJD932v1nw5wOE/or5ptfNkba9EMFuc/n
	X6CzoE5LPtI3Q+9xXO+NbEsrmXpP1Uc/UbdCZb2+gQ8hEdt8PPOaI2D6h4qlyY1LNPBDBggfuvC
	fCyNKKi2K8mPLeRTg86RRG3Wzveey1holbwdkdpBIn6dDDIaNJweBT9fCN8faEXJCqzGTY1zPPP
	G1+8JreyH9Id2obppmt6xHGSc52K1INodo5Sdn6+0V+2IcaXADby3VNq9e92QYQCpZGNuTa6dqB
	HHd3ucaMZifFv9UNI8kz7IgP2/gin8cEBewn9VUUrZBO7GiQXoPqCLFOKZZeb0QbdhWgMKEOxem
	2+s2ztGANpq7KjlWKwoCdg2nUrMVNXHlhvM4+pTAZIi3B2dMHKkexKBULJg3ho4RVwMPXQkwa+a
	hQF+a6Xn4HCKDb5WoqA+4O
X-Received: by 2002:a05:690c:fc2:b0:8ac:b167:4877 with SMTP id
 00721157ae682-8b1b5c9ff05mr38036237b3.36.1793290163455; Thu, 29 Oct 2026
 09:09:23 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029094104.2952304-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261029094104.2952304-1-jinwang.li@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Oct 2026 12:09:11 -0400
X-Gm-Features: AclHuK_t1FdhNrTPRKMKSpeKGIgS_hB6YvmkkGhHzb48NiF-9DwnIvkJnl0-E9U
Message-ID: <CABBYNZJ0YZ6hZaRH4jLtKRSdcVYz9_jdaQgCg4RdfB2O9t=TVg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Ignore connection responses with
 wrong ident
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Jinwang,

On Thu, Oct 29, 2026 at 5:41=E2=80=AFAM Jinwang Li <jinwang.li@oss.qualcomm=
.com> wrote:
>
> L2CAP/COS/CED/BI-28-C requires the IUT to ignore a Connection Response
> that carries an invalid Identifier.
>
> l2cap_connect_create_rsp() only checks that a connection request is
> outstanding, not that the response answers it. Add an ident check
> against the pending request so that a mismatched response is dropped.
>

Needs a Fixes tag.

> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
> ---
>  net/bluetooth/l2cap_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 83b622a42811..70ad30b091e4 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4480,11 +4480,11 @@ static int l2cap_connect_create_rsp(struct l2cap_=
conn *conn,
>
>         lockdep_assert_held(&chan->conn->lock);
>
> -       /* Only accept a response to a connection request we sent and tha=
t
> -        * is still outstanding. A channel waiting in BT_CONNECT for secu=
rity
> -        * or the feature mask has not sent one yet.
> +       /* Only accept a response matching a connection request we sent a=
nd
> +        * that is still outstanding. A channel waiting in BT_CONNECT for
> +        * security or the feature mask has not sent one yet.
>          */
> -       if (!l2cap_chan_connect_pending(chan))
> +       if (!l2cap_chan_connect_pending(chan) || chan->ident !=3D cmd->id=
ent)
>                 goto done;
>
>         switch (result) {
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
