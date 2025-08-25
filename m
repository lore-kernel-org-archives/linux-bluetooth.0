Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84347393DF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153020; cv=none; b=h8K5to530TsKhbBYaMQzpkB2vNltwN22sS2bQACiFBHjbaBdrmR/GWORCkt3h+NzRwQgaz5yynDKkSRlGTAO5lSIe+gPyNMi3CJwuWD8Hj0vClcUnyCstoXgWI/6X0thz1tOrNT3G4CQm57kzIlcWiBBaKFo5so7rU1/+R49Y0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153020; c=relaxed/simple;
	bh=/U/Drd2jeVjmqVODsR9uJ67aDLh4mGSlv++vves9KZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qldTvMjHJxzmX3CzYbQTi14BO5L5X6iI9jYwm//IohPf+kj8xQ+w+BhW8w28rvY5nDQvWQjBPTeaQCEP93OMFgkuosl7o/xmcH0UrewdfejE4BnZ3Gox5XdjV8p99bD+ssx2DwZlAI3idsffqsTvV6iNk5mcf+e55r43PfQinE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i59z6FIt; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i59z6FIt"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603cebd9so54931347b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756153016; x=1756757816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GMc9usLYCiU5C1eksGWmn60it/4OnWjugBhQjBS8wEM=;
        b=i59z6FItErO6mDJy6+xSpurC+oU2eefwoTGkTpOkD95TWtbfHoCeFuCc7S8eOPVxdO
         f/SeWr0TnpafVBrPY3t5eJDDhCMRknwLbQxMnhDy1oPyudXNIdcgAzsubOc35WytJMSp
         MXS0mRPFS2MRuGGRCORGiVRF7I6SlavZBaUkCGfKLMOxQIkcAwoH2fYXUjOt/fSdmOQV
         shkka8vsNubYuqaAdHUorfY6gWmSni4n41qfdbSjrI6rzk8dFovSKSjZwDkDGGTstMR0
         3Y9WYZfcLJKgiYaof2yEUDnp2Y4LLdoWG34vziJ4RzqtSjZgwnA9IQNAPUVAousD5sT5
         84Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756153016; x=1756757816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMc9usLYCiU5C1eksGWmn60it/4OnWjugBhQjBS8wEM=;
        b=xECqFc8t5nZtJg+EPgKauuwYjit+3JJGx0PGxSAm4uMRuM4KlWAtSO3DS9/1n1mNng
         wy3Nfl+KzOuoxMLXS/j29gXr04NhjTEUss6tJwPXYmNf2BxuM2JHT+s99iRm46NcGyuq
         NSYYwr0RX0wPPjZPrr+x8rlI86ylQ8czy/Yc5LKJeQNDS0q5haZ0njAzQ3Q0enyHqHR9
         a1VSAeJNQhTSXgd76+5iJn9/udrjTpG3lOoDMZUZAyW3zwuS8Nj2qWZTSl4wJ5Fu4x7p
         QYpjieM2trugYJe4/ElU/P6lqCFX2R34yXbaNfL4cI/OD5RGAceqW4n014dUv54O8hCq
         1e+Q==
X-Gm-Message-State: AOJu0Ywwr4g7MnsdsreeEP89d1lmCiRXAbNn2wZjl/+vwfarjIJbuQpj
	89tvnBk+R5DXliIQTnt4+AlBFm5EO6T7IX1wQiD9jxA7QMwp0iyRjszj2te3QHyRIVxuxg9VzUK
	E5byq2+K0SzqqeQY1L9dSGs02q7qMWAQ=
X-Gm-Gg: ASbGncsOQmwRnXalXGPhI5gFXIFuWeqmtrhuufZC+v5ZTxY2ZkzR8Iq+Sp/Rd5vOiaY
	U/pcqAWEVayUo6/Ba6lW2pVdayeIvOFuJ+q4vVqhZxybgT25f5twLtMSSQ7WeP1aGLRXDhjjY5K
	OGh5vPGHhw0Fs/c7aZrTo5u/AidbzPWEftCLWLUttTt5HZfOLCL+wEUkrwZ4i+9nJR8Ou8RxK9i
	gj/zHvo
X-Google-Smtp-Source: AGHT+IH3p2J5h1AVoNvNo6u1TrTalq+T1p+ijxGnGiNxqrAw5zxbSMMxQItP+VJyHxab1lpfvcLcfRDOXR6gRDWhwYc=
X-Received: by 2002:a05:690c:25c2:b0:71c:7eb:3556 with SMTP id
 00721157ae682-71fdc32724bmr137187197b3.15.1756153016282; Mon, 25 Aug 2025
 13:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
 <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
 <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
 <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com> <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com>
In-Reply-To: <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 25 Aug 2025 22:16:45 +0200
X-Gm-Features: Ac12FXzePq9_GbWD8qEgqI0a-zKusy2EL7QTbyW_fccOiqED-7azqTlxpWTCLt4
Message-ID: <CAGFh025HT5=Fcx=tj07hzCG6=mRmH28YY6vijce0w7Y_FfBpww@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Could we solve this by doing:
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3595a8bad6bd..168b07041605 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1194,6 +1194,17 @@ static int btusb_recv_intr(struct btusb_data
> *data, void *buffer, int count)
>                 }
>
>                 if (!hci_skb_expect(skb)) {
> +                       /* Each chunk should correct to at least 1 or
> more events
> +                        * so if there are still bytes left that
> doesn't constitute a new
> +                         * event this is likely a bug in the controller.
> +                        */
> +                       if (count && count < HCI_EVENT_HDR_SIZE) {
> +                               bt_dev_warn(data->hdev,
> +                                           "Unexpected continuation: %d bytes",
> +                                           count);
> +                               count = 0;
> +                       }
> +

Yes, it should work. I was afraid that a simple patch like that, that
affects all other controllers, might break something. So, instead,
I've added a dedicated quirk only for affected controllers and only
for 0x1004 command. I can test it later, but it's simple enough that
even without testing one might tell that it will work as expected :)
