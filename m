Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1510226875.1765.5.camel@zoho.eu>
References: <1510226875.1765.5.camel@zoho.eu>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Nov 2017 21:15:23 +0200
Message-ID: <CABBYNZ+txiExp7Fjc4XHd+Xhbp9WLtrfbEGM8YErAU_9zibUOg@mail.gmail.com>
Subject: Re: invalid packet size with bluetooth keyboard
To: Bbo Wuff <bbo2adwuff@zoho.eu>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 9, 2017 at 1:27 PM, Bbo Wuff <bbo2adwuff@zoho.eu> wrote:
> Dear all,
>
> I have a Microsoft Sculpt Mobile Keyboard, which is a bluetooth
> keyboard. It worked fine before, but since bluez 5.47 not anymore. And
> I don't seem to be the only one:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878181#15

This seems a hardware fault, are you sure it is not due to a new
firmware or something? We haven't done any changes to HIDP in quite
some time, which btw is in the kernel so there is very little the
userspace can do to affect it.


-- 
Luiz Augusto von Dentz
