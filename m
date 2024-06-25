Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC713B5B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306110; cv=none; b=dwWRxQihfS4KDCizTrxotq+7LoSXnej/kdkO15a8tOVL/dFV30u4auXtx2PUENzBv2s1YtAC4pV5aAGhJgF5Oi7E2aCNNEKmIbxSMdyUppQTn6iF95b8iL9vY/7hEd2XoQ1F0/pBcjc/9VvBYDRpV3dDL5/pXTW15YEhVfWCNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306110; c=relaxed/simple;
	bh=DbrIu8cHmgVHX45JsejmvqSnBtLm4a/j/cjG2ex/c9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXBQ2rhmJdEEPPWRy8jJE9AQAzQX1fO7S7u38WFS3hz+ENvSZOUx2nFiK2GxhEJXh+WcjjQ4me8rNnw1BdPs54MJqrKBZYvqYPSCvhgyLoKM67u/GeXIhheN2W4bqTYygocpy6rTCMM4NrM0+Dy0bBgDutZYgVWCPt/9AmPw03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QxHJUVO0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QxHJUVO0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7152e097461so3323368a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719306108; x=1719910908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbrIu8cHmgVHX45JsejmvqSnBtLm4a/j/cjG2ex/c9g=;
        b=QxHJUVO05Rp4KfN6enVjFUvBUuZhLpbQnvVN/RDyUUOnX+FOtstfPGheWey8bBdfbe
         UJixcz8yzuVDw3MInBZcOT3EaJwwEvz+j6/dCd269L6b7lMzbjvv4gl8+w7ThW7czaE9
         vmgrVwjEcMMxpgvGSaEbIhtiPZChvZoVG392z0x2mmQTPLqdpHwWbHSJVT4sLlrt+a22
         BkcD+3PCKPfnas/VWpV1WLVUpNRitjZbsEvdI0KYzTW0lA/eGuscWdVfH1sZ3lxpjS7T
         HiWqSUIX/nVbiF95yKlFolBYxKNZR9pZvVbyqRZ32Ma/yMrO7H9nStxh7sbCi+FmdHfS
         y8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306108; x=1719910908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbrIu8cHmgVHX45JsejmvqSnBtLm4a/j/cjG2ex/c9g=;
        b=Yi3w/f7RFViE/L6szuokJR6nYY8Dm72mmAnmsr+I3eQOvrUJNd90qBBnWp4dp4NAmW
         SQ4n3AerYrOQIAQFrlZMRT8PBLPmZolygEfSH54bVABqQB3z3SS6fJkl3Sm7HWwAruk0
         2Oyy9ANR5MiBHNZ5jgVC8oDSmS/4DVOqW2DD7w9UTmZPQEaa1N63oTb3aE3Kfh1hd1iN
         6Wx9ueM+daAkxebyY4TaCIin45OctYmprT9HCXWUMOBgMzAt29gDVYeAP4QDGwYbLUGq
         IgG97Pcb0DYOOySt42a0Ci3T3+WILUO3dQODEnjDoQiGEeljwz/vERacsj16atiBxu/H
         Jq+g==
X-Forwarded-Encrypted: i=1; AJvYcCWD3NBGzhvtjhiZV9wfyl7czSrquUIloLju9vFmW5FW4I9Q5yDZI7nn0YKuLjT9n/Z8c9ERLEdAdNsnV9fMm1XTYI5cYt0MUC8VVwn4NpqG
X-Gm-Message-State: AOJu0YyM0wx+ywaAw4b+Hkhq28qIhOYhh6c2iD8jm4zpdlmysAwKBlBc
	LsUqxapUA/0+ocQDLWqk2zMDAg0x/hnDESgy3K9lKUd3Gv0qMJh3V4TwAicYZETNNggJJdmPz9Z
	OW3YiUGnkeWDexoSzTXylbRCu/CFHsAYp6ieaqAnR3vRTmvut
X-Google-Smtp-Source: AGHT+IEP9B/Z9+JvkO1/DnsGnPU+HGSZqKx6Hgv7uYQKDRxIo0sEfdAX3hNxOanmoH2qS5YoQRI9BgP9Kw9oXe47Pkw=
X-Received: by 2002:a17:90a:a40a:b0:2c2:e0f1:bb1 with SMTP id
 98e67ed59e1d1-2c8a23bf665mr4224583a91.22.1719306108171; Tue, 25 Jun 2024
 02:01:48 -0700 (PDT)
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
 <CAA8EJpo2_3zSYEfyQ0VwSs9AkeXUpcVRGB+LaRAhA=_SWjrhtQ@mail.gmail.com>
 <CAMRc=McPZKYoxWYJ3U35CXYbBdwYBuemBwBC-qA5hhpqqTYBjg@mail.gmail.com> <CAA8EJpoEUyBmi5_Zb0m0TVYi1BAMuqNfdDL7rdsTK6rxjsGpVQ@mail.gmail.com>
In-Reply-To: <CAA8EJpoEUyBmi5_Zb0m0TVYi1BAMuqNfdDL7rdsTK6rxjsGpVQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2024 11:01:34 +0200
Message-ID: <CAMRc=MdAek=vLqMzdYb1yk+BtbBW=Vd=s-Fw1mxPF+sMwzZ_kA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:55=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 25 Jun 2024 at 11:50, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Tue, Jun 25, 2024 at 9:47=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Tue, 25 Jun 2024 at 10:46, Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > > >
> > > > On Mon, Jun 24, 2024 at 11:20=E2=80=AFPM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > >
> > > > > > Neither of these has clocks that need to be driven by linux. Th=
e only
> > > > > > user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't e=
xist
> > > > > > before so no commitment was ever made.
> > > > >
> > > > > This might make some laptop users unhappy.
> > > >
> > > > Like I said: without upstreamed DT bindings, we have never made any
> > > > commitment about the device properties. I doubt anyone will complai=
n
> > > > though, I haven't seen any DT with QCA6390 with clock properties ye=
t.
> > > > I wouldn't stress it for now.
> > >
> > > I was thinking about x86 laptops / M.2 cards. I'll see if I can locat=
e one.
> > >
> >
> > I don't get it, how could they ever get the clocks property without it
> > being defined in firmware?
>
> The clock and bt_en are optional.
>

But you're worrying that the lack of this optional clock for QCA6390
will break it on some M.2 card? That cannot happen, can it? If it's on
an M.2 card then it would never be described in ACPI.
clk_get_optional() will always return NULL.

Bart
