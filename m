Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7F9237.2080206@codeaurora.org>
Date: Tue, 15 Mar 2011 09:22:15 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Switching between SBC and MPEG audio on headsets
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
In-Reply-To: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On 3/15/2011 7:27 AM, Arun Raghavan wrote:
> Hello,
> I've been trying to set up PulseAudio to be able to switch the A2DP sink
> dynamically between SBC and MPEG modes. I've got this working now [1], but I
> did face one problem on the bluez side. When sending a reconfigure request, the
> request always goes to the SEID that was used previously (=>  always to the SBC
> SEID). Trying to reconfigure for MPEG therefore results the headset returning
> an error. I'm not very familiar with how this is supposed to work, but the
> patch following this mail seems to work (I can now switch back and forth
> between SBC and MPEG modes). It basically forces figuring out what remote SEP
> to talk to while reconfiguring.
>
> Is this the right approach?

No this is the incorrect approach.

Both SRC and SNK devices have a variety of endpoints that have 
capabilities describing what that endpoint is capable of, the most 
important of which is the Codec Capability.  Each endpoint is allowed a 
single capability of a particular type, which means that an endpoint 
that supports SBC should not attempt to use a different codec (for MPEG 
in this case). Any device that attempts to wedge both codecs into a 
single endpoint would most definitely be non-compliant.

The SUSPEND/RECONFIGURE/START procedure will not work to switch between 
SBC and MPEG for this reason.  The purpose for that procedure is to 
allow quick changes within the bounds of the current (remote and local) 
endpoint capabilities.  To quickly switch between a 44.1KHz and 48KHz 
sampling for instance.

The correct procedure to switch between SBC and MPEG would be to close 
the existing media channel (but NOT the AVDTP signaling channel) and 
reset up a new endpoint.  If you know you will be doing this, you can 
save time by caching all of the remote devices endpoints the first time 
you do an AVDTP_DISCOVER, so that you have all the remote endpoint info 
you need to make the switch (and even know if the switch will work). You 
also should have all supported local endpoints separated into their own 
endpoints of course.

The to switch, you will need to:

<halt streaming>

AVDTP_CLOSE (on AVDTP signaling channel)

L2CAP_CLOSE (close the media L2CAP channel for SBC)

<<<< You should Rx AVDTP_CLOSE_CFM

AVDTP_SET_CONFIG (on AVDTP signaling channel,
         specify a local and remote endpoint that are compatible)

<<<<< You should Rx SET_CONFIG_CFM

AVDTP_OPEN (on AVDTP signaling channel)

L2CAP_OPEN (open new media L2CAP channel for MPEG)

<<<<< You should Rx AVDTP_OPEN_CFM

AVDTP_START (on AVDTP signaling channel)

<<<<< You should Rx AVDTP_START_CFM

<start streaming>



Regards,


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
