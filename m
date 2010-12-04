Return-Path: <cyrus@holtmann.org>
From: "Brian Gix" <bgix@codeaurora.org>
To: "'Vinicius Costa Gomes'" <vinicius.gomes@openbossa.org>,
	"'Gustavo F. Padovan'" <padovan@profusion.mobi>,
	"'Ville Tervo'" <ville.tervo@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org> <20101203220534.GA16709@eris>
In-Reply-To: <20101203220534.GA16709@eris>
Subject: RE: LE Kernel (bluetooth-le-2.6) and LE Security Manager
Date: Fri, 3 Dec 2010 16:40:13 -0800
Message-ID: <001f01cb934b$d065e4c0$7131ae40$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



Hi Vinicius & Gustavo,


-----Original Message-----
From: Vinicius Costa Gomes [mailto:vinicius.gomes@openbossa.org] 
Sent: 03 December, 2010 2:06 PM
To: Brian Gix
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager

Hi Brian,

On 11:11 Fri 03 Dec, Brian Gix wrote:
> 
> Hi Claudio, Johan & All,
> 
> Is this LE capable kernel that Ville is working on, the development stream
> for the LE Security Manager?  And if so, is it in a partial fleshed out
> state?

There is a simple implementation of SMP here[1] on my "devel" branch. I am 
cleaning it up for sending it for review.

If you want to help, have any comments or just want to tell us what you are
working on, please drop by #bluez on freenode, or send an email.

[Gix] Unfortunately, I can't access git.infradead.org.  Gustavo, would it be
possible for you to pull Vinicius' devel branch from
git://git.infradead.org/users/vcgomes/linux-2.6.git to an le-devel branch on
your bluetooth-testing repository?

[Gix] I am trying to integrate Qualcomm's latest LE capable (BR/EDR/LE)
chipset with bluez.  Additionally, I do have a working non-open-source
[Gix]  host which has had it's LE Security Manager UPF tested, which I hope
to be able to use to help test/solidify the bluez version.


> 
> >
git://git.kernel.org/pub/scm/linux/kernel/git/vtervo/bluetooth-le-2.6.git
> 
> 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius

[1] git://git.infradead.org/users/vcgomes/linux-2.6.git 

