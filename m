Return-Path: <cyrus@holtmann.org>
Subject: Re: Switching between SBC and MPEG audio on headsets
From: Arun Raghavan <arun.raghavan@collabora.co.uk>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4D7F9237.2080206@codeaurora.org>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
	 <4D7F9237.2080206@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Mar 2011 01:21:10 +0530
Message-ID: <1300218670.2192.35.camel@snowflake>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Brian,

On Tue, 2011-03-15 at 09:22 -0700, Brian Gix wrote:
[...]
> No this is the incorrect approach.

Thanks (to you and Johan) for the detailed explanation! :)

> Both SRC and SNK devices have a variety of endpoints that have 
> capabilities describing what that endpoint is capable of, the most 
> important of which is the Codec Capability.  Each endpoint is allowed a 
> single capability of a particular type, which means that an endpoint 
> that supports SBC should not attempt to use a different codec (for MPEG 
> in this case). Any device that attempts to wedge both codecs into a 
> single endpoint would most definitely be non-compliant.
> 
> The SUSPEND/RECONFIGURE/START procedure will not work to switch between 
> SBC and MPEG for this reason.  The purpose for that procedure is to 
> allow quick changes within the bounds of the current (remote and local) 
> endpoint capabilities.  To quickly switch between a 44.1KHz and 48KHz 
> sampling for instance.
> 
> The correct procedure to switch between SBC and MPEG would be to close 
> the existing media channel (but NOT the AVDTP signaling channel) and 
> reset up a new endpoint.  If you know you will be doing this, you can 
> save time by caching all of the remote devices endpoints the first time 
> you do an AVDTP_DISCOVER, so that you have all the remote endpoint info 
> you need to make the switch (and even know if the switch will work). You 
> also should have all supported local endpoints separated into their own 
> endpoints of course.
> 
> The to switch, you will need to:
> 
> <halt streaming>
> 
> AVDTP_CLOSE (on AVDTP signaling channel)
> 
> L2CAP_CLOSE (close the media L2CAP channel for SBC)
> 
> <<<< You should Rx AVDTP_CLOSE_CFM
> 
> AVDTP_SET_CONFIG (on AVDTP signaling channel,
>          specify a local and remote endpoint that are compatible)
> 
> <<<<< You should Rx SET_CONFIG_CFM
> 
> AVDTP_OPEN (on AVDTP signaling channel)
> 
> L2CAP_OPEN (open new media L2CAP channel for MPEG)
> 
> <<<<< You should Rx AVDTP_OPEN_CFM
> 
> AVDTP_START (on AVDTP signaling channel)
> 
> <<<<< You should Rx AVDTP_START_CFM
> 
> <start streaming>

I'm quite unfamiliar with how this works, so please excuse any wild
inaccuracies in terminology. I believe that I am doing it this way
already (mostly discovered by trial and error). When I want to
reconfigure, I do the following:

- Send a BT_STOP_STREAM request, get the expected response
- Send a BT_CLOSE request, get the expected response
- Send a BT_OPEN request with the new seid, get the expected response
- Send a BT_SET_CONFIGURATION request with the new caps, get the
expected response
- Send a BT_START_STREAM, wait for the response
- Start streaming

This actually does work here after I apply my patch, although switching
sample rates doesn't seem to actually happen (probably just something
broken in my code).

So if I understand this correctly, it should be sufficient to modify my
patch so we only search for a new remote endpoint if the local endpoint
changed (or a more specific change limited to if the codec type
changed)?

Cheers,
Arun

