Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Aug 2010 14:15:16 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/5] Fast connectable mode for HFP (update)
Message-ID: <20100818111516.GA2910@jh-x301>
References: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

On Wed, Aug 18, 2010, Dmitriy Paliy wrote:
> The following patches are implementation of fast connectable mode for HFP.
> Such mode means significantly shorter page scan interval and interlaced
> page scan type. As a result, HFP connection typically is created much faster.
> The fast connectable mode can be activated by incomming call indicator and
> deactivated by answer or reject call indicator. Such speeds up connectability
> of a headset when there is an incomming call. Retransmisions in eSCO are
> possiblle to be paused for in-band ring tone when the mode is enabled during
> given above period of time. eSCO is not affected during call since page scan
> settings are returned to their default values immidiately after call is
> accepted (or rejected).
> 
> Use of the mode can be enabled by changing FastConnectable in audio.conf
> configuration file. It is disabled by default. Also, it doesn't affect and
> doesn't change any other interfaces.

Thanks for the patches. They've all been pushed upstream.

One thing that still needs discussing/consideration is the safeguard for
setting the correct mode if bluetoothd crashed while we were in the fast
connectable mode. Right now your patches take care of this in the audio
plugin but in the future if other users of this new core daemon API come
up the proper intialization should (imho) be inside the core daemon. We
already do this for things like periodic inquiry where bluetoothd always
sends the HCI_Exit_Periodic_Inquiry_Mode command when it starts up (in
case bluetoothd previously crashed while discovering devices).

Johan
