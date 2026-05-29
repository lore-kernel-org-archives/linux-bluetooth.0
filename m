Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950881AA8
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063742; cv=pass; b=D9gPhcdnEgM7IB5waMtqWJPrI+s0QuAGohIDjHVFOouPxXe/oxDvhamTrWGtT8IKAWF+BbVmAYD+n27ovRhjB9dyjZDN0T3ZDreGdxUocSnpPU1VTT6du5w19Gr1urlT35YygGqOfjPNuUi5IY7ntUMc8cn+0DZD5yn5QUtIWvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063742; c=relaxed/simple;
	bh=bTaqyjLNGfP7BWbb8T9S9ODeqalxRMSSVZgKjJFnYvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzJr8L5z+WMu3y8USQLmvCY669TrlmZddZe+6wsB2HQbnKa4hel0Q3FvwV5qSDWAS8C91vOkM/r+3R5MZstWfdgk1SrZgRr5GB1cjHParkV+PtBtchkp0XMGWhd4kuPjV6GM7pI8BRWTvTHmUNHGSAFKO311IN3AbdsfAQqO6RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8+qa0bF; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8+qa0bF"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7de68222e96so5831837b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 07:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780063739; cv=none;
        d=google.com; s=arc-20240605;
        b=C9buh3y9kG9sHjhZBSOPJLQQvFLan9km1nVxD/fm3QjN290o4vCGrPU4WcLmynqy0w
         xjAUjtHIsfwyAjL13fOZx81vcQqn4+pIxYOidIB/uErEJnb+c12U5XQ8C2qYbJCDAP5D
         QuYY+61D4d2aRds4qdm5exP55Eu3qR5FQyuBot+L1Tgw7k5KZk+IfBqGxNBWkafA4x0z
         UfdyNMkai3E2f0hlQAwTzIM8mCN+bbla+wCM4+UBdAj/XaM4SGkkwUSUSr3VKhQNtF2Y
         gtE+R1NAGxp0l0fHP/tKfL6b8jQvahvZfutF2vKe9HrX9DN1Vr1YLGu4E63cefXUb6ht
         cWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jjJFOp1LuWZyDHXIumBsIBytEUQ0fTPTPVN/urXdtuY=;
        fh=dOf1tXAM8Yuoamwsgnq3p1y50ssZ/Y7RmqQXYlmAlXs=;
        b=I/OHbXZGwOjV4P3sphVURhZWx2l4HR4CsEB9pT7v/etH0WbRGWQrmo1Csv2+DQmetf
         5LL94J4kiKQYUOjDDlcDsnSgeQ33G9wH+HZutVdpl96H8o0RJ56VgM3ALdEbqOxC8CHG
         x1SYcFRtRpUTiGxrjRMddVPaGcshF9Es4c9B8OwfvwWBfEklecsVUn9Po30b1/ohvHlK
         m+vxsamIYIYCVUm9ooiaqGZl164fV6MiFCIOamqLKeVmiT+d7RmJp4YA1l3NT19GJ+/M
         +/Te9TyB8p+EMqqaKlTXwQpVjI2JhNu/Vr1LPTtJq1aP8H+MNk7QLKmZ1UirW/wPuDAo
         QeXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780063739; x=1780668539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjJFOp1LuWZyDHXIumBsIBytEUQ0fTPTPVN/urXdtuY=;
        b=f8+qa0bFh2edcgt1IEm+0xHf3cy7+Gfq0VgCirti/2dDnXd4eRICyUen9GbjcwvVgR
         k0eGcr6Q3DzGEeJF1ac2YWlMjJGzLFf4NkBg+eAz/uL6JztZQDhGa1eSmxKpkdNShi8T
         RQ0RcEE2zscYw36Vr1DTuE105ovKwisv9vUcA0IgqMeAg1OjPgV+1f4SVidnlgbI6vKW
         cbbcPiptObRdtz+FKMZcH2O/fnUYU+/BoTIiAbeTPY4TdJxY2IcdQqBJNlqWJAV5edzW
         DX+Z0XDjcr5AH/hCE6qFmq0HyE1ebq7HiO0V+/Ca/9V3FO+U34kmIJZHTcgOKDUx4Rqt
         xYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063739; x=1780668539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjJFOp1LuWZyDHXIumBsIBytEUQ0fTPTPVN/urXdtuY=;
        b=IOX6MeAkdD66YMNojC8REl/Y1I/twmU69EwnqgFA766L5/V4Y9aXKdQk+SW1z8M3Fj
         sutH1WyiasOzdrOXvsS+fMc4tElixSMIberUSOjOiImyraLHM3n9WOWKm0ZY86u0V5a5
         X81SXUkHrLtXRhNPYHFVr3heBfMpZdx30IWggoAHrZZzXossCayxw/dioC5+uEJGdZju
         TVe8z4yQUqjyJu0SiOEq96SJMGiBs3t6Ic1lLh+SdPMRe5bx6IacOTxWUxjAUbNLnFF6
         A+HTfeNjRDFg8eXgN/fmtCS8zhY+20E6/mgn0hEWiPAUk27tbpN4pYMO3NmK7kIdm3nK
         N+Hg==
