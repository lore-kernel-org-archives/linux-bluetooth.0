Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: Laczen JMS <laczenjms@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: meshctl fails on rpi 3
Date: Sun, 17 Sep 2017 16:50:44 +0000
Message-ID: <7560B49A-22C4-4A62-AE3F-B1AFA4712B30@intel.com>
References: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
In-Reply-To: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jehudi,

Meshctl' crypto does depend on a lot of Kernel based crypto... pretty much everything except for the AES-CCM.

Sent from my iPhone

> On Sep 17, 2017, at 8:42 AM, Laczen JMS <laczenjms@gmail.com> wrote:
> 
> After downloading and compiling bluez 5.47 on raspberry pi 3 (raspbian
> 2017-09-07), it is not possible to run meshctl on the raspberry pi.
> Meshctl fails at loading the prov_db.
> 
> After some further testing I have found that the loading fails in the
> crypto functions at binding the AF_ALG in line 178 of crypto.c. Has
> this something to do with cryptographic modules being unavailable on
> the rpi 3?
> 
> If so, what crypto module is required and what is the best way to add
> these modules ?
> 
> Kind regards,
> 
> Jehudi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
