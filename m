Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jan 2014 13:02:11 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: bill dr <bilel.dr@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: BLE for Android
Message-ID: <20140103110209.GB9809@aemeltch-MOBL1>
References: <CAHTi60GvSMT54WbHC_aw=qja8ApFKZ4ouUYMDVi7RPuFZf-Urw@mail.gmail.com>
 <CABBYNZ+qQp3+n7BL_E7CQO-agz48aCdbsyKRYcEmMZ16P=hU7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+qQp3+n7BL_E7CQO-agz48aCdbsyKRYcEmMZ16P=hU7A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Tue, Dec 31, 2013 at 02:02:59PM +0200, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Dec 31, 2013 at 1:47 PM, bill dr <bilel.dr@gmail.com> wrote:
> > Hi,
> >
> > I am trying to port BLE into a 4.1.1 android device.

There is no sense to make this work, use the latest Android instead, many
things should be already working ...

Best regards 
Andrei Emeltchenko 

> > I found that bluez git repository contains an android directory.
> > Could you explain me or point me to any link or document that explain
> > how to use this directory. Is there any HAL implementation already
> > done. Or this directory contains only "bluedroid" code ?
> >
> > Thank you !
> 
> Checkout the README:
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README
> 
> It is a clean implementation of bluetooth HAL, so no bluedroid code
> bellow the HAL interface, above HAL is considered Android itself even
> though it may actually contain bluetooth specific bits here and there.
> Btw, we are almost ready to start looking at the BLE HAL.
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
