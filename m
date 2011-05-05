Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110505140531.GA27568@piper>
References: <4dbf1776.0bd9650a.1733.7e99@mx.google.com>
	<20110504213936.GA22493@jh-x301>
	<BANLkTikbokOzYmnbPGcLGPVV_qJUCf3SkQ@mail.gmail.com>
	<EE9AF3E8-0C89-4B05-93F1-D77B46A7BAF7@signove.com>
	<BANLkTikLnb229tLvdeeWMnfqkqdSAva1bQ@mail.gmail.com>
	<20110505140531.GA27568@piper>
Date: Thu, 5 May 2011 17:30:06 +0300
Message-ID: <BANLkTinUocgdf3YFTEvzTo6ij7E_oAGvKQ@mail.gmail.com>
Subject: Re: [PATCH] Remove btio.c compilation warning
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, May 5, 2011 at 5:05 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Luiz,
>
> On 11:05 Thu 05 May, Luiz Augusto von Dentz wrote:
>
> [snip]
>
>>
>> I don't see why it would be ubuntu specific, this seems to be some
>> kind of regression/'feature' with gcc 4.5.
>
> Yeah, I really believe this is the case. I have gcc 4.5.2 here, that
> would be the version as in Natty, and I don't encounter that problem.

So it seems to be Ubuntu specific in some way, very annoying way.

> The only difference that I could find is that Ubuntu ships gcc with
> a .diff.gz of 1.3MB ;-)
>
> But back to the topic at hand, I agree that the patch should be applied,
> Ubuntu is used by many developers and BlueZ should be kept clean of
> warnings.

Well if we don't get anywhere with the bug Elvis sent than that is the
only think we can do, or maybe there is some new gcc flag that can
prevent such behavior.


-- 
Luiz Augusto von Dentz
Computer Engineer