X-Gm-Message-State: AOJu0YzJ9MEfvF2ncFWV0+VnjTSncpmkkHmjarFpvf8bT0AYmS3A5zo+
	KMxG1mh15YISxHKA4O4qnq0h/VMhWuRSqHxdPs8Gn6NL+w2FZlGgmyyTMf4CBEFDii87DOblAbo
	u2Ai/tuujnaAOXG0F0IJ4BFMHSaMDhEw7pgTc4Oo=
X-Gm-Gg: Acq92OGp7X7OzPvJ8FnAvESzcn1ALXcUxTRgivvC5YQNFN4/ddchtWOw0CXPFzdnpXK
	z55aLKYeLhOiIxhQWLO2ThhTyAdvKCQrjkOPA2jjxsoqfXqjjIJkm82wKyMa/CUUdopYlx69zTX
	8UTdaEe8CxG9OfDb9Rbtvg0aJtb1NC7hQjK3dnPmdihal/0eHJfKhx7d6/h0Oag01Cx3uEK8puh
	JQWFVw+XAwLD8La9SHf3VZI3BhRsAVED6Fa93bvrMmIVSBKrDnMjwdyL8TXtff93Z48OQS+NOQR
	k6pkhNed2Jm+jk0LxlBWFHaAmGRlQcmd2faJtevLC5p+VV+o8yP41ahUqQizx9Ar+P6Txhh6OaA
	l0WFbY1qEXXBf
X-Received: by 2002:a05:690c:3589:b0:7db:ccda:a404 with SMTP id
 00721157ae682-7de469d18f9mr25582687b3.6.1780063739108; Fri, 29 May 2026
 07:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779633761.git.xuyq21@lenovo.com> <4927cae4fe043f3e2aa80f4ee6bed05e4fb5a6d4.1779633761.git.xuyq21@lenovo.com>
In-Reply-To: <4927cae4fe043f3e2aa80f4ee6bed05e4fb5a6d4.1779633761.git.xuyq21@lenovo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 29 May 2026 10:08:46 -0400
X-Gm-Features: AVHnY4JLbnwmK81W2sGlebVDgLa8m20IUvrZZeSXdCxVJOFe9JQWqR54emVNHBw
Message-ID: <CABBYNZ+UDuA=HDFrs4hUHfJyL9buWM52JsZZTbS4SQC5Q6WE7A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: hci_codec: validate capability record length
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, kiran.k@intel.com, 
	chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, xuyq21@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ren,

On Fri, May 29, 2026 at 9:12=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Yuqi Xu <xuyq21@lenovo.com>
>
> hci_read_codec_capabilities() validates each capability entry before
> adding its serialized size to len and advancing the skb.
>
> The current check only compares skb->len against caps->len, even
> though the code consumes the length byte and the payload. Validate
> the full record size so the cached capability length matches the
> bytes available in the command response.
>
> Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cach=
e details")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/bluetooth/hci_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
> index 3cc135bb1d30..5bc5003c387c 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -100,7 +100,7 @@ static void hci_read_codec_capabilities(struct hci_de=
v *hdev, __u8 transport,
>                                 caps =3D (void *)skb->data;
>                                 if (skb->len < sizeof(*caps))
>                                         goto error;
> -                               if (skb->len < caps->len)
> +                               if (skb->len < sizeof(caps->len) + caps->=
len)
>                                         goto error;

Id go with skb_pull_data instead, that could probably be used first to
pull caps, and then another time for caps->len.

>                                 len +=3D sizeof(caps->len) + caps->len;
>                                 skb_pull(skb,  sizeof(caps->len) + caps->=
len);
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
