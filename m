Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7FCF71.7080702@codeaurora.org>
Date: Tue, 15 Mar 2011 13:43:29 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Switching between SBC and MPEG audio on headsets
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>	 <4D7F9237.2080206@codeaurora.org> <1300218670.2192.35.camel@snowflake>
In-Reply-To: <1300218670.2192.35.camel@snowflake>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On 3/15/2011 12:51 PM, Arun Raghavan wrote:
> Hey Brian,
>

[...]

>
> I'm quite unfamiliar with how this works, so please excuse any wild
> inaccuracies in terminology. I believe that I am doing it this way
> already (mostly discovered by trial and error). When I want to
> reconfigure, I do the following:
>
> - Send a BT_STOP_STREAM request, get the expected response
> - Send a BT_CLOSE request, get the expected response
> - Send a BT_OPEN request with the new seid, get the expected response
> - Send a BT_SET_CONFIGURATION request with the new caps, get the
> expected response
> - Send a BT_START_STREAM, wait for the response
> - Start streaming

Well, with full knowledge that I *haven't* examined this part of BlueZ, 
I can say that from a protocol perspective, the AVDTP_SET_CONFIG must go 
over the air/be acknowledged  before the AVDTP_OPEN can be 
sent/acknowledged.  I haven't checked to see if those step are 
obfuscated at all by the BT_OPEN/BT_SET_CONFIGURATION naming convention, 
or if it is a simple mapping.

On a compliant device, an Open directly following a Close should return 
a NOT_CONFIGURED error. But it may be that a less strict SNK device 
might assume the last configuration and overlook the protocol error.

>
> This actually does work here after I apply my patch, although switching
> sample rates doesn't seem to actually happen (probably just something
> broken in my code).
>
> So if I understand this correctly, it should be sufficient to modify my
> patch so we only search for a new remote endpoint if the local endpoint
> changed (or a more specific change limited to if the codec type
> changed)?
>
> Cheers,
> Arun
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
