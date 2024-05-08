Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C582130E4B
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715206623; cv=none; b=rTcuqX+smCbTygzXIgfk28uYMd7s30+NyJXum4ttyUJ0UvWdm0JJzc6/s8hx25ugWZrKeUTHsPCLUH28ebOuXWWZQIU8rQ2TMOHRX6bHa6rrK0L9MC1Fgj2YjFDaDl12SAOtZWXOgUdJDbPeh6OYdbyEfg0vTcGdG1/2RLrO1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715206623; c=relaxed/simple;
	bh=uVZpoWw82LqYKxWX7Wrq4qa3CV2sRaj6xwZnqWxJjak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLBv0bvQ4xoYclRDCrAUtxAwwJ3Uap7R6apkKvu9emOp3QvCFzEmOQGaJEbOn6FtUdfwZqQztwMAkjRCnaPME+0/ypMUitFgVU9WmWDsN2JsyqmceiOGQu70RqGFwDqZ3wDy/Mm0AfVRfndpoA8rrTLlVcFdNnFKWvOkIrmMfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2df83058d48so2854041fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 15:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715206620; x=1715811420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVZpoWw82LqYKxWX7Wrq4qa3CV2sRaj6xwZnqWxJjak=;
        b=AClfK8DfMNPLDlKExflxxFxtM/qoZWzp4YVPoHT7LrJ4l/9G7yCP6+cnKoayQwM7lj
         neuhZyvZASzf8MmppJ5HwKkcEzdr2CUWgbz2/pCppbrxkLTRpzkDDa2eEvwFYhTGCsLx
         jdGMwSQZb1GRuKDskxN2vtDX3XFWI+n8uSw9SAK7Fdoa1IUquzvRVE6dfRHz07TPV6/e
         Ea9wYaF8fRVYJZkGiDw6ayO32bTr8jXCw0Uo8iD7uPVUwbI8xti5+NhC2hLMIrToHPXe
         D5I3TSN2kbYyCIECMTBw5wDsK8hwhG3c5CR8MM8KwGCA4somvBBzouQtW66I2dsXFHqn
         ZzYg==
X-Gm-Message-State: AOJu0YwGPVTccF9GB6rCbFj0H5wLv2dM1eMfWttRTLT4QeJ2EnxD9RLd
	GZDlSDM7KsDYIntrE+FoLspnYj4K4GDnv6pmo1+y7cO7SuZFYezmez28LkU6ya0=
X-Google-Smtp-Source: AGHT+IGSbtkOCFnKj8ztdADRcvlPL0JJBzceDOlFGeYOUfFH/XD+13jMLrqEWPrFIbCbvu8QfLi7RQ==
X-Received: by 2002:a2e:9858:0:b0:2e2:587:4bc9 with SMTP id 38308e7fff4ca-2e4476af963mr21903041fa.40.1715206620001;
        Wed, 08 May 2024 15:17:00 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a7-20020a2e9807000000b002db98d0f2c8sm2579215ljj.85.2024.05.08.15.16.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 15:16:59 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso222108e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 15:16:59 -0700 (PDT)
X-Received: by 2002:ac2:522e:0:b0:51b:de39:3826 with SMTP id
 2adb3069b0e04-5217ce46c24mr2107480e87.65.1715206619650; Wed, 08 May 2024
 15:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507143639.539863-1-luiz.dentz@gmail.com> <663a497d.050a0220.99cab.8529@mx.google.com>
 <CABBYNZJ8NDv64Unsa=-j_RJhpCGBBtJf9Vvn2Fq9Vvc9OsHmwg@mail.gmail.com> <CAJNyHpL1sqNxbe_2o1Pjx_BJTka0c5NoanQBfGPU1bYit7dXVQ@mail.gmail.com>
In-Reply-To: <CAJNyHpL1sqNxbe_2o1Pjx_BJTka0c5NoanQBfGPU1bYit7dXVQ@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Thu, 9 May 2024 07:16:47 +0900
X-Gmail-Original-Message-ID: <CAJNyHp+HZF_Vh5c9xmNuFxsc6dMmEboQH2tXx2C5KWCNe1C51A@mail.gmail.com>
Message-ID: <CAJNyHp+HZF_Vh5c9xmNuFxsc6dMmEboQH2tXx2C5KWCNe1C51A@mail.gmail.com>
Subject: Re: [v2] Bluetooth: HCI: Remove HCI_AMP support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 5:21=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> Hi Luiz,
>
> On Wed, May 8, 2024 at 4:26=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sungwoo,
> >
> > On Tue, May 7, 2024 at 11:32=E2=80=AFAM <bluez.test.bot@gmail.com> wrot=
e:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing l=
ist.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=
=3D851233
> >
> > Can you try reproducing the problem with the above change?

This bug is not reproduced under my testing environment.
https://lore.kernel.org/linux-kernel/20240506022035.663102-1-iam@sung-woo.k=
im/

>
> Sure, I will.
>
> For the patch, we can also remove HCI_FLOW_CTL_MODE_PACKET_BASED and
> HCI_FLOW_CTL_MODE_BLOCK_BASED from hci.h as no one is using it.
>
> One question:
> This patch removes some HCI commands and flow control modes that are
> still in the specification v5.4.
> Should we remove these commands and modes from the specification also?
>
> Thanks,
> Sungwoo.
