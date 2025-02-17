Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7782215F64
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803526; cv=none; b=jfe9qzf8XXrRKSjg56viJlXombjFy94EqTCs2tQCSojJHRe1R7O6iIjgFomDjqi+M9ca8N3/Ud8dFCbIbjU7QI2cM+ty5uLXeFxWNDvYW1iOfq1LNIZymmKmx+iWWhYhs7B1eT9VrplMD8i9d0o/GuWfKPp5gulwLHCPjJD80tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803526; c=relaxed/simple;
	bh=t+oZt7IndNP/8SmQcZ3LSLfv1nslPzZjkOU5ra3yCqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etXXPk+6P7tQblJw2jVITbgmhn/Zx58bRnmMO/e8P1+ZCZyPqYOMu87H28HrQK8IJ0TmbpGtxEmrC1EGZpBMBjc8JzK9KY4/97KwvCLHFwfK1/kEHlfuUe/JJnVHtpcahmeeOIzfRhMhfitlK8UDs/Zhb2jw1hIA4fA2zpDKqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=la30pZw+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="la30pZw+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f3dd2069cdso1861526b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 06:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739803524; x=1740408324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fscB/HBXNatMGjhnMNlSyD4Au+O28eL0EqtDOM3ibI=;
        b=la30pZw+Rn7IruSTR8/L5J6yfiCH0Q0koMXgLCSI7aFpBMeXb4nkhap2OeHfbHPaf+
         PLAhRcgMRmg9jEVtqckc6rBM6ZZizsg4gWz0DtVd6feHKmb9nnnD7fzwM9iFj4JfJBjy
         d19MFba3JhzgvmJVPQkxQBynJUFBRTK3lYLuESpYVwFBkVdBFaE1uhI86J2Jong102Ir
         7o+Pb9V1Os/OQzx+86qFUIyndn4VIyL9VCJ3TOsebfx5isAAt21l72iGAjZtDksuXP6s
         y4aB1Yeakt8vs32ldeC5NRfOrvvmz57ZnvlDwzRm0Mrpqhb7AWuGrWtJsDUkyYtsPDnY
         wPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739803524; x=1740408324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fscB/HBXNatMGjhnMNlSyD4Au+O28eL0EqtDOM3ibI=;
        b=svgvH1DeqM8l/ZbClNxzwOmMfRNmF5G5+SgAM/6/1evK9riysC0uecJYQaGoYr+4+o
         jkV+0lPm532TN4AuO07PWG8WlPIGHu8PsKoJcMqhRDB4YdJflRZpmvSS3tWboNrwk8FN
         JDAfHIllgjlbJgH6hClrSApIk2Cw1GhNLxfhoJH+xu+QA8i/JzcUPcHE2xbFwLuK/vwS
         nl9fPhwxnYOsaa1apPdJeFiPkPX8nU5pY1hl/jugrdJNq+I8EUhVdvc5mZxImGAfTDUR
         pA4fLdJ0fOGqXkeHGuHjBFLCOf6rsLDFCvj8OP/wcf0xXICIRms2IxAfkvCXilZeoOmF
         SzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwy4WYJZVrlHKdCV/8BT2rPaOJLoEVv3ksZ6ybqmo48vM4S+gwGpKP+NW80gF30rlFrR/o2kOUHaNyB0IE7Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFeh2JwCeMANSTlu5CSQIv4DIEAnqn38UW1+J1pEh+7+3Wk8f
	UrSnCujhVC18MozvZ9eltXKVwBdUF1XJny337VtC5C+G9GCLXNC0uGf9f+oHuK8OGLIdSgFZ06r
	worssvT9+jdQwkxKnufdao+zAhU0kJkP7xungtA==
