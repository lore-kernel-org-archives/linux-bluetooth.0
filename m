Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143F187343
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113332; cv=none; b=TJfvOIM4fvvCG/cR4xg8sWg5HcEiwPMzegNyhlWYSTliEI6jSNA4psdBs8TzAhb8k82ZaZXTKzpctmQmSxc5Pcw8Wnh95rNW3eZYnigwCZ9XTQAD8EWwN28ZW2u3LG0yE763MeJ94ngu5V3ZeOIVUH7OKZRhjqZhQu+pz+dZzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113332; c=relaxed/simple;
	bh=Ufq7Y9XhSbGAno8ZC2csPAuNXmKtoW0oJKAYB3eruIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnJsFouqONKSUJB+aCTaD4yFBsAR/mRLRI9EwXNHfXn6pZez9duPKiu0xRqQIePZltVEYBk2VbzzDCxbTwW1IOwDGlW/AWNqF3ZjRBAMhaJF0YbtNOfJGJJ43tLQTStk41hrDrpqJ3qyiZ+EnTkYefLyd7zBlu25o5OyfCAMMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-520f9d559f6so2179221e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 13:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715113329; x=1715718129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ufq7Y9XhSbGAno8ZC2csPAuNXmKtoW0oJKAYB3eruIM=;
        b=aYPhaWQg61ND9TOt/FRSst/wNdYKQLM1YkF7+8vHfNAskYCUYDZdzsVoBoyAT9veup
         zAjsClP2ry0SStiYnbxsatV1I54e5kZeg7ReydV3inmW7eqLys/lrAPnlkjGLzmDCCb/
         qQEVcEHMpNbER8ByoxzSq2/TyPK+X15n6nvgI9F5ef4tddVTKeeLhQmj/e60yhB1LBqu
         UBi9EPqigk9TsLT8HJKWHMQLw4q6WuUbz8LLep1ZCXbpmH9F9hr4B8AtFEMhBNXqJ1Tc
         Sm+8HDi9BypaySEGI0HFja7GNhTmff5gBjNVWP37PYR6cFcABh255VsPVZbbVGbFCcAr
         R4gw==
X-Gm-Message-State: AOJu0YxyMNedlJuoqbUbYljeLWCEFxUzt0/4bTaak/XfphKW7MT3c4IT
	HFe/AC7WYwzkFyqERj8+Mcu1wUTBOtoHNnvQK3lYom/xnQ8wfqE/8GPiVygQj7k=
X-Google-Smtp-Source: AGHT+IGAug1GqUgL6RQ59dsycDCIdAV08A6bITC7mifrHu/QPRgH0gkNr/qnfwhsVrQLnTpx693J8Q==
X-Received: by 2002:a05:6512:3d0e:b0:51f:5d0a:d71a with SMTP id 2adb3069b0e04-5217c3707d7mr453107e87.10.1715113328691;
        Tue, 07 May 2024 13:22:08 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a24-20020ac25218000000b0051d7c6fc672sm2218733lfl.16.2024.05.07.13.22.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 13:22:08 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e44d32a480so2641671fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 13:22:08 -0700 (PDT)
X-Received: by 2002:a05:6512:208d:b0:516:d18b:eae8 with SMTP id
 2adb3069b0e04-5217c66754emr339238e87.41.1715113328260; Tue, 07 May 2024
 13:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507143639.539863-1-luiz.dentz@gmail.com> <663a497d.050a0220.99cab.8529@mx.google.com>
 <CABBYNZJ8NDv64Unsa=-j_RJhpCGBBtJf9Vvn2Fq9Vvc9OsHmwg@mail.gmail.com>
In-Reply-To: <CABBYNZJ8NDv64Unsa=-j_RJhpCGBBtJf9Vvn2Fq9Vvc9OsHmwg@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 8 May 2024 05:21:54 +0900
X-Gmail-Original-Message-ID: <CAJNyHpL1sqNxbe_2o1Pjx_BJTka0c5NoanQBfGPU1bYit7dXVQ@mail.gmail.com>
Message-ID: <CAJNyHpL1sqNxbe_2o1Pjx_BJTka0c5NoanQBfGPU1bYit7dXVQ@mail.gmail.com>
Subject: Re: [v2] Bluetooth: HCI: Remove HCI_AMP support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, May 8, 2024 at 4:26=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sungwoo,
>
> On Tue, May 7, 2024 at 11:32=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D8=
51233
>
> Can you try reproducing the problem with the above change?

Sure, I will.

For the patch, we can also remove HCI_FLOW_CTL_MODE_PACKET_BASED and
HCI_FLOW_CTL_MODE_BLOCK_BASED from hci.h as no one is using it.

One question:
This patch removes some HCI commands and flow control modes that are
still in the specification v5.4.
Should we remove these commands and modes from the specification also?

Thanks,
Sungwoo.
