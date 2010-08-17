Return-Path: <cyrus@holtmann.org>
Sender: Johan Hedberg <johan.hedberg@gmail.com>
Date: Tue, 17 Aug 2010 17:20:42 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH 0/5] Fast connectable mode for HFP
Message-ID: <20100817142042.GC16071@jh-x301>
References: <1282053934-19445-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282053934-19445-1-git-send-email-dmitriy.paliy@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Aug 17, 2010, Dmitriy Paliy wrote:
> The following patches are implementation of fast connectable mode for HFP.
> Such mode means significantly shorter page scan interval and interlaced
> page scan type. As a result, HFP connection typically is created much faster.
> The fast connectable mode can be activated by incomming call indicator and
> deactivated by answer or reject call indicator. Such speeds up connectability
> of a headset when there is an incomming call. Retransmisions in eSCO are
> possible to be paused for in-band ring tone when the mode is enabled during
> given above period of time. eSCO is not affected during call since page scan
> settings are returned to their default values immidiately after call is
> accepted (or rejected).
> 
> Use of the mode can be enabled by changing FastConnectable in audio.conf
> configuration file. It is disabled by default. Also, it doesn't affect and
> doesn't change any other interfaces.

In general these patches seem fine to me, however I'd like a second
opinion from Marcel before pushing upstream.

Johan
