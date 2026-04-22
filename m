Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493431F98A
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869948; cv=pass; b=CDptVloYkW61mabgEjBr02pI/Sv3U+1A7clFXDZ4GcRZ7c+GaWPWpsW9YW0owIgbnzIGrvLjdtuHScHcuFwuX4P5oyyJxoFngujuKUDOIqI7BoYNWfn6RBtkVmiBR6jh6xY6fGG2bzFzE0S24aUxMMZcPbYawvwN3T9qimXKmrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869948; c=relaxed/simple;
	bh=beSS0uV84ciXe7hTLQM40nPX6ti9qcIm2YbQa4xRGuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fx1U+qawa4x5Qj+//0on/iN4hwvkU8mZEiISdLsUk6ZefGYOPWdDtcePuMXQO0Sv1ETEQxpRa1dNME91rFJPIgN1dk5V3HWoINsH94ajHdblDs/LtmE33TJBRlff3qFuABekWHI6Jxt30UJhbD+dIGuOPdxNlk8AqamhNS10FQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShjOM9KN; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShjOM9KN"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6948da50eb5so1644502eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 07:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869945; cv=none;
        d=google.com; s=arc-20240605;
        b=ZCmXk4rDY+WMqWBLU1XfW3vq6646cBZQdn38BL1c95GSPqeASG6eEHm5siBMF/hwny
         wVdnu2t3mS7zjVznQszf1N6KaeDaRjGFzKb1YYoohkXjw0Dgkb1Fq6TIAUpaK4mbqiNu
         Yayh7BBAPHgUiKoLtgQJGfzwkTiURaTdW4ZXNDo6pH940bbBc3PzZRbucAqIN6HQw+my
         pGKErE/wUemdkYV/xWUjlLZgVmHITU7BiV00w7g40Kqf1bUvVy8/3//a0wnb5OOziND9
         KYfKZvq/i7+L1NI+jawzytnk6qEpiM/ljcjKoSuo610s5tVNx6zHAav0jvb+BZyrj2ql
         IWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oQt7JjZxjs4Oan3dKiOCcRshQPydYgKWyrff6Kx3d9I=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=WRpVzW5jEJLbzFI/EA77k8uednyvA2rpRFiIT+FRaMpLJGgaX5mJnQlthJIgOGU4Ik
         O8THOcKtcUow8vx8ZK26ZLILXCwN62zcIYNXdBTCkCoK6HVUyQqME0affqwoKd5btUa7
         9tFGmb+hpVtJk3k8m9gPno5D7aq5CcHiOpFTXjL4cFWHFmjDit4y2KEHVxMuy7OBNzPs
         hxitkoPuYKWyupC3eiUS0JjMhOg6iuN7rjpMG/shNCMeBGEYyzohyNqwteQHd825UvgZ
         hCVk8AzZFqEqyD7VU6UyRx0vz+KneJcvctRFInRNfKg7S3GRjaAEs29JjBpA/yF46xy8
         m2YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869945; x=1777474745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQt7JjZxjs4Oan3dKiOCcRshQPydYgKWyrff6Kx3d9I=;
        b=ShjOM9KNXIddFHP4reSbLgWY6RAKPCnt6P5K/LW0KkFW/bxpcfNd45WeT6wXW7/zoQ
         X0bResi2FnaKHolUr/KoYt2UkocuPMqp+wsMHqbBPcrxqYH9o6OcMzm0L1x3jWTqziop
         U5SY3hszmwK5coFRdNT/ivWHlM4Mbr1WvbHHLirRdtB5mzzOtg6AEbHNGmVZACLZtf8/
         expBEfj29oS+e1wc1MObJ1IBdCtSRPuOuKql8w+JzMQ9BbJ1SC+yzMQujaH1JCPQ2mdk
         G735XOvv/a5YlCZIpNfeRcfFFgU0hCzIRwJAW+WfBkIigIAaK+BvhF/unvWu7VO5GRjF
         NOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869945; x=1777474745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQt7JjZxjs4Oan3dKiOCcRshQPydYgKWyrff6Kx3d9I=;
        b=N/FlL5VASTVDX7GhFEsUl/FJyShLd7TrV6VfTpJu0GzP7oeB1Z1fFlYPFqv17yog+t
         H35NfB8fhPejJT/23LIAzDKpls3tBlHOQA60M32mm+l7AOuveYRQQVRO2rGTsE44b9Lw
         EUvDEV5E02TpY4JzYsCBpkHERGRk1hghPaqfK+nA/6YKCPPBh7pme3u0W5h8jE8eTsm3
         zFF7bMbBISQM3GBXKzsZlI0IhUl50dnFgBxZN16hQE9YKljIPoJqEwaHgp774eQKtWad
         u+j5Xo3cevKd1vpxK1pTnjqRK+VzsZ6mrVfO+GupiCi2cfMMbWyLfQKjhNQQLpY67ao2
         cqPw==
