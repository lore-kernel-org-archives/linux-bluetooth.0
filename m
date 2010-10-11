Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <52A922E83075C847A59D7DF98C660175018842@MTW02MBX03.mindtree.com>
References: <20100920184943.GA22968@jh-x301>
	<1286027890.12944.1.camel@localhost.localdomain>
	<AANLkTikFrvyeoXV0uLYcvD4GCj2s3ML2-q8f5GhXMxAK@mail.gmail.com>
	<1286187946.7898.0.camel@localhost.localdomain>
	<20101004123552.GC11737@pengutronix.de>
	<52A922E83075C847A59D7DF98C66017501871E@MTW02MBX03.mindtree.com>
	<AANLkTimguxTRuPB2Dgqm4w5k-MeOxDdCYDn-T_UvOFRL@mail.gmail.com>
	<52A922E83075C847A59D7DF98C660175018842@MTW02MBX03.mindtree.com>
Date: Mon, 11 Oct 2010 16:47:19 +0530
Message-ID: <AANLkTin7_EJzX9pSBp=b6Zwk+fQyOjftK4OmA+oLbHDc@mail.gmail.com>
Subject: Re: How add support of LLMNR for PAN
From: "Arun K. Singh" <arunkat@gmail.com>
To: Chetankumar Manjegowda <Chetankumar_Manjegowda@mindtree.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Chetan,

Based on my limited understanding of networking, avahi should
implement DNS-SD on Linux, which is quite close to Microsoft's version
of LLMNR.  You may also want to use any other utility that may be
required for supporting Link-local addresses etc on your host distro.


But from Bluez perspective, pand should be really transparent as long
as endpoints TCP/IP stacks support LLMNR or similar variants of LL
name resolution protocols. It is pretty much a TCP/IP stack feature or
so I believe.

Good Luck!


-- 
Best Regards,
Arun Kumar Singh
www.crazydaks.com




On Tue, Oct 5, 2010 at 10:17 AM, Chetankumar Manjegowda
<Chetankumar_Manjegowda@mindtree.com> wrote:
>
> Hi Arun,
> Thanks for your reply.
>
> I am new to networking I am not sure about that.
>
> I want to send LLMNR query so i am planning to use avahi-0.6.27(avahi-autoipd) is this is fine or any other is available ?
>
> Rgds
> Chetan
>
>
> -----Original Message-----
> From: Arun Kumar [mailto:arunkat@gmail.com]
> Sent: Monday, October 04, 2010 9:06 PM
> To: Chetankumar Manjegowda
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: How add support of LLMNR for PAN
>
> Shouldn't this support come from linux ip stack rather than bluez?
>
>
> Best Regards,
> Arun Kumar Singh
> www.crazydaks.com
>
>
> On Mon, Oct 4, 2010 at 6:15 PM, Chetankumar Manjegowda
> <Chetankumar_Manjegowda@mindtree.com> wrote:
> >
> > Hi All,
> >
> > I want to know how to enable/Integrate LLMNR for PAN profile.
> >
> > Can anyone give some suggestions or link where I can refer the same ??
> >
> > Rgds
> > Chetan
> >
> > ________________________________
> >
> > http://www.mindtree.com/email/disclaimer.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
