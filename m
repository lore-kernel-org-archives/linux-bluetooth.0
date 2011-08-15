Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313370363.2144.46.camel@THOR>
References: <1313161215.2254.6.camel@THOR>
	<CABBYNZ+3jC+1LbvHgie5LX_8Xr_kRT6G-ed7dsn-pEUzoVam=g@mail.gmail.com>
	<1313370363.2144.46.camel@THOR>
Date: Mon, 15 Aug 2011 11:21:50 +0300
Message-ID: <CABBYNZJ5GMqnWr6=OzDcC=YxCTSMH2EEu8x4p04=OZYExyM6+g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] Increase timeout before initiating AVDTP connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Mon, Aug 15, 2011 at 4:06 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> .... AVDTP Set Configuration ....
>
> 2011-08-11 18:35:04.637300 < ACL data: handle 13 flags 0x00 dlen 18
>    L2CAP(d): cid 0x0055 len 14 [psm 25]
>      AVDTP(s): Set config cmd: transaction 7 nsp 0x00
>        ACP SEID 1 - INT SEID 1
>        Media Transport
>        Media Codec - SBC
>          44.1kHz
>          JointStereo
>          16 Blocks
>          8 Subbands
>          Loudness
>          Bitpool Range 2-44
>
> .... Now, what can we do about what happens next? ....
>
> 2011-08-11 18:35:04.651185 > ACL data: handle 13 flags 0x02 dlen 6
>    L2CAP(d): cid 0x0041 len 2 [psm 25]
>      AVDTP(s): Discover cmd: transaction 10 nsp 0x00
> 2011-08-11 18:35:04.651237 < ACL data: handle 13 flags 0x00 dlen 8
>    L2CAP(d): cid 0x0055 len 4 [psm 25]
>      AVDTP(s): Discover rsp: transaction 10 nsp 0x00
>        ACP SEID 1 - Audio Source (InUse)
> 2011-08-11 18:35:04.653184 > HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 13 packets 2
> 2011-08-11 18:35:04.693186 > ACL data: handle 13 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0041 len 4 [psm 25]
>      AVDTP(s): Set config rej: transaction 7 nsp 0x00
>        Reserved
>        Error code 19
> 2011-08-11 18:35:04.761186 > ACL data: handle 13 flags 0x02 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0055
> 2011-08-11 18:35:04.761202 < ACL data: handle 13 flags 0x00 dlen 12
>    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0055
>
> The headset has disconnected the AVDTP signaling channel because we have
> marked the SEP as "in use" (which is, of course, exactly what was
> required prior to issuing the Set Config). Like I wrote in the commit
> message, "broken AVDTP implementations".

Ouch, looks pretty much broken, btw what device is that?

> My point here is a lot has happened before discovering that something is
> wrong. I'm not even sure if this headset would respond to an attempt to
> restart from this - maybe.

What happen if you try to connect A2DP manually (AudioSink.Connect)
latter? If it does succeeds then there is a chance retrying would
help.

> In the baseline trial with existing delay of 1 sec. (using HSP profile),
> the headset simply never responds to the GET_CAPABILITIES for seid 2 -
> the connection times out after 5 seconds and is disconnected:
>
> 2011-08-12 06:36:16.992657 < ACL data: handle 13 flags 0x00 dlen 6
>    L2CAP(d): cid 0x0056 len 2 [psm 25]
>      AVDTP(s): Discover cmd: transaction 3 nsp 0x00
> 2011-08-12 06:36:17.078604 > ACL data: handle 13 flags 0x02 dlen 10
>    L2CAP(d): cid 0x0041 len 6 [psm 25]
>      AVDTP(s): Discover rsp: transaction 3 nsp 0x00
>        ACP SEID 1 - Audio Sink
>        ACP SEID 2 - Audio Sink
> 2011-08-12 06:36:17.078692 < ACL data: handle 13 flags 0x00 dlen 7
>    L2CAP(d): cid 0x0056 len 3 [psm 25]
>      AVDTP(s): Capabilities cmd: transaction 4 nsp 0x00
>        ACP SEID 1
> 2011-08-12 06:36:17.083599 > HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 13 packets 2
> 2011-08-12 06:36:17.122604 > HCI Event: Link Supervision Timeout Change (0x38) plen 4
>    handle 13 timeout 8064
> 2011-08-12 06:36:17.372605 > ACL data: handle 13 flags 0x02 dlen 16
>    L2CAP(d): cid 0x0041 len 12 [psm 25]
>      AVDTP(s): Capabilities rsp: transaction 4 nsp 0x00
>        Media Transport
>        Media Codec - SBC
>          16kHz 32kHz 44.1kHz 48kHz
>          Mono DualChannel Stereo JointStereo
>          4 8 12 16 Blocks
>          4 8 Subbands
>          SNR Loudness
>          Bitpool Range 2-44
> 2011-08-12 06:36:17.372720 < ACL data: handle 13 flags 0x00 dlen 7
>    L2CAP(d): cid 0x0056 len 3 [psm 25]
>      AVDTP(s): Capabilities cmd: transaction 5 nsp 0x00
>        ACP SEID 2
> 2011-08-12 06:36:17.594603 > HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 13 packets 1
> 2011-08-12 06:36:22.406607 > HCI Event: Max Slots Change (0x1b) plen 3
>    handle 13 slots 1
> 2011-08-12 06:36:22.596605 > HCI Event: Mode Change (0x14) plen 6
>    status 0x00 handle 13 mode 0x02 interval 1024
>    Mode: Sniff
> 2011-08-12 06:36:23.573334 < ACL data: handle 13 flags 0x00 dlen 12
>    L2CAP(s): Disconn req: dcid 0x0056 scid 0x0041
> 2011-08-12 06:36:24.094607 > HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 13 packets 1
> 2011-08-12 06:36:24.519609 > ACL data: handle 13 flags 0x02 dlen 12
>    L2CAP(s): Disconn rsp: dcid 0x0056 scid 0x0041

Looks like the device really don't like that we start sending commands
while it is the initiator of the connection, afaik we are just
following the recommendations from the white paper but since they are
only recommendations some implementations may ignore them completely.
Retrying should work in this case because it might force the remote
stack to enter acceptor mode, but this is only valid when we are
acting as A2DP source as a A2DP sink we should probably not retry at
all.

-- 
Luiz Augusto von Dentz
