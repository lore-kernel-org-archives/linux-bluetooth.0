Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 10:40:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for entering limited discoverable
 mode
Message-ID: <20131015074037.GA28346@x220.p-661hnu-f1>
References: <1381792099-8732-1-git-send-email-marcel@holtmann.org>
 <20131015073157.GA24495@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131015073157.GA24495@x220.p-661hnu-f1>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 15, 2013, Johan Hedberg wrote:
> On Mon, Oct 14, 2013, Marcel Holtmann wrote:
> > +	if (cp->val) {
> > +		struct hci_cp_write_current_iac_lap cp;
> > +
> > +		if (timeout > 0) {
> > +			/* Limited discoverable mode */
> 
> Wouldn't we want to follow the recommendation from the Core spec here,
> volume 3, part C, section 4.1.2.1:
> 
> "A Bluetooth device should not be in limited discoverable mode for more than
> TGAP(104)"
> 
> TGAP(104) in turn is defined as 1 minute (vol 3, part C, Appendix A).

We might even want to limit this to 30 seconds so the same can be used
for LE once this is hooked up to advertising:

TGAP(lim_adv_timeout)	30.72s	Maximum time to remain		Required value
				advertising when in the
				limited discoverable mode

Johan
