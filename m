Return-Path: <andrea.parri@amarulasolutions.com>
Date: Tue, 14 Aug 2018 20:33:28 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: Brian Norris <computersforpeace@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	AL Yu-Chen Cho <acho@suse.com>
Subject: Re: [Question] bluetooth/{bnep,cmtp,hidp}: memory barriers
Message-ID: <20180814183328.GA8874@andrea>
References: <20180730031030.GA9430@andrea>
 <20180813231854.GA173912@ban.mtv.corp.google.com>
 <5B725A12.8050409@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B725A12.8050409@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeffy, Brian,

On Tue, Aug 14, 2018 at 12:26:58PM +0800, JeffyChen wrote:
> Hi guys,
> 
> Thanks for your mails, and sorry for the late response..
> 
> On 08/14/2018 07:18 AM, Brian Norris wrote:
> >
> >commit 5da8e47d849d3d37b14129f038782a095b9ad049
> >Author: Jeffy Chen<jeffy.chen@rock-chips.com>
> >Date:   Tue Jun 27 17:34:44 2017 +0800
> >
> >     Bluetooth: hidp: fix possible might sleep error in hidp_session_thread
> >
> >that*some*  kind of barrier was stuck in there simply as a response to
> >comments like this, that were going away:
> >
> >-                *
> >-                * Note: set_current_state() performs any necessary
> >-                * memory-barriers for us.
> >                  */
> >-               set_current_state(TASK_INTERRUPTIBLE);
> >
> >+               /* Ensure session->terminate is updated */
> >+               smp_mb__before_atomic();
> >
> >
> >It was probably an attempt to fill in the gap for the
> >set_current_state() (and comment) which was being removed. I believe
> >Jeffy originally added more barriers in other places, but I convinced
> >him not to.
> 
> right, i was trying to avoid losing memory-barriers when removing
> set_current_state and changing wake_up_process to wake_up_interruptible.
> 
> and checking these code again, it's true the smp_mb__before_atomic before
> atomic_read is not needed, the smp_mb after atomic_inc(&session->terminate)
> should be enough.
> 
> and as Brian point out, there's already an smp_store_mb at the end of
> wait_woken, i agree we can remove all the smp_mb__{before,after}_atomic() i
> wrongly added :)

Thank you for checking this once again.  I'll send out a patch removing
these barriers shortly.

  Andrea

P.S. I'm out of office for the next two weeks, so my replies could come
with some delay until ~ -rc1...


> 
> >
> >I have to say, I'm not really up-to-speed on the use of manual barriers
> >in Linux (it's much preferable when they're wrapped into higher-level
> >data structures already), but I believe the main intention here is to
> >ensure that any change to 'terminate' that happened during the previous
> >"wait_woken()" would be visible to our atomic_read().
> >
> >Looking into wait_woken(), I'm feeling like none of these additional
> >barriers are necessary at all. I believe wait_woken() handles the
> >visibility issues we care about (that if we were woken for termination,
> >we'll see the terminating condition).
> 
> 
