Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ5GMqnWr6=OzDcC=YxCTSMH2EEu8x4p04=OZYExyM6+g@mail.gmail.com>
References: <1313161215.2254.6.camel@THOR>
	<CABBYNZ+3jC+1LbvHgie5LX_8Xr_kRT6G-ed7dsn-pEUzoVam=g@mail.gmail.com>
	<1313370363.2144.46.camel@THOR>
	<CABBYNZJ5GMqnWr6=OzDcC=YxCTSMH2EEu8x4p04=OZYExyM6+g@mail.gmail.com>
Date: Mon, 15 Aug 2011 12:42:52 +0300
Message-ID: <CABBYNZJq3eLk5zO4XGteT1r2u2raaAdHhuEQzgTuVrbJ2=JuFQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] Increase timeout before initiating AVDTP connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Mon, Aug 15, 2011 at 11:21 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Looks like the device really don't like that we start sending commands
> while it is the initiator of the connection, afaik we are just
> following the recommendations from the white paper but since they are
> only recommendations some implementations may ignore them completely.
> Retrying should work in this case because it might force the remote
> stack to enter acceptor mode, but this is only valid when we are
> acting as A2DP source as a A2DP sink we should probably not retry at
> all.

It seems there is something calling Audio.Connect in your system since
device_set_avdtp_timer is only called when auto_connect is set, this
normally happen only after paring, not sure if that is the case.

-- 
Luiz Augusto von Dentz