X-Gm-Gg: ASbGncu+pwnKqtA8q2T5aCz/C/IhgJzim0cHTPVDfrJ1BrmMI6a6oC2+yCztxrGtAWi
	XeieTYpT4jntr24N+cLNDNHcZssAAGKMoYu+PIUwmpMineqDrSbJRm2DUwc7yC0lf8KFHkWBnh/
	EDxq5Ia12ZvU/Lr4rAbwqWHER6Oms=
X-Google-Smtp-Source: AGHT+IHtBflHavgxIJTJbLL7oxHnaKAsycioNXBMoGSKJQ+huW+8pkoNwja2LoCuRv/MHb6NKGEalXQi3roVOvKFMYE=
X-Received: by 2002:a05:6808:1305:b0:3f3:db67:ca2e with SMTP id
 5614622812f47-3f3eb08a400mr6045732b6e.8.1739803523776; Mon, 17 Feb 2025
 06:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217131046.21006-1-loic.poulain@linaro.org> <AS4PR04MB969252FACA03605C1C0E00E3E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB969252FACA03605C1C0E00E3E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 17 Feb 2025 15:44:46 +0100
X-Gm-Features: AWEUYZmtOtsdxNSAzeJNa0db4kc4Ef4CfTUlNZjmK_5GPWhfqJwUmlqkCpdcnfA
Message-ID: <CAMZdPi8X6tMoLocskyEG8GwdpZ9i8P_R1bT=r1-QF+sb7ofP6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] bluetooth: btnxpuart: Support for controller wakeup
 gpio config
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Sherry Sun <sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 14:53, Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
> Hi Loic,
>
> Thank you for your patch. Just a few suggestions below:
>
> > @@ -616,6 +617,13 @@ static void ps_init(struct hci_dev *hdev)
> >                 break;
> >         }
> >
> > +       if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakein-pin",
> > +                                    &psdata->h2c_wakeup_gpio))
> > +               psdata->h2c_wakeupmode = WAKEUP_METHOD_GPIO;
> > +       if (!device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakeout-
> > pin",
> > +                                    &psdata->c2h_wakeup_gpio))
> > +               psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_GPIO;
> > +
> >         psdata->cur_psmode = PS_MODE_DISABLE;
> >         psdata->target_ps_mode = DEFAULT_PS_MODE;
> >
> Please move device_property_read for "nxp,wakein-pin" to ps_setup(), after "device-wakeup" is read.

Ok, but then I'll need to move all the default value handling from
ps_setup() into ps_init() as well.

>
> I think we should not set h2c_wakeupmode as WAKEUP_METHOD_GPIO based on "nxp,wakein-pin" alone.
>
> In existing code, we are setting default_h2c_wakeup_mode to WAKEUP_METHOD_GPIO if "device-wakeup" is defined in DT, and psdata->h2c_wakeup_gpio = 0xff. WAKE_IN pin is not read.
> In this case the FW considers default GPIO as WAKE_IN pin (as per datasheet), which is a valid scenario.
>
> But this logic will fail if we specify only "nxp,wakein-pin", without "device-wakeup" in DT.
> Hence, I recommend something as follows in ps_setup():
> - if (!psdata->h2c_ps_gpio)
> + if (!psdata->h2c_ps_gpio || device_property_read_u8(&nxpdev->serdev->dev, "nxp,wakein-pin", &psdata->h2c_wakeup_gpio))
>         psdata->h2c_wakeup_gpio = 0xff;

Ok, will do, look like we should print an explicit error then, as it
would be a clear devicetree misconfiguration?

> For "nxp,wakeout-pin", I have yet to submit patch for "host-wakeup-gpios". I can move "nxp,wakeout-pin" later if required.

It may not be necessary, I've submitted an other PR for handling
simple dedicated wakeup interrupts at serdev core level instead of
having to re-implement it in each driver:
https://www.spinics.net/lists/linux-serial/msg66060.html

With that, all we would need is adding the wakeup interrupt in the devicetree:
```
        interrupt-parent = <&gpio4>;
        interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
        interrupt-names = "wakeup";
        wakeup-source;
```

Regards,
Loic
