Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141216114330.GA4618@t440s.lan>
References: <1418293574-25095-1-git-send-email-jpawlowski@google.com>
	<20141216114330.GA4618@t440s.lan>
Date: Wed, 17 Dec 2014 15:44:22 +0100
Message-ID: <CAD0=r8wnLW6tpbf3EvaPmd=wXKgSzW8tf_4Lr4pft5A2JU2XLA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Bluetooth: Add lock for HCI_OP_SCAN_ENABLE command
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 16, 2014 at 12:43 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Thu, Dec 11, 2014, Jakub Pawlowski wrote:
>> This patch introduces new lock, that need to be acquired if you want
>> to use HCI_OP_SCAN_ENABLE in a series of request. Next patch introduces
>> le restarting that would have race condition without that.
>
> This is not really the way that locks are typically used and will likely
> result in bugs in the long run. Each lock should have a well defined
> piece of data that it protects and the lock/unlock pair should cover a
> clear and contiguous section of code. Neither one of these principles
> seems to fulfilled by your design.
>
> As an example, your code would be stuck with the lock if you powered off
> the adapter while holding it (since the HCI request callbacks would not
> get called). So you'll need to find a different kind of solution here.
> It seems to me like you're looking for some sort of state tracking,
> which is something locking shouldn't be mixed with.
>
> Johan.

Hi Johan,

So I previously submitted this patch with new flag,
HCI_SCAN_RESTARTING that could be set on &hdev->flags, but Marcel
pointed that it'll also have race conditions.
I was thinking about it for some time, and I came with this solution:

Right now when you run queue of requests with hci_req_run, there's
only one callback at end, that can be accessed as req.complete.

I want to add ability to have callbacks when this queue is running,
after each operation, not only at end of it. This way I would be able
to set some special flag and then unset it right when it's needed,
only for disabling and enabling scan to modify
hci_cc_le_set_scan_enable behaviour properly.

(I assume that when I have queue of hci operations and I run
hci_req_run it can't be interrupted with other queue of operations for
one controller, is that right ?)


When it comes to hanges in code:
currently in hci_req_cmd_complete (
http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/hci_core.c#n5357
) there's this piece of code:

/* If this was the last command in a request the complete
* callback would be found in hdev->sent_cmd instead of the
* command queue (hdev->cmd_q).
*/
if (hdev->sent_cmd) {
req_complete = bt_cb(hdev->sent_cmd)->req.complete;

if (req_complete) {
/* We must set the complete callback to NULL to
* avoid calling the callback more than once if
* this function gets called again.
*/
bt_cb(hdev->sent_cmd)->req.complete = NULL;

goto call_complete;
}
}

I want to modify it so that callback can be called after each
operation, or add some new kind of operation that would only run
callback.

What do you think about this solution ? You know this code better,
maybe you know simpler way ?
