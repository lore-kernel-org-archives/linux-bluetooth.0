Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jan 2015 20:30:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] bluetooth: Fix nested sleeps
Message-ID: <20150123183039.GA6061@t440s.P-661HNU-F1>
References: <1422032904-17091-1-git-send-email-peter@hurleysoftware.com>
 <1422033413-17405-1-git-send-email-peter@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422033413-17405-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Jan 23, 2015, Peter Hurley wrote:
> l2cap/rfcomm/sco_sock_accept() are wait loops which may acquire
> sleeping locks. Since both wait loops and sleeping locks use
> task_struct.state to sleep and wake, the nested sleeping locks
> destroy the wait loop state.
> 
> Use the newly-minted wait_woken() and DEFINE_WAIT_FUNC() for the
> wait loop. DEFINE_WAIT_FUNC() allows an alternate wake function
> to be specified; in this case, the predefined scheduler function,
> woken_wake_function(). This wait construct ensures wakeups will
> not be missed without requiring the wait loop to set the
> task state before condition evaluation. How this works:
> 
>  CPU 0                            |  CPU 1
>                                   |
>                                   | is <condition> set?
>                                   | no
> set <condition>                   |
>                                   |
> wake_up_interruptible             |
>   woken_wake_function             |
>     set WQ_FLAG_WOKEN             |
>     try_to_wake_up                |
>                                   | wait_woken
>                                   |   set TASK_INTERRUPTIBLE
>                                   |   WQ_FLAG_WOKEN? yes
>                                   |   set TASK_RUNNING
>                                   |
>                                   | - loop -
> 				  |
> 				  | is <condition> set?
>                                   | yes - exit wait loop
> 
> Fixes "do not call blocking ops when !TASK_RUNNING" warnings
> in l2cap_sock_accept(), rfcomm_sock_accept() and sco_sock_accept().
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> 
> v2: minor commit log fixes
>     * s/woken_wait_function/woken_wake_function/
>     * indent 'set TASK_RUNNING' under wait_woken to clarify
>       wait_woken() performs that operation
> 
>  net/bluetooth/l2cap_sock.c  | 9 ++++-----
>  net/bluetooth/rfcomm/sock.c | 9 ++++-----
>  net/bluetooth/sco.c         | 8 +++-----
>  3 files changed, 11 insertions(+), 15 deletions(-)

Applied to bluetooth-next. Thanks!

Johan
