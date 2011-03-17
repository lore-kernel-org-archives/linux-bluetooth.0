Return-Path: <cyrus@holtmann.org>
Subject: Re: Switching between SBC and MPEG audio on headsets
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Reply-To: donpedro@tdcadsl.dk
To: Brian Gix <bgix@codeaurora.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Arun Raghavan <arun.raghavan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <4D814334.6080407@codeaurora.org>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
	 <20110315170124.GA15712@jh-x301>
	 <AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com>
	 <1300315111.4500.34.camel@donpedro>  <4D814334.6080407@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 10:35:42 +0100
Message-ID: <1300354542.4500.72.camel@donpedro>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, 2011-03-16 at 16:09 -0700, Brian Gix wrote:
> This is not actually true. You can have multiple media channels open 
> simultaneously (for instance one for Video and one for Audio) which
> are 
> opened with careful handshaking with the AVDTP_OPEN signaling
> command. 
> In theory, this could be two audio channels as well.  If someone wants
> a 
> Journaling channel, it would be opened without the AVDTP_OPEN
> signaling.

Yes, except protocol-wise the new channel on PSM=0x19 could also be the
start of a new A2DP signaling connection (however very unlikely). As you
mentioned, the problem with the Journaling channel can be filtered out
with correct signaling.

I totally agree with you that your solution is the most elegant. However
back when A2DP was introduced it did not seem clear to everyone how
multiple streams would work. Some thought it would work with multiple
media channels (like you suggest), and some thought it would work with
multiple signaling channels (with max 1 media channel).

Most of the implementations i have seen (for headsets), unfortunately
ended up with the last solution. This means that they will not accept a
secondary media channel. This is unfortunately basically true for all of
the most popular chipsets and SDKs.

Your suggestion is clever and follows the standard nicely (and would get
my vote for a white-paper), but i doubt it will work with many headsets
out there.

Even worse, many headsets are hardcoded (not nice) to believe that the
3rd channel is always the Journaling channel. That is of course, just
plain wrong due to the reasons you have stated.

Thanks,

/pedro



