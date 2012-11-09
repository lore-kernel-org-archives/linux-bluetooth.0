Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E0FE3E843@SHSMSX102.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E0FE3E843@SHSMSX102.ccr.corp.intel.com>
Date: Fri, 9 Nov 2012 17:13:05 +0200
Message-ID: <CABBYNZJzd-DxwBMHvwFTAfP0W2=oWG2=4G5aa7_wEfVUPE345w@mail.gmail.com>
Subject: Re: HFP can't work well and sound can't be heard
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 8, 2012 at 11:41 AM, Zheng, Wu <wu.zheng@intel.com> wrote:
> Hi Luiz,
>
> The GetProperties methods of "org.bluez.manager", "org.bluez.Adapter" and so on have been converted to some methods of "org.freedesktop.DBus.Properties".
>
> It results in pulseaudio can't communicate with bluez well and sound can't be heard when using HFP.
>
> What do upstream plan for it? Thanks.

Obviously we need to port PulseAudio to work with BlueZ 5, this should
not take long but first we need a release, if you still want to test
there are patches that I send to the list not long ago just search the
archives, but note that they are workaround so they are not meant to
go upstream it is just to be able to run bluetoothd with tools that
have not been ported yet.

-- 
Luiz Augusto von Dentz
