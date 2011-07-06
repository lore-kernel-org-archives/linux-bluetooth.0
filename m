Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAE-CKuiPG92Jtj=oNFqG-9f=54sNjCxysMnsVAnE3oj_=-3hng@mail.gmail.com>
References: <BANLkTimAe6uRCdfM2_tNSf5j9mvnA_W4Qw@mail.gmail.com>
	<BANLkTi=iHCLfqhqtZJ-XMahXrprk0fBnWw@mail.gmail.com>
	<BANLkTimrY5o5hQhVfRf7UyBn-WNE1GgMNA@mail.gmail.com>
	<CAE-CKuiPG92Jtj=oNFqG-9f=54sNjCxysMnsVAnE3oj_=-3hng@mail.gmail.com>
Date: Wed, 6 Jul 2011 10:26:01 -0300
Message-ID: <CAKT1EBdmVvYcEy1FheVrbpxHymbL56UHvx8-VJbuD9F4Gcf_QQ@mail.gmail.com>
Subject: Re: endless loop in client.c when read request is rejected
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: mike tsai <mikeyhtsai@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> After upgrade the kernel to 2.6-next branch, it does initiate the
> just-work, no-bonding operation and it does work.(no more endless
> loop). However, I found another issue is that during discovery, the
> client will try to read every characteristic it found, regardless the
> property setting. This causes "Read Not Permitted" error response for
> some characteristic that does not allowed to be read (like the
> alert-level). I am not sure why the discovery process wants to read
> the characteristic value though, that should be invoked by profile
> later when needed,
>
> Regards,
>
> Mike

The Generic Attribute is still experimental. DiscoverCharacteristics
method returns after discovering all characteristic declarations,
characteristic values and descriptor are read in "background".

"Read Not Permitted" needs to be fixed. Feel free to send a patch for it.

The characteristic value is required due the GetProperties method of
the characteristic "object". At the moment, the characteristics
storage is not being used properly. For example, Proximity could read
the handle from the storage if available.

Regards,
Claudio.
