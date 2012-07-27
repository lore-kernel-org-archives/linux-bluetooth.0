Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343138034.24426.55.camel@aeonflux>
References: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
	<1343138034.24426.55.camel@aeonflux>
Date: Fri, 27 Jul 2012 10:44:24 +0530
Message-ID: <CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
From: Manoj Sharma <ursmanoj@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 7/24/12, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manoj,
>
>> These patches allows L2CAP socket user to reserve bandwidth in
>> percentage. Underlying socket reserves calculated number of
>> HCI credits for this L2CAP channel.
>
> this description is by far not enough. Explain why you are doing this.
> And make it a detailed description. Preferable with hcidump traces
> showing why this makes a difference at all.
>
This patch simply adds an additional L2CAP socket option for reserving
bandwidth.
The reserved bandwidth would result into reserving calculated number
of ACL data credits. Thus the L2CAP channels without this option set
would not be able to use all available ACL buffers in controller. This
would ensure that whenever an L2CAP channel with this option set has
data to send, it does not starve or wait because of other channels
already using all controller buffers.

Above explanation is most suitable in case when simultaneous AVDTP
streaming channels and other channels (e.g. OPP, PBAP etc) are in
action. Such an arrangement for reserving credits would allow AVDTP
stream to flow to controller without any obstacle from simultaneous
traffic and help removing glitches in music streaming over Bluetooth.
Please suggest if this description is sufficient and if I should push
patch-set again.
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Regards,
Manoj
