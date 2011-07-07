Return-Path: <cyrus@holtmann.org>
Message-Id: <7.0.1.0.2.20110707101900.03230f68@gmx.net>
Date: Thu, 07 Jul 2011 10:25:48 +0200
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Peter Kornatowski <pkorn@gmx.net>
Subject: Re: Media API with more than one headset
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <CABBYNZ+y1EkxNOr53Cr2SkbYfgKV3SCDK10ejo1mjHzdcB2BvQ@mail.g
 mail.com>
References: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
 <BANLkTikuRgeFW-fXckR4ST14idxPSmNP7g@mail.gmail.com>
 <7.0.1.0.2.20110627205517.03250550@gmx.net>
 <BANLkTinFieuN8HSLu8-pTaMix9r48d6HBw@mail.gmail.com>
 <BANLkTimMQcjj3A=cNaUWY4xByY2WrhA9RA@mail.gmail.com>
 <BANLkTiknkbZcS2AASzS_qeXbNJ3_Qa2e1A@mail.gmail.com>
 <7.0.1.0.2.20110629214327.0321b4e0@gmx.net>
 <7.0.1.0.2.20110706214918.03262000@gmx.net>
 <CABBYNZ+y1EkxNOr53Cr2SkbYfgKV3SCDK10ejo1mjHzdcB2BvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

At 22:35 06.07.2011, Luiz Augusto von Dentz wrote:
>Hi Peter,
>
>On Wed, Jul 6, 2011 at 10:54 PM, Peter Kornatowski <pkorn@gmx.net> wrote:
> > I downloaded and checked the new bluez version 4.95. I'm wondering why the
> > patch of Lukasz didn't get applied? As I wrote in my last e-mail, it works
> > for not losing playing mode of all headsets when disconnecting just one.
>
>I don't remember actually seeing a proper patch to the mailing list,
>that might explain why it wasn't applied yet.

So Lukasz, could you make a proper patch out of it, cause it's your code?

> > Did someone of you had a chance to look into the other problems I wrote
> > about in my last e-mail? This would help me a lot.
>
>Nope, I was actually waiting for more input since you mentioned this
>only happened with some code your wrote.

The first problem I wrote about also occures with the simple-endpoint 
script located in the test directory of bluez. You just have to add 
the "Acquire" call to "SetConfiguration" to actually set the headset 
in playing mode. I also posted the lines of code I added, so you can 
easily try to reproduce it. The second problem just occurs with my 
code, that's right. But maybe you have some general ideas. Otherwise 
I'll have to dig in by myself. But it would be very helpful when you 
look at least into the first problem.

>--
>Luiz Augusto von Dentz
>--

Thanks,
Peter 