X-Gm-Message-State: AOJu0YzxmRUMOb5idYKKZ2unanJni6FqL8sitS+uk7dgYP62KfN/3S0f
	umzdRBZVM5ASOOBvxJjaJZsn610pOZLZouWdfagkYEBTuOx24QRBT95E0wem04LtCiQjB/h/kce
	NtAeCXzhaPhVs96X5DMQHoPzjNUfHwEfxvx9ZKpo=
X-Gm-Gg: AeBDietXh41aiAJYglR0LPbQk2DpSQLoKz5xRqb/hVvTHRkjVNSKsCz5HkQRaQHyPhZ
	FYwHieM7oYYQmgIHFvyUXz8xEYHcPMg+/qnYlpY7Ik7nF5BpaT5Oy9WjqMhi6odlQfQDh1VbHSc
	nZgDIUBmaZ1cut/JNvIvOcu7HfLBunUrNzguX4wp6WVxdgpQ7l0kvxkYWKvJhoxnMjS7H3PeU8/
	ZLSLJTYp5rQstVHsDG9kktXs14oBlxTJr7sPbfIoeC2WGbaKLr8hjO88IKanuNrcnE4EVxq4Co5
	zOFtQ9TxfnUBuM2MTFk0kq1/bpGZDx4LddXoUwLH9LAuUsjNpfdirBYJskr++uo2Xn682hdIFVf
	0fg==
X-Received: by 2002:a05:6820:6602:b0:694:9cae:bf3a with SMTP id
 006d021491bc7-6949caed790mr2106432eaf.34.1776869945205; Wed, 22 Apr 2026
 07:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421202253.1957689-1-luiz.dentz@gmail.com> <93591251ab13408ba014fff8b9bcfc171893e232.camel@hadess.net>
In-Reply-To: <93591251ab13408ba014fff8b9bcfc171893e232.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 10:58:52 -0400
X-Gm-Features: AQROBzClKj2RgonEVc8sbLLp8f_BqG0MpNebJ0VT3LF8QEBcYjQ3wj4O0lkuwLo
Message-ID: <CABBYNZK_h5_tttq0pJzPF9GOwr-W=e2ssL4dADmiNQuxvzKtZQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] input: Fix checking LE bonding on HIDP
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Apr 22, 2026 at 4:01=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Tue, 2026-04-21 at 16:22 -0400, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > HIDP is classic only, LE uses HOG, so there is no point in checking
> > the
> > bonding with the address type which in case the device supports
> > dual-mode will map to LE random/public address.
> >
> > Fixes: https://github.com/bluez/bluez/issues/2034
> > ---
> >  profiles/input/device.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > index 6bdc5ee3aaf3..0ee6988c4e90 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -127,8 +127,7 @@ static int connection_disconnect(struct
> > input_device *idev, uint32_t flags);
> >
> >  static bool input_device_bonded(struct input_device *idev)
> >  {
> > -     return device_is_bonded(idev->device,
> > -                             btd_device_get_bdaddr_type(idev-
> > >device));
> > +     return device_is_bonded(idev->device, BDADDR_BREDR);
>
> Do we want to do the same in virtual_cable_unplug() in that same file?

Yep.

> Do we also want to apply this to hog_accept() with BDADDR_LE in
> profiles/input/hog.c ?

Not really. In the case of LE you really need to specify the address
type since there are multiple options: random versus public.

> >  }
> >
> >  static void input_device_free(struct input_device *idev)



--=20
Luiz Augusto von Dentz
