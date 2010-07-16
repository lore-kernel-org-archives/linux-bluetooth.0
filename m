Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Marcel Holtmann <marcel@holtmann.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C3F7FEE.1040101@codeaurora.org>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
	 <1278972477.6282.10.camel@localhost.localdomain>
	 <4C3F7FEE.1040101@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jul 2010 09:32:10 -0700
Message-ID: <1279297930.6282.83.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

> >> Certain headsets such as the Motorola H350 will reject SCO and eSCO
> >> connection requests while the ACL is transitioning from sniff mode
> >> to active mode. Add synchronization so that SCO and eSCO connection
> >> requests will wait until the ACL has fully transitioned to active mode.
> > 
> > I find your patch actually highly complicated. So I tried to capture
> > your intend the in the attached patch (only compiled test) and it would
> > be good if you can try that.
> > 
> > So in general it makes no difference which mode we are in. If a mode
> > change is pending, then we have to delay the SCO setup. And once we are
> > done we the mode change we just setup the SCO link. So in theory that
> > should be enough. Not sure if that is true. I could have overlooked
> > something since I don't really have tested the patch at all ;)
>
> Would have been back with you sooner on this but I'm having some
> hardware issues preventing me from testing your code. I'm fairly
> confident it works as you've consolidated the pending check into
> hci_conn which I like.
> 
> However, the complicated pieces to which I think you are referring are
> the error handling pieces which we should want want to keep. These make
> sure that we clean up appropriately if:
> 
> 1. The HW rejects the exit sniff or the SCO/eSCO request for some reason
> i.e. in the case the HW returns a command status with a failure
> 2. In the latter case, the user space process is also notified that its
> SCO/eSCO request has failed.
> 
> Give the cleanup code some thought. I think you'll see we want this
> there to make the system more reliable.
> 
> As soon as I've confirmed your patch I'll get back to you.

I think the general discussion here is what we expect a normal behaving
system to do and what would be a good idea.

So we already have the case where just always unsniff the ACL link
before establishing any SCO link. If that assumption still holds then I
think it is more than fair to wait for the mode change event as well.

My point is just that when we receive the mode change event, we don't
care if the unsniff (or unpark/unhold) for that matter was successful.
We proceed with the SCO setup.

The change is like this "if a mode change is in progress, then wait
until it finished before trying to setup SCO". I think that is a proper
way of doing this anyway. It really doesn't change anything else. If the
link is active anyway, then nothing has been changed here in the first
place.

And yes, in case of a HCI disconnect event we should clear out the
pending SCO setup request. However that is done anyway, since this flag
is stored inside the ACL connection handle. Right now I really don't see
an issue with this patch.

For the potential security concern, yes that can happen, but lets be
fair, we can't prevent this from the host anyway. Same as someone could
just block the 2.4 GHz spectrum and will disrupt calls.

Regards

Marcel


