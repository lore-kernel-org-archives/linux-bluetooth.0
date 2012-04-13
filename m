Return-Path: <cyrus@holtmann.org>
Subject: Re: L2cap bind - invalid argument
From: Franko Danielos <danielos@zawiercie.net.pl>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20120413084003.GA9229@x220>
References: <1334261010.32169.14.camel@dhj-danielos>
	 <20120413084003.GA9229@x220>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Apr 2012 14:07:07 +0200
Message-ID: <1334318827.8342.4.camel@dhj-danielos>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
Thank you for your response. Now I know that I should read more about
bluetooth technology.

Regards,
Danielos


Dnia 2012-04-13, pią o godzinie 11:40 +0300, Johan Hedberg pisze:
> Hi Franko,
> 
> On Thu, Apr 12, 2012, Franko Danielos wrote:
> > When I try to follow example from this site
> > http://people.csail.mit.edu/albert/bluez-intro/x559.html
> > I have an error while trying to bind. Error message is invalid argument.
> > My question: is it related with newest bluetooth or kernel?
> > 
> > I use linux mint 12.
> > Linux Kernel version 3.0.0 (but the same applies to 3.2.x)
> > Bluez version: 4.96
> > 
> > I tested it also on earlier version of Linux Mint with kernel 2.6.32 and
> > bluez 4.66 and that example works.
> > Any ideas?
> 
> That would be because the PSM value in the example is not valid. Newer
> kernels (post 2.6.32) check for this properly:
> 
>         /* PSM must be odd and lsb of upper byte must be 0 */
>         if ((psm & 0x0101) != 0x0001) {
>                 err = -EINVAL;
>                 goto done;
>         }
> 
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


