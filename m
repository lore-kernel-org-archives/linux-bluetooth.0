Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4551474D4
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305731; cv=none; b=u6gbkCjhm/SiWttTWJNMq9bw2fSAWpunC7Mz4LsaQ1dGeEwPTgZXxUtJFleys9v2pCIbmNjfoRhZveTMR1mRItQfL2QbG2pSC5czepYXFgXN0h3t89M6jRFfUWdfEKR2YPFD92XCZ/ty1cG6bpv9Hu7QAUvYAMdEGuqADPMDS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305731; c=relaxed/simple;
	bh=SH4aPTnlaAYgonWlc8AMhuTyD0/8JxTo055Gu9yTdMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeFW95GiJHJk+qFsG6U76g/JttjcL7vKen+hA05boa86UD89GfmrhW5GcJma4PO0oi5UnohsSQpakW5MatT8+iNMoFrg+PM/gEgGJKTqSmhlmah2vwQ5kzb8vU0cL8RgVPYoI85+tx4Ji6Xn310sGL/u8HaoxLghOUtdhZi+Wmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUSH+T+Y; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUSH+T+Y"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-643efaf0786so20565557b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719305729; x=1719910529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH4aPTnlaAYgonWlc8AMhuTyD0/8JxTo055Gu9yTdMg=;
        b=hUSH+T+Y58BtGoJQhTkdjeyXSND42CJKfsR1j7DPc8E68yv+496v2eb4un7xUMPjzc
         tWKTwnxlTHkOHuHKcSqgPVaqeYyM/GGk7Xv9LrlZ8ustDr84BeDU64Y/0UnN5wwEnaib
         j980+sksfDzpqbey2uQzzkI7cPf1RGFU9x6Ud9qiXqy4yVVHb9weR+Z29niRxZxAsM9n
         rHK83Fn18tgIOSvVuUUe7VegIG+7/sddNAdbqkFpF5WaNxMF29frcNhz1DtmQnZJHPHo
         AkCP7d69dI4Tv3H8OUnHt2ZiZL1p3F5g+96LdO1k906e5EkbkWK+9MFqI9qT1M72Lsda
         IffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305729; x=1719910529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH4aPTnlaAYgonWlc8AMhuTyD0/8JxTo055Gu9yTdMg=;
        b=beBm/7yz14woXNjSdEU0BafkZOYe4pkJ0SzOL3rZ3WJkkSTkY3lsXBmme8fPWtAR5n
         plK1zZq7d/NfQtM02uxzO7jcVmnA/d/NrXqifWv1JDLz3Gcjim76Sx9El3WHyLzw4Xeh
         cO6FNKfolWeEgsMh3NpeLD95fGagtbRn68t9xBkg7yyvTVTZ+aLyexlyTc47WzAHVc9l
         VyZARgYTxhHE8gG+ivuPsLo+1CFbIcqEWdROFbgBFk28j5OnLDiAXVRhaTzQBRsAL3ID
         +xI0knD9OCTYdpKfjKFxW/5KKAY0u20fklYEt/adhwiUjVlbw+DWMSFqQSzoaSjCh9IC
         0Nsw==
X-Forwarded-Encrypted: i=1; AJvYcCXIDnHI6p53Mls3aDnI7WceiTnffHXOMKKQmkYxDiKH9+yZf9t43jKomqSAeBaHWY8FWewM2RCsTmpL6uMskWBE6NBtUeByZZhegFK7fZWG
X-Gm-Message-State: AOJu0YzgYi7YUIMMSrMf8V05iMvTN5HiieMiaz7QE0D/4d4Ibdy85PqH
	xMDQ+jmG5LZ8B/oJnJcgqX3VqFywItvSs5NANa9ziaxAdSg7jEEPZUaO+Uth+P1t9KLLPOdFC5c
	OA6J7P1OEd50PzYazkSrByNv2hiiu9ZUfVzTT/A==
X-Google-Smtp-Source: AGHT+IE2fiY7Br3ex/7BAQtI2a+Y/rx5p/TZN7J3haCZToE3U9rlFaeHmgWC3DsztqmV+KnD1SaNV3qAYy3Vk3TOMmw=
X-Received: by 2002:a05:6902:243:b0:de4:828:b73c with SMTP id
 3f1490d57ef6-e03010eea58mr6447948276.54.1719305728939; Tue, 25 Jun 2024
 01:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com>
 <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
 <CAMRc=McZ+hrXyNESmf4pFX9+uDnc4AKsuO9X8AJsVgCfQVLd9Q@mail.gmail.com>
 <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com> <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com>
In-Reply-To: <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 11:55:17 +0300
Message-ID: <CAA8EJpoEUyBmi5_Zb0m0TVYi1BAMuqNfdDL7rdsTK6rxjsGpVQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 at 11:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Jun 25, 2024 at 9:47=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > >
> > > On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > >
> > > > > Neither of these has clocks that need to be driven by linux. The =
only
> > > > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exi=
st
> > > > > before so no commitment was ever made.
> > > >
> > > > This might make some laptop users unhappy.
> > >
> > > Like I said: without upstreamed DT bindings, we have never made any
> > > commitment about the device properties. I doubt anyone will complain
> > > though, I haven't seen any DT with QCA6390 with clock properties yet.
> > > I wouldn't stress it for now.
> >
> > I was thinking about x86 laptops / M.2 cards. I'll see if I can locate =
one.
> >
>
> I don't get it, how could they ever get the clocks property without it
> being defined in firmware?

The clock and bt_en are optional.

--=20
With best wishes
Dmitry
