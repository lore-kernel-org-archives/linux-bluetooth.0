Return-Path: <cyrus@holtmann.org>
Message-ID: <4C3F7FEE.1040101@codeaurora.org>
Date: Thu, 15 Jul 2010 16:38:54 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
References: <1278625779.10421.80.camel@localhost.localdomain>	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org> <1278972477.6282.10.camel@localhost.localdomain>
In-Reply-To: <1278972477.6282.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel:

On 7/12/2010 5:07 PM, Marcel Holtmann wrote:
> Hi Ron,
> 
>> Certain headsets such as the Motorola H350 will reject SCO and eSCO
>> connection requests while the ACL is transitioning from sniff mode
>> to active mode. Add synchronization so that SCO and eSCO connection
>> requests will wait until the ACL has fully transitioned to active mode.
> 
> I find your patch actually highly complicated. So I tried to capture
> your intend the in the attached patch (only compiled test) and it would
> be good if you can try that.
> 
> So in general it makes no difference which mode we are in. If a mode
> change is pending, then we have to delay the SCO setup. And once we are
> done we the mode change we just setup the SCO link. So in theory that
> should be enough. Not sure if that is true. I could have overlooked
> something since I don't really have tested the patch at all ;)
> 
> Regards
> 
> Marcel
> 

Would have been back with you sooner on this but I'm having some
hardware issues preventing me from testing your code. I'm fairly
confident it works as you've consolidated the pending check into
hci_conn which I like.

However, the complicated pieces to which I think you are referring are
the error handling pieces which we should want want to keep. These make
sure that we clean up appropriately if:

1. The HW rejects the exit sniff or the SCO/eSCO request for some reason
i.e. in the case the HW returns a command status with a failure
2. In the latter case, the user space process is also notified that its
SCO/eSCO request has failed.

Give the cleanup code some thought. I think you'll see we want this
there to make the system more reliable.

As soon as I've confirmed your patch I'll get back to you.

In the meantime, I'll talk with Oleg and Matt regarding their responses.

-- 
Ron Shaffer
Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
