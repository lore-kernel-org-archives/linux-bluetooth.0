Return-Path: <cyrus@holtmann.org>
Message-ID: <1385560701.17991.4.camel@nuvo>
Subject: Re: Crasher during remote initiated pairing
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 27 Nov 2013 14:58:21 +0100
In-Reply-To: <20131127090605.GA28918@x220.p-661hnu-f1>
References: <1385398409.3423.25.camel@nuvo>
	 <20131127090605.GA28918@x220.p-661hnu-f1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2013-11-27 at 11:06 +0200, Johan Hedberg wrote:
<snip>
> The agent_auth_cb is actually not used for pairing but for
> authorization, so whether it's RequestPinCode or RequestPasskey wont
> matter for the above backtrace. Anyway, I was never able to reproduce
> the exact same issue as you had, but I did find two places needing some
> extra checks (one in adapter.c and another in agent.c). So it'd be good
> if you could give the latest git a spin and see if you can still
> reproduce the crash.

That seems to work fine, thanks.

