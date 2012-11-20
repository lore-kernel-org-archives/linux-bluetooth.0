Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 15:56:53 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/4] Bluetooth: AMP: Set no FCS for incoming L2CAP chan
Message-ID: <20121120175653.GI14006@joana>
References: <20121119212812.GB14006@joana>
 <1353424582-26042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1353424582-26042-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353424582-26042-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-11-20 17:16:22 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> When receiving L2CAP Create Channel Request set the channel as
> L2CAP_FCS_NONE. Then in "L2CAP Config req" following field will
> be set: "FCS Option 0x00 (No FCS)". So by default High Speed
> channels have no FCS.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    1 +
>  1 file changed, 1 insertion(+)

All 4 patches have been applied to bluetooth-next. Thanks.

	Gustavo
