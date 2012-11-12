Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: HFP can't work well and sound can't be heard
Date: Mon, 12 Nov 2012 01:49:32 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E0FE40697@SHSMSX102.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E0FE3E843@SHSMSX102.ccr.corp.intel.com>
 <CABBYNZJzd-DxwBMHvwFTAfP0W2=oWG2=4G5aa7_wEfVUPE345w@mail.gmail.com>
In-Reply-To: <CABBYNZJzd-DxwBMHvwFTAfP0W2=oWG2=4G5aa7_wEfVUPE345w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for your info.

It looks like the PulseAudio feature should be checked after BlueZ 5 is released.

Best Regards
Zheng Wu

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, November 09, 2012 11:13 PM
> To: Zheng, Wu
> Cc: Von Dentz, Luiz; linux-bluetooth@vger.kernel.org
> Subject: Re: HFP can't work well and sound can't be heard
> 
> Hi,
> 
> On Thu, Nov 8, 2012 at 11:41 AM, Zheng, Wu <wu.zheng@intel.com> wrote:
> > Hi Luiz,
> >
> > The GetProperties methods of "org.bluez.manager", "org.bluez.Adapter" and
> so on have been converted to some methods of
> "org.freedesktop.DBus.Properties".
> >
> > It results in pulseaudio can't communicate with bluez well and sound can't be
> heard when using HFP.
> >
> > What do upstream plan for it? Thanks.
> 
> Obviously we need to port PulseAudio to work with BlueZ 5, this should not take
> long but first we need a release, if you still want to test there are patches that I
> send to the list not long ago just search the archives, but note that they are
> workaround so they are not meant to go upstream it is just to be able to run
> bluetoothd with tools that have not been ported yet.
> 
> --
> Luiz Augusto von Dentz
