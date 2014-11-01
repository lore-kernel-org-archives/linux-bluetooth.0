Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Nov 2014 23:24:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2] Bluetooth : Fix hci_sync miss wakeup interrupt
Message-ID: <20141101212409.GA11441@t440s.P-661HNU-F1>
References: <1414732986-20487-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414732986-20487-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Fri, Oct 31, 2014, chanyeol.park@samsung.com wrote:
> __hci_cmd_sync_ev(), __hci_req_sync() could miss wake_up_interrupt from
> hci_req_sync_complete() because hci_cmd_work() workquee and its reponse
> could be completed before they are ready to get the signal through
> add_wait_queue(), set_current_state(TASK_INTERRUPTIBLE).
> 
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  net/bluetooth/hci_core.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Applied to bluetooth-next. Thanks.

This fixed a really frequent hang for me of init HCI commands when
running mgmt-tester. Is it through the our user space testers that you
were seeing this issue as well? I might have seen the problem in the
past too but for some reason it started showing up really frequently
now.

Johan
