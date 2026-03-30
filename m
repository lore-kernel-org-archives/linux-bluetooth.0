Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72938A710
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898266; cv=pass; b=Ao9vjJpY4C4/nYP5WeF+I6cgC4HV1A0K0krw6inJuTVjMihRuS9vcSHbSxGO8RTkej+lDS4+w7Jxy5me4Pk6tyESd1o/RnGc8qE3z2gJ4vqkvIRiREU1KISTAEPVDyLyQ9TPQ0oRv6Fmj2m0+rEZN7O1B090Bx8CvbuYqjfabRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898266; c=relaxed/simple;
	bh=ZLMUdyFR0s0atBItvJPUUf6FOevOONEj+aW/7Em97gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnFr/N3oR6qDd2Cq9ADPqzvp6wIaes22HG9aDgj94nHB43kkq4FyueA5FfXWimZdSd5J8WP02JaVaVFQrBEvx1tP2TAC7X0q2o+bunNplfLHE6FARe9nV7TBisJyyzN7BKeH3Xi0npxPQ01IhCf8D0yuYdssO6qNvCV7FTs1qHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9M9A5hi; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9M9A5hi"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6500040ef85so5140252d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774898264; cv=none;
        d=google.com; s=arc-20240605;
        b=JWXQjzLs3fPEM6FrW493ObVoHxA9elBdAK07djb1VQt3Ow8kTUEABOrRuT5r5ejALw
         clX8UbUeOcvbJETIM0pQYqtzq8TFlmz/90flI3gw+nZ7bUDUyk3mrywMpmVfWBLAqFQ2
         Jt8gsZYfvv+QvLx/rkIH5yHVQmkHlguY/X6YAF0AePOcNfiS06xb1quUyHkNl9hvGd19
         3NVPr5sP8ldbT2Y6yBdbdnpaKN6NUGt6Lkw7PcgfnOR+mopMOe/YqSE3n83MakZv+75R
         YOi0uJSC4u3lvz02+WQl8ulRThWybMcl4hoKn/xgIiGuJ2T3naCdH2k8ZwYBAohuL6Aq
         aamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PsDUeWxt4dU3e9vNZ1nwe46D5bJW2dCSewJJB1Qp5l0=;
        fh=HPb2jBnUajnal2w8HBQ5hlAKVmeIH7FDgKgkN87+HfU=;
        b=Q58LNjA/DIo7YSS+sIRd25RD9ifuORfX9T4gm1d3cTAt4u5NM3ALSPjc3btWOp2Ax7
         X1bkc0JarORgvkwNMbkkkN/+Jyo6SNRqyaPPAIckXdOLnU5n+AzRI5rJ7f1doU+dXyBT
         yIUZwbzXYsH5H6158MUHeC3nS2l73vzRylk329veCdJGr9rG+ehmoaBZGhWCQilvGNZi
         QBScb2PhrNmHALSVSyign2xr4rKLaYZL/gdqapCaBrOuoAatIhPZEP/AEGklaA6BtvSl
         dVT3nwcUgU+TdUvQ7v+DGTHtwrON4nabQi0ArRNtVorCDwGlbz9YzCNiOt8qBF9Cua1C
         39EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898264; x=1775503064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsDUeWxt4dU3e9vNZ1nwe46D5bJW2dCSewJJB1Qp5l0=;
        b=n9M9A5hifrqOEUOCLoTZwIPbux0Au6YrsgmbjSLn+XHXs+GWHToJDx1BxfevTJefLT
         9lTEtC51J9lLNdAv6fyyB842+0euEy3ntsob6cCH4CxkqFQXxUqufI1wH0ojIQd6UDFn
         zT7ZfFnZEGraCXgARwlUw5mw8xtr7kqsQTfZCj/zBCM5DFcXBSKytKIpv123V/9/rrSv
         0mSaUPMRrwi5PVfiOdDWtn9nB1GBe7RXH/AGBd5gMgEJ2vKGdR3lr755MkzaaTn4saL1
         SvV3YRB6XHSnqXo7t2N0RSOwrucCevJbRLOVEmVAiWcQ4yKes50ZmhnCsHHqvLPKU/7R
         bdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898264; x=1775503064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PsDUeWxt4dU3e9vNZ1nwe46D5bJW2dCSewJJB1Qp5l0=;
        b=d97pePoJ+e7et59+CZ665S3M7LrgTlObUBb2qdpMNbLIbNXTvdooMl1lWd+Y1l/IZ9
         AjgHj+XxA8PGa75CBsCwKCHxcXB7hKc74qAq4LmXpqiDYyepcHHMyXQtV18+zknHeB2d
         Of6i2zxlodMJORzvi5bzfpoitLBiT9/m7Hl3nVwfi6AGrtMeonreKirtWzcAbexQJ+5Q
         uWNMcCRxfRdpPxtJRXbYxUFksJb+gtXfvvcpuNkbCe/XU6n/FWqdP+PSGfS0CJ5OZjEt
         WpLQnUKTvYfTkYkd53Hazx6P/PyzhMY/CDzk98nOzqE3mJxeIfFWwjA+4ZTpf19lNMMa
         sHAg==
