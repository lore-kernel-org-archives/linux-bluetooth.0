Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 12:16:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for entering limited discoverable
 mode
Message-ID: <20131015091658.GA4930@x220.p-661hnu-f1>
References: <1381792099-8732-1-git-send-email-marcel@holtmann.org>
 <20131015073157.GA24495@x220.p-661hnu-f1>
 <66F13BAB-8341-44B5-9D84-A55DFDD6C324@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66F13BAB-8341-44B5-9D84-A55DFDD6C324@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 15, 2013, Marcel Holtmann wrote:
> >> +	if (cp->val) {
> >> +		struct hci_cp_write_current_iac_lap cp;
> >> +
> >> +		if (timeout > 0) {
> >> +			/* Limited discoverable mode */
> > 
> > Wouldn't we want to follow the recommendation from the Core spec here,
> > volume 3, part C, section 4.1.2.1:
> > 
> > "A Bluetooth device should not be in limited discoverable mode for more than
> > TGAP(104)"
> > 
> > TGAP(104) in turn is defined as 1 minute (vol 3, part C, Appendix A).
> 
> I was not going to be this strict. So yes, userspace can violate the
> GAP part here, but it might be a good idea to ensure that when a too
> large value is entered we stick with general discoverable mode.
> However is this really worth it.

For Advertising the max value is actually not just a recommendation but
a requirement (check my other mail), so at least there we should
probably enforce it. And if we have to enforce it for LE we might as
well do it for BR/EDR too. It's anyway a rather simple change to the
if-statement.

> Another option is to just reject too large timeout values as invalid
> parameters and force userspace to implement large timeouts with
> general discoverable mode in userspace.

I don't think it's a good idea to force this kind of special handling to
user space (not just the requirement to know where the limits go but
also the need to implement a separate timer).

Johan
