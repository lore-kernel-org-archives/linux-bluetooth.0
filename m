Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Remove btio.c compilation warning
From: Bastien Nocera <hadess@hadess.net>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Elvis =?ISO-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 05 May 2011 20:01:48 +0100
In-Reply-To: <20110505140531.GA27568@piper>
References: <4dbf1776.0bd9650a.1733.7e99@mx.google.com>
	 <20110504213936.GA22493@jh-x301>
	 <BANLkTikbokOzYmnbPGcLGPVV_qJUCf3SkQ@mail.gmail.com>
	 <EE9AF3E8-0C89-4B05-93F1-D77B46A7BAF7@signove.com>
	 <BANLkTikLnb229tLvdeeWMnfqkqdSAva1bQ@mail.gmail.com>
	 <20110505140531.GA27568@piper>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1304622112.16101.23.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-05-05 at 11:05 -0300, Vinicius Costa Gomes wrote:
> Hi Luiz,
> 
> On 11:05 Thu 05 May, Luiz Augusto von Dentz wrote:
> 
> [snip]
> 
> > 
> > I don't see why it would be ubuntu specific, this seems to be some
> > kind of regression/'feature' with gcc 4.5.
> 
> Yeah, I really believe this is the case. I have gcc 4.5.2 here, that
> would be the version as in Natty, and I don't encounter that problem.
> 
> The only difference that I could find is that Ubuntu ships gcc with
> a .diff.gz of 1.3MB ;-)
> 
> But back to the topic at hand, I agree that the patch should be applied,
> Ubuntu is used by many developers and BlueZ should be kept clean of 
> warnings.

It's also a bug in the GCC 4.6 shipped by Fedora 15, fwiw.

Cheers

