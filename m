Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Jul 2011 12:18:57 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Peter Hurley <peter@hurleysoftware.com>
cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/7] Fix various lost wakeups
In-Reply-To: <1311480631.4106.25.camel@THOR>
Message-ID: <alpine.DEB.2.02.1107251205130.15852@mathewm-linux>
References: <1311480631.4106.25.camel@THOR>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Peter -

On Sun, 24 Jul 2011, Peter Hurley wrote:

> Several kthreads, and some other functions which also wait/sleep, exhibit
> race conditions when using set_current_state(TASK_INTERRUPTIBLE). A common,
> but incorrect, usage pattern is:
>
> 1:  add_wait_queue(...);
> 2:  while (!condition) {
> 3:          set_current_state(TASK_INTERRUPTIBLE);
> 4:          do_work();
> 5:          schedule();
> 6:  }
> 7:  set current_state(TASK_RUNNING);
> 8:  remove_wait_queue(...);

<snip>

> PS - I did not fix the usage in l2cap_core.c pending if the new ERTM
> reassembly will make that work unnecessary.

I think your fix is needed in l2cap_core.c.  ERTM reassembly (and 
other pending changes) won't be modifying that code.

Thanks,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