X-Forwarded-Encrypted: i=1; AJvYcCUFBwcZbx9/5ZC4mDyY9rU2sUEH4q0Xvu7v0E3jNzCUQfVnGkyPynDXyDceWsy7x83LK6JMMzLf2XNhNBVvdDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4ZZlDET/M2j2pSfA5/GEsm5W4JQv3OVNWb1VKwSPkFBjCZsi
	SoQqTjZkBexHLKCPBUbj10jxUJP45HdyfqnoJkSrJM5mMNULSiBtrZMUFTRuiKSa/N2xsTWfpVm
	Z9yVSlYm3r4mdgaeahWtIVZ2UIU29tnxlS10F8uQ=
X-Gm-Gg: ATEYQzzNKQNtiOJgwry0HMevHH1o0r03/tFcP9GOcgdsvVO0ChbgBwoQUHyENqjKd6g
	eoJCMvm0E6DH9Y71NzswMglAa+9gtWFGXVpyibwO8k2wMTIK3gBmVseGtKIwVJttkSCWXtk9kFl
	cJlLRzhfK71dgkbzTwebPex8nQJXiYYBdlYKm9+pd7vqwKKHcAC5y0gpIz3Z9JALYLI3jaOgBhT
	Y3LXzC1O+rJidIJ4M3vCp/sgdUUZgP+tXRc+HTjdnCa1Q1scyxyx1MEmTjvGB+MW30nswNy1eW/
	A3Fga59YNdK01+SqLgyBzIV1U5gpMhPi9lpvFyyNGLsCSPib5NJbw73wCns4JMJqUqU=
X-Received: by 2002:a05:690e:128c:b0:64a:f3fa:af4a with SMTP id
 956f58d0204a3-64ff7196050mr14115855d50.5.1774898264472; Mon, 30 Mar 2026
 12:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330093311.1621965-1-johan@kernel.org>
In-Reply-To: <20260330093311.1621965-1-johan@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Mar 2026 15:17:33 -0400
X-Gm-Features: AQROBzDuYXajgeMMEJ3X0nA4kajx7nwjaS_zRfE9epSkwR0Smj6Ffbh7-YTVXwY
Message-ID: <CABBYNZJeGyDAj2jUOyOA1gHRXDS8LeYzWfT-gQpXfTEzMCH4sw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: fix wakeup irq devres lifetime
To: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, Mar 30, 2026 at 5:33=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> The OOB wakeup irq is device managed but its lifetime is incorrectly
> tied to the child HCI device rather than the USB interface to which the
> driver is bound.
>
> This should not cause any trouble currently as the interrupt is only
> enabled during suspend, but it is technically wrong as the reference
> counted HCI device could remain after the driver has been unbound.
>
> Note that the data passed to the interrupt handler is not device managed
> and is typically freed before the interrupt during disconnect, but this
> is also safe as long as the interrupt is disabled.
>
> Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Cc: Rajat Jain <rajatja@google.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/bluetooth/btusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5c535f3ab722..4c5344ce16c1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3801,7 +3801,7 @@ static int btusb_config_oob_wake(struct hci_dev *hd=
ev)
>         }
>
>         irq_set_status_flags(irq, IRQ_NOAUTOEN);
> -       ret =3D devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
> +       ret =3D devm_request_irq(&data->intf->dev, irq, btusb_oob_wake_ha=
ndler,
>                                0, "OOB Wake-on-BT", data);
>         if (ret) {
>                 bt_dev_err(hdev, "%s: IRQ request failed", __func__);
> --
> 2.52.0

https://sashiko.dev/#/patchset/20260330093311.1621965-1-johan%40kernel.org

Not sure if it is valid though.

--=20
Luiz Augusto von Dentz
