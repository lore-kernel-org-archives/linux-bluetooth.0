Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1348218561-24509-2-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348218561-24509-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1348218561-24509-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 21 Sep 2012 11:51:23 -0400
Message-ID: <CAJdJm_PyC22Les5_=+z+MjnbFzGGZ7CepQNEo9QRdV0z_SaUKA@mail.gmail.com>
Subject: Re: [PATCH] Cycling Speed and Cadence profile (CSCP) API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Fri, Sep 21, 2012 at 5:09 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> +Cycling Speed and Cadence API description
> +****************************************
> +
> +Copyright (C) 2012     Tieto Poland
> +
> +Cycling Manager hierarchy
> +============================
> +
> +Service                org.bluez
> +Interface      org.bluez.CyclingManager

I don't have much to comment on the API as I haven't had time to read
the CSCP spec yet, but about the name prefix, what about
"CyclingSpeed" (and "RunningSpeed" for the future RSCP) ? Too long?

The "Cycling" name is slightly uncommon, but still not that bad IMHO.

> +Properties     String Location (optional) [readwrite]

String -> string

> +                               uint16 LastWheelEventTime (optional):
> +
> +                                       Value of Last Wheel Event time

Better specify that this is in "1/1024 second units" (just checked on
developer.bluetooth.org).

> +
> +                               uint16 CrankRevolutions (optional):
> +
> +                                       Cumulative number of crank revolutions
> +
> +                               uint16 LastCrankEventTime (optional):
> +
> +                                       Value of Last Crank Event time

Same here.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
