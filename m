Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 13:44:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/3] Bluetooth: Add a new mgmt_set_bredr command
Message-ID: <20131002104403.GA24910@x220.p-661hnu-f1>
References: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com>
 <1380640922-18647-4-git-send-email-johan.hedberg@gmail.com>
 <20131002070736.GB15884@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131002070736.GB15884@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 02, 2013, Andrei Emeltchenko wrote:
> On Tue, Oct 01, 2013 at 06:22:02PM +0300, johan.hedberg@gmail.com wrote:
> > From: Johan Hedberg <johan.hedberg@intel.com>
> > 
> > This patch introduces a new mgmt command for enabling/disabling BR/EDR
> > functionality. This can be convenient when one wants to make a dual-mode
> > controller behave like a single-mode one. The command is only available
> > for dual-mode controllers and requires that LE is enabled before using
> > it.
> 
> ...
> 
> > +
> > +	if (cp->val != 0x00 && cp->val != 0x01)
> > +		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
> > +				  MGMT_STATUS_INVALID_PARAMS);
> > +
> > +	hci_dev_lock(hdev);
> > +
> > +	val = !!cp->val;
> 
> You have already checked that cp->val is 0x0 or 0x1, right?

Good point (this was inherited from code that I copied it from). I've
removed both val and enabled in my latest set.

Johan
