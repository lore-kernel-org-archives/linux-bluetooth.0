Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510299481.1995.2.camel@zoho.eu>
Subject: Re: invalid packet size with bluetooth keyboard
From: Bbo Wuff <bbo2adwuff@zoho.eu>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 10 Nov 2017 08:38:01 +0100
In-Reply-To: <CABBYNZ+txiExp7Fjc4XHd+Xhbp9WLtrfbEGM8YErAU_9zibUOg@mail.gmail.com>
References: <1510226875.1765.5.camel@zoho.eu>
         <CABBYNZ+txiExp7Fjc4XHd+Xhbp9WLtrfbEGM8YErAU_9zibUOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

You are right, not bluez bug.

See the firmware bug reports:
https://bugzilla.kernel.org/show_bug.cgi?id=197147
https://bugzilla.kernel.org/show_bug.cgi?id=197807

Sorry for the noise! Invalid packet size was the only error in the logs
that I saw.

Thanks!
Wuff


On Thu, 2017-11-09 at 21:15 +0200, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, Nov 9, 2017 at 1:27 PM, Bbo Wuff <bbo2adwuff@zoho.eu> wrote:
> > Dear all,
> > 
> > I have a Microsoft Sculpt Mobile Keyboard, which is a bluetooth
> > keyboard. It worked fine before, but since bluez 5.47 not anymore.
> > And
> > I don't seem to be the only one:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878181#15
> 
> This seems a hardware fault, are you sure it is not due to a new
> firmware or something? We haven't done any changes to HIDP in quite
> some time, which btw is in the kernel so there is very little the
> userspace can do to affect it.
> 
> 

