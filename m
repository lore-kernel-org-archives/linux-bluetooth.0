Return-Path: <computersforpeace@gmail.com>
Date: Mon, 13 Aug 2018 16:18:54 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Brian Norris <briannorris@chromium.org>,
	AL Yu-Chen Cho <acho@suse.com>
Subject: Re: [Question] bluetooth/{bnep,cmtp,hidp}: memory barriers
Message-ID: <20180813231854.GA173912@ban.mtv.corp.google.com>
References: <20180730031030.GA9430@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730031030.GA9430@andrea>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 30, 2018 at 05:10:30AM +0200, Andrea Parri wrote:
> Hi,

Hi!

> I'm currently puzzled by the the three calls to smp_mb__before_atomic()
> in bnep_session(), cmtp_session() and hidp_session_run() respectively:

For the curious: I believe Jeffy Chen added all of those.

> On the one hand, these barriers provide no guarantee on the subsequent
> atomic_read(s->terminate) (as the comments preceding the barriers seem
> to suggest), because atomic_read() is not a read-modify-write.

I'll admit, I didn't notice that piece of the documentation when
reviewing this the first time:

Documentation/atomic_t.txt
<quote>
The barriers:

  smp_mb__{before,after}_atomic()

only apply to the RMW ops and can be used to augment/upgrade the ordering
inherent to the used atomic op.
</quote>

> On the other hand, I'm currently unable to say *why such an "mb" would
> be required: not being too familiar with this code, I figured I should
> ask before sending a patch.  ;-)

I can't fully speak for Jeffy, but I expect based on the initial
development of his patches like this one

commit 5da8e47d849d3d37b14129f038782a095b9ad049
Author: Jeffy Chen <jeffy.chen@rock-chips.com>
Date:   Tue Jun 27 17:34:44 2017 +0800

    Bluetooth: hidp: fix possible might sleep error in hidp_session_thread

that *some* kind of barrier was stuck in there simply as a response to
comments like this, that were going away:

-                *
-                * Note: set_current_state() performs any necessary
-                * memory-barriers for us.
                 */
-               set_current_state(TASK_INTERRUPTIBLE);

+               /* Ensure session->terminate is updated */
+               smp_mb__before_atomic();


It was probably an attempt to fill in the gap for the
set_current_state() (and comment) which was being removed. I believe
Jeffy originally added more barriers in other places, but I convinced
him not to.

I have to say, I'm not really up-to-speed on the use of manual barriers
in Linux (it's much preferable when they're wrapped into higher-level
data structures already), but I believe the main intention here is to
ensure that any change to 'terminate' that happened during the previous
"wait_woken()" would be visible to our atomic_read().

Looking into wait_woken(), I'm feeling like none of these additional
barriers are necessary at all. I believe wait_woken() handles the
visibility issues we care about (that if we were woken for termination,
we'll see the terminating condition).

That's my two cents, even if it's only worth about two cents.

HTH,
Brian
