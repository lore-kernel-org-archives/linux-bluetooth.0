Return-Path: <cyrus@holtmann.org>
Subject: Re: Switching between SBC and MPEG audio on headsets
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Reply-To: donpedro@tdcadsl.dk
To: Brian Gix <bgix@codeaurora.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Arun Raghavan <arun.raghavan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <4D823499.3060208@codeaurora.org>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
	 <20110315170124.GA15712@jh-x301>
	 <AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com>
	 <1300315111.4500.34.camel@donpedro>  <4D814334.6080407@codeaurora.org>
	 <1300354542.4500.72.camel@donpedro>  <4D823499.3060208@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 22:33:49 +0100
Message-ID: <1300397629.4500.99.camel@donpedro>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Thu, 2011-03-17 at 09:19 -0700, Brian Gix wrote:
> AVDTP only allows a single signaling channel to exist between any two 
> peers. You are allowed to have separate signaling channels to
> separate 
> remote devices, but even if you are supporting multiple media streams 
> (video/audio, or audio/audio) to the same device, all AVDTP signaling 
> must be done on a single channel. 

Yes, exactly. But i am not sure everyone caught that part back when A2DP
was introduced. :-)

> Actually, I thought I was agreeing with you about *not* having two 
> media 
> channels open simultaneously.

Yes, you were. I just wanted to add an extra warning if someone still
wanted to go that way :-). I agree that compatibility is very important.

Thanks,

/pedro






