Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@gmail.com>
Subject: Re: [PATCH RESEND] client: Clean up agent if bluetoothd exited without releasing it
Date: Mon, 28 Apr 2014 11:20:33 +0200
Message-ID: <2465782.SFzOROTRxg@uw000953>
In-Reply-To: <20140428082236.GA32279@t440s.lan>
References: <1398421820-9273-1-git-send-email-szymon.janc@tieto.com> <20140428082236.GA32279@t440s.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Monday 28 of April 2014 11:22:36 Johan Hedberg wrote:
> Hi Szymon,
> 
> On Fri, Apr 25, 2014, Szymon Janc wrote:
> > If bluetoothd exited without releasing agent (eg. due to crash) it was
> > not possible to register client as agent after daemon was restarted.
> > ---
> >  client/agent.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> Since client/main.c is already doing tracking or org.bluez I think it
> might make more sense to do the agent clearing from there, maybe by
> adding an agent_clear function to agent.c and then calling it from
> disconnect_handler in main.c. Thoughts?

There is patch from Luiz that does exactly this and I'm fine with applying it
instead.

"[PATCH BlueZ 2/3] client: Fix not releasing agent if bluetoothd exit without
calling Release" from 26.11.2013.

-- 
Best regards, 
Szymon Janc
