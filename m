Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Mar 2013 10:39:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 13/16] Bluetooth: Fix busy condition testing for EIR
 and class updates
Message-ID: <20130301083902.GA17957@x220.P-661HNU-F1>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
 <1361951844-13719-14-git-send-email-johan.hedberg@gmail.com>
 <DCADC53A-261F-4CF0-A1CB-34DD7A49CA77@holtmann.org>
 <20130301073232.GC14811@x220.P-661HNU-F1>
 <022948B2-E98F-4815-85BF-5227D65B2E71@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <022948B2-E98F-4815-85BF-5227D65B2E71@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 01, 2013, Marcel Holtmann wrote:
> > One possible solution I can think of is that we update the CoD or EIR
> > value in hdev as soon as we create a HCI command to update the value, as
> > opposed to updating the hdev value when the HCI command completes. This
> > would allow us to have sensible checks on whether new HCI commands need
> > to be queued or not. We'd then have to have some flag to indicate that
> > there are pending EIR or CoD commands so that any of these mgmt commands
> > don't return a direct cmd_complete just because it looks like everything
> > is fine based on the CoD/EIR values in hdev.
> 
> I see the dilemma now. Still not liking it that much. I wonder if we
> should just force one command of each opcode present at all time. No
> special handling for any of them. If you send the same opcode twice
> before it returned, you get busy error.

That still doesn't completely solve the issue since what we have is not
just the same command conflicting against another pending instance of
itself but several different commands conflicting against each other
(since they all can cause changes to the CoD or EIR).

Johan
