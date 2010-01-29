Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1264776266-7646-1-git-send-email-jprvita@gmail.com>
References: <1264776266-7646-1-git-send-email-jprvita@gmail.com>
Date: Fri, 29 Jan 2010 12:53:24 -0200
Message-ID: <aa32413d1001290653x717105bfx1d90653054a3cd24@mail.gmail.com>
Subject: Re: [RFC] [PATCH 0/2] HFP AG integration with PulseAudio
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: pulseaudio-discuss@mail.0pointer.de
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Zheng Huan <huan.zheng@intel.com>,
	Lennart Poettering <lennart@poettering.net>, ofono@ofono.org,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/1/29 João Paulo Rechi Vita <jprvita@gmail.com>:
> Hi all,
>
> I'm trying to add support for the Handsfree Gateway role Gustavo just added
> to BlueZ and oFono. The BlueZ patches can be found on [1] and [2] and the
> oFono part was just merged upstream.
>
> But when it comes to integrate them with Pulse, I'm getting a POLLHUP when
> trying to write on the fd. Also, it seems different gateways have different
> behaviours regarding when they connect the SCO link. Some phone connect
> them just after the RFCOMM link (some Nokia phones), when there is no call
> going on yet, and others just when a call is started (Android 1.5).
>
> Also, right now the same property (State) is beeing used to refer when the
> RFCOOM link is established (State=Connected) and when the SCO link is
> established (State=Playing). Shouldn't this be handled by separate props?
>
> And last but not least, is the new Media API intended to handle the audio
> part of handsfree gateways too? If so, maybe we should use all this work
> as a prototype for latter integration with the new API.
>
> Any help on testing and getting this working together or comments on the
> topic would be appreciated.
>
> [1] http://www.spinics.net/lists/linux-bluetooth/msg04250.html
> [2] http://www.spinics.net/lists/linux-bluetooth/msg04251.html
>
> --
> João Paulo Rechi Vita
> http://jprvita.wordpress.com/
>
>

I forgot to add, suspending of the sink/source seemed to cause
disconnection by the AG, so you might want to disable
module-suspend-on-idle when testing. BTW, Lennart, is there any way to
mark a source/sink to not be suspended?

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
