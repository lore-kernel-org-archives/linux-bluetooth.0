Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: simon@mungewell.org
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] lib: Add flag to force large MTU size used for SDP connection
Date: Mon, 20 Jan 2014 19:48:31 +0100
Message-ID: <21065964.6PlzB0c1ck@athlon>
In-Reply-To: <cfdf976e52d86b180ee5e750c23fed8f.squirrel@mungewell.org>
References: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com> <cfdf976e52d86b180ee5e750c23fed8f.squirrel@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On Monday 20 January 2014 13:28:57 simon@mungewell.org wrote:
> > From: Szymon Janc <szymon.janc@gmail.com>
> > 
> > This will allow to workaround Dualshock4 not respecting L2CAP MTU
> > size while sending SDP response. Use same L2CAP MTU value base on
> > RFCOMM.
> 
> I can confirm that the V2 series of patches work with my DS4 and crappy
> laptop. Still require particular 'connect' sequence...

Thanks for testing, and yes this sequence is about dedicated vs general 
bonding mentioned in commit message.

> 
> I note that I do not need the original '[PATCH 3/3] input: Add DualShock 4
> detection' patch. I am using just this sequence of 5 patches on top of
> 5.13.

This detection is used only when using SSP controller. And only in case when 
dedicated bonding is used - when DS4 tries to connect immediately after 
pairing is completed, but before bluetoothd was able to retrieve SDP.

-- 
Szymon K. Janc
szymon.janc@gmail.com
