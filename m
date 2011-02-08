Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Feb 2011 11:06:28 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?H=F6glind=2C?= Henrik
	<Henrik.Hoglind@sonyericsson.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	"roystonr@codeaurora.org" <roystonr@codeaurora.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"skrovvid@codeaurora.org" <skrovvid@codeaurora.org>,
	"rshaffer@codeaurora.org" <rshaffer@codeaurora.org>
Subject: Re: A2DP reconfigure with BMW Carkit (supporting multi streams)
 timeouts.
Message-ID: <20110208190628.GA4846@jh-x301>
References: <3b53a90114d801b0adba526895deed74.squirrel@www.codeaurora.org>
 <20101209144103.GA30557@jh-x301>
 <AANLkTik78DiC7TgWtR0q=xPs+ZZq470_md-gJWv8tB8f@mail.gmail.com>
 <20101210103242.GA21860@jh-x301>
 <c2cb901974d908ed9f808324e4b4f6fb.squirrel@www.codeaurora.org>
 <2ec0d2a2febdbcf4ab73812ad709f542.squirrel@www.codeaurora.org>
 <AANLkTinQ2heJzG_8u_2ZPoqiSy0tGzQCCZO=BZgE7A=Y@mail.gmail.com>
 <9A742367D258D34A9753780E2AE6B8BD2CB6E93748@SELDMBX04.corpusers.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9A742367D258D34A9753780E2AE6B8BD2CB6E93748@SELDMBX04.corpusers.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrik,

On Tue, Feb 08, 2011, Höglind, Henrik wrote:
> Hi Lukasz, Roystonr, Johan,
> 
> >> Have provided the patch to the tester to verify as we don't have the BMW
> >> CK available locally. Would update the feedback received.
> >
> >I'm just wondering, Is it working for you ?
> 
> We have been testing this patch and it fixes the problem.

Thanks for the confirmation. I've now pushed a patch for this upstream.

Johan
