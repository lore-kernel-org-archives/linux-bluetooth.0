Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 16:48:48 +0200
Cc: "'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <200812301246.25781.siarhei.siamashka@nokia.com> <2d5a2c100901050513t73cbd8a0v924f7d52e0cae271@mail.gmail.com> <002801c96f43$dd2e70b0$978b5210$@de>
In-Reply-To: <002801c96f43$dd2e70b0$978b5210$@de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901051648.48096.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 16:42:39 ext Christian Hoene wrote:
> > Just the codesize is 16 bit, right? So I guess the following changes
> > are not really necessary:
> >
> >
> > +	uint16_t subbands, channels, blocks;
>
> No, but then we have to change the last line of the function to
>   return ((uint16_t)subbands) * blocks * channels * 2;

Not quite so. There is such thing as "integer promotion" defined in C
standard. And integer type is guaranteed to be at least 16 bit. But I
agree that explicitly having uint16_t is much more likely not to raise
any doubts about its correctness :)

-- 
Best regards,
Siarhei Siamashka
