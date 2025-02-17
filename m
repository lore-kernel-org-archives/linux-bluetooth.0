Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CF2253BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809738; cv=none; b=hc5T9KHhmaxILM2Hxp0/M0ZNIPkJqbwULXb/jEnZLR+R1tVZQCdv9wLz19q5Dg9cXhXcyMr17j6HgPsJIq0YcoNW+408hwgnUzP66ALUT51SJIqjuWMD113ttpZG/hQFLEqdQQBIQI9HUDzIty2rB54cUKVfSyIxqFXSDOdvwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809738; c=relaxed/simple;
	bh=0CB5fwHH8zokxnQ/Mo+xn8c+Znu0cCFjYYuwOqyjhGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yg7tK2m9ZiHYhWOua1wtINlbIi3wigjJAGwRBkT+PA25ScgSyxMmscolRmk5Tgmd1IYzcUooPxNGLFWzgBaJvtHC+X+ragTbUh6w4qQQE7xEC/swLOTvnOpBFNhomGMsHaZQNRe1Xv0/uiHkg35vjatwEYApRGy2xLF350UZq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQfJDYET; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQfJDYET"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-721d213e2aeso1394666a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739809735; x=1740414535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24GrH5IuA8qEkGV4LF5HiIKLjQKovFe+/mLFQDYkKOM=;
        b=DQfJDYETpZeE4ngwg3Rhr8f28qBsTlrMM4/BHcNYZPCJAzq3khku0q52M+vjAyf2WN
         2ld17a0LCO3qhf4isY0Kw/6nPRr9XrhYpny2jtD9U8e1XxeOFMaHmKEdj2PEW/lZExs9
         l8C9PUi1tvqxsGimLJOyUDSbWOw5EWdsGQD8d1GjoZh7pWKUlADp2Q0frt/Jjh102jSM
         WKKTC8qA67zVCDzPRep+CLwuY4oKBGN66NVwvU54pcI7dvlBks+P54OVQYlaDYNBHYOK
         U1a4i1lmOKLApaEeHmmBc6IJZa2Frr0jtYFjqUoNLb6Rs06rhqWsxYKOscQg4qZECKVD
         7fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809735; x=1740414535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24GrH5IuA8qEkGV4LF5HiIKLjQKovFe+/mLFQDYkKOM=;
        b=i56X6qqlcKxm/356F7XuJbaIV+MFwSIF8IUiQrAlCi0ZO5iZFWunozy0UCCS0bdpif
         reC0cemLSBlgUd+RS5BLbQMXW9toZhl+K8NZWpQxVkV+NHzUovWgaXn5OyWZbqCXMmck
         6oA9+zFr2VcMWEXnf1Hr1Dp6BsdTF62ihqZv+NqeuLag7CHsUZQ0ghjY3VTqRX05d2Gk
         QJO77MsUVvdrTunBGc0bdrS0WOdyZeaOX0TZhcZ3EQmtbHnBE60Q9h/QVIe1yVGjDJXw
         TYVPwCLpZ+33zPcP/B7N/vwNS82AbnouI5hPwxmq35Qyfoy7+zwc6qOckp54UNHpU9mw
         ckZw==
X-Forwarded-Encrypted: i=1; AJvYcCVUniu4b9xJ8ZB4beNe9bBV+7HvNHz1cRX/JE0KNzKe1M7yRz9B/BMMWZd6wONOW8PDYL2OxZYc4UOBExl9O2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4M2OhIno2MpyLcpqTrKOBOfAGPolzkuqEzUVm5bmk5kaAxr89
	UXmx+l8G0in8GpX+9QYALBKnSbyMNZW+LV/DC2p1J5kGaF4vtNqT+9sAw25NwToGuzlemagEoFg
	q7H97CZKe9bhQTR97CnRrOU86mNq5u+85TEtbIQ==
X-Gm-Gg: ASbGncvPCyE1dFZIssO0IaWcVpR/cakgCJZLlZpYVQux7jIYBlSftEm9CbVKpZ83H0b
	UjLmsIjl8q+eU5OIpAPNkJCf+xNeKsF2kNqK2GPCweGSfo/nKP2WXwBdjPk8BLnGP861lt1lPeh
	I1wumxwijFuvebfR+9moqMAjr/ulU=
X-Google-Smtp-Source: AGHT+IEJfjMYsaEHugbq5fayTmYm/hadQIHS0Bh9I4bt3eHC89k8I0NSYzaRS3Gu8W/kVfdPon+l64H184jg72qrFeA=
X-Received: by 2002:a05:6830:25d3:b0:71e:1392:80b5 with SMTP id
 46e09a7af769-727120d40cbmr7778088a34.24.1739809734935; Mon, 17 Feb 2025
 08:28:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217131046.21006-1-loic.poulain@linaro.org> <AS4PR04MB969252FACA03605C1C0E00E3E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB969252FACA03605C1C0E00E3E7FB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 17 Feb 2025 17:28:18 +0100
X-Gm-Features: AWEUYZntkVL0VSowVLHqi6GFC7e8AvMLX9AGbnZaOfVfpKleEmxvN8J7_JEwYGY
Message-ID: <CAMZdPi_apyYRRTTGFwXHcZLNcUks6U3VOQg+3NQwnk2pR8Ldmw@mail.gmail.com>
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
>
>
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

I don't get it, can you clarify when we should default to 0xff value
for h2c_wakeup_gpio? and what it means for the firmware.
Before the above change, we apply 0xff if there is **no**
device-wakeup gpio, so if wakeup mode is not GPIO.
After the above change, we apply 0xff if there is no device-wakeup
gpio but also if there is no wakein-pin (whether there is a
device-wakeup gpio or not)...

Regards,
Loic
