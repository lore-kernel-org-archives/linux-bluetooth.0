Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Aug 2011 18:07:16 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/4] Bluetooth: hidp: Don't release device ref if never
 held
Message-ID: <20110811210716.GE19699@joana>
References: <1312555921.2172.14.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312555921.2172.14.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

* Peter Hurley <peter@hurleysoftware.com> [2011-08-05 10:52:01 -0400]:

> When an hidp connection is added for a boot protocol input
> device, don't release a device reference that was never
> acquired. The device reference is acquired when the session
> is linked to the session list (which hasn't happened yet when
> hidp_setup_input is called).
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/hidp/core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

All four patches applied. Thanks.

	Gustavo
