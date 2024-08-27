Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978931448C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762537; cv=none; b=XDOfKWWEdObHtgMkgtUAwBxvNMbFCzmAmPKpcghhN5+S4epWGj5bg2W4UHEUyYrw6dGOZ5wUDUlmONyisiET1JRZXl+hfFbTXvKH5i+BusL6i22KyCIigEf4WjR6yPr/T0ShYgxGrqoxyhC4o2OENjkondJVhAwYDQDv6yWe5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762537; c=relaxed/simple;
	bh=lEfreM321xSd+3avShPWq2OnWWeBBa7cp+xqVrQpCdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4K4cDFDXDtVamNEIX4gNb6D7zIXurhfJZOSO9zNsHAOYskIxdBzdVozllI4oTj88q81S4FfVqCV88Esg7IUlkQrfqIhkWcn+rXffc+oxpx/doFVzdsjxguxQ4jhgMKNpigD8azJLzs29J2q8FjFN77cWZD8amsFRcA1AdciCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL1lEZLV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL1lEZLV"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f401c20b56so47439181fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724762534; x=1725367334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTwXeXPR91gLl2d5oyKgd6+Qja+mI4JCiRWk81FE5Cc=;
        b=JL1lEZLV2i6QCKhUHSLlqzCE3nJ36d8rVyfVFSP+1h6N8MM1hfP6mYMDfoY59TjzM2
         KkdE08WdsPzy0CfY7EqEdMIxqmv7Z+0sYFaX1b1WEfbz83XliR0RPBmgIj+51NwzZEVl
         /XXvMf0DY3hv84VNCg1wJfS4p21IWnpVg3o4WpWttWFKzZb2tq/22QpC+vskrAjMLPxi
         Oj0TDS89TCDXKarGTzG383CH98QHcNgEyJ8enEB0gc9eAN30yK24v8cBfQR0cFclaN17
         nj8xtoqOwA363fWt8J7Sr38qitfQXh+gZbiahPZKwtrJ8DqJMR+279OiHoNeejXXI351
         Fsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724762534; x=1725367334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTwXeXPR91gLl2d5oyKgd6+Qja+mI4JCiRWk81FE5Cc=;
        b=PosIle2y4tYjjuczWtcvz7NLFs+MVyc8vZI/wlhEy4YLfQ6+BIMg/hyl4VcBaR4kcV
         vSVitt5rbImZHDpg/rploZZGJKqMapuOVb7JEiyNUTwCRMw1L+28vrpM29PGuLigRrm8
         0zU2CK0bl/mVTH2oLZRIIntBZsnr2a6pEsOdv4YDWVOPbYQZyyskiRFezvQ+xHAxh5AR
         KY8QXpjT+vOkAtR0/Tpa8yoeLIhHM4Fil0Tb9pxqwTNbfADl3KTV+uG23VxoUXgeLwY1
         ZPvXBytuouHnQ17334m9BUXEozy5i5A+nVqqwuHYDXab5u6YPxvXgjC142H9mwtRB756
         agbQ==
X-Gm-Message-State: AOJu0Yykl1UXjPX535CCBi7LapfaVdeo47TI6jYShRZi+L6oTwKIKA8k
	MSqoSzG2mzAXQWRk0NubszFRc4xfBDdCaodUORzC8Csq+PwLwcmt1cg8l0rgMCtw5UatNg8+yfA
	GVS730rVIK8kW+GKERtH9fqWpVxX9MvKO
X-Google-Smtp-Source: AGHT+IEDiilBsOnhOm5VWr1GISRQgAQhhccW8F0lJ2aubm33n76n8Z2CD8RpZMtxu+GVEJmjBqg2tnr4KX9brEz070A=
X-Received: by 2002:a2e:bc1e:0:b0:2f5:23a:1055 with SMTP id
 38308e7fff4ca-2f514cd3964mr10566041fa.18.1724762532802; Tue, 27 Aug 2024
 05:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827081333.55914-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240827081333.55914-1-xiaokeqinhealth@126.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Aug 2024 08:42:00 -0400
Message-ID: <CABBYNZLKkz-DaR3TPSw6kfZSqRoOcQjmmmsPXjo6qGJQA1zGOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: mgmt: Fix LTK load error in SMP over BREDR scenario
To: Felix Qin <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, Felix Qin <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

On Tue, Aug 27, 2024 at 4:14=E2=80=AFAM Felix Qin <xiaokeqinhealth@126.com>=
 wrote:
>
> From: Felix Qin <xiaoyao@rock-chips.com>
>
> Fixes: 59b047bc9808 ("Bluetooth: MGMT/SMP: Fix address type when using SM=
P over BREDR/LE")
> Signed-off-by: Felix Qin <xiaoyao@rock-chips.com>
> ---
>  net/bluetooth/mgmt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 25979f4283a6..13bba6ad5d95 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -7106,6 +7106,9 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
>                 return false;
>
>         switch (key->addr.type) {
> +       case BDADDR_BREDR:
> +               /* ltk over bredr */
> +               return true;
>         case BDADDR_LE_PUBLIC:
>                 return true;
>
> --
> 2.34.1

I thought about doing that but this is not correct according to our
own documentation:

https://github.com/bluez/bluez/blob/master/doc/mgmt-api.txt#L877

There is also the question of why we would need to load BR/EDR
addresses via Load LTK when that is LE bearer specific.

>


--=20
Luiz Augusto von Dentz
