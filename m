Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 19:01:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Switching between SBC and MPEG audio on headsets
Message-ID: <20110315170124.GA15712@jh-x301>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Tue, Mar 15, 2011, Arun Raghavan wrote:
> I've been trying to set up PulseAudio to be able to switch the A2DP sink
> dynamically between SBC and MPEG modes. I've got this working now [1], but I
> did face one problem on the bluez side. When sending a reconfigure request, the
> request always goes to the SEID that was used previously (=> always to the SBC
> SEID). Trying to reconfigure for MPEG therefore results the headset returning
> an error. I'm not very familiar with how this is supposed to work, but the
> patch following this mail seems to work (I can now switch back and forth
> between SBC and MPEG modes). It basically forces figuring out what remote SEP
> to talk to while reconfiguring.
> 
> Is this the right approach?

I'm not sure about the places where you set the value to NULL, but the
place in close_cfm which you remove isn't acceptable as such. It was
originally created to fix the issue reported in this thread:
http://marc.info/?l=linux-bluetooth&m=129190286303247&w=2

Only a fix which doesn't break the use-case reported there can be
accepted upstream. FWIW, the commit that introduced the fix is de96fcd8.

Johan
