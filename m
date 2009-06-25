Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>, Vikram Kandukuri
	<Vikram.Kandukuri@Atheros.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 25 Jun 2009 12:56:38 +0530
Subject: RE: [PATCH] Bluetooth: Kill session whenever VIRTUAL_CABLE_UNPLUG
 is passed.
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068E3A5CF@CHEXMB-01.global.atheros.com>
References: <20090620061927.GC9947@atheros-laptop>
 <1245404162.15367.44.camel@violet>
In-Reply-To: <1245404162.15367.44.camel@violet>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Marcel Holtmann
Sent: Friday, June 19, 2009 3:06 PM
To: Vikram Kandukuri
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Kill session whenever VIRTUAL_CABLE_UNPLUG =
is passed.

Hi Vikram,

> Whenever the remote device sends VIRTUAL CABLE UNPLUG, the device should
> be disconnected.
>
> Signed-off-by: Jothikumar Mothilal <jothikumar.mothilal@atheros.com>
> ---
>  net/bluetooth/hidp/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index b186768..a9f7afb 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -374,6 +374,7 @@ static void hidp_process_hid_control(struct hidp_sess=
ion *session,
>
>               /* Kill session thread */
>               atomic_inc(&session->terminate);
> +             hidp_schedule(session);
>       }
>  }

the patch is correct, but the commit message could be a little bit more
verbose. It should explain why this fixes it.

Regards

Marcel


Hi Marcel,
We were facing this issue while running HID BQB test cases.

There is a test case in PTS tool; PTS will send the VIRTUAL_CABLE_UNPLUG co=
mmand to IUT. IUT should disconnect the channel and kill the session when i=
t receives VIRTUAL_CABLE_UNPLUG command.
VIRTUAL_CABLE_UNPLUG is parsed by hidp.ko but it is not scheduled to do so =
(There is no schedule code). So I have added hidp_schedule to kill the sess=
ion.

I feel following description gives more information.

Bluetooth: Scheduled to kill the session whenever VIRTUAL_CABLE_UNPLUG is r=
eceived by IUT.

Thanks,
Jothi
