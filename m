Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Mar 2013 09:32:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 13/16] Bluetooth: Fix busy condition testing for EIR
 and class updates
Message-ID: <20130301073232.GC14811@x220.P-661HNU-F1>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
 <1361951844-13719-14-git-send-email-johan.hedberg@gmail.com>
 <DCADC53A-261F-4CF0-A1CB-34DD7A49CA77@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCADC53A-261F-4CF0-A1CB-34DD7A49CA77@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 28, 2013, Marcel Holtmann wrote:
> > +static bool pending_eir_or_class(struct hci_dev *hdev)
> > +{
> > +	struct pending_cmd *cmd;
> > +
> > +	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> > +		switch (cmd->opcode) {
> > +		case MGMT_OP_ADD_UUID:
> > +		case MGMT_OP_REMOVE_UUID:
> > +		case MGMT_OP_SET_DEV_CLASS:
> > +		case MGMT_OP_SET_POWERED:
> > +			return true;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> 
> I do not like this at all. Why would we do it like this?
> 
> The transaction framework should allow us to just process these one at
> a time. So even if userspace send 20 add_uuid commands at the same
> time, we would deal with them one after the other.
> 
> What I am trying to understand what is the benefit of returning busy
> here.

If we have multiple commands/transactions in the queue wanting to send
the same HCI commands the problem is that the content of each HCI
command (the CoD or EIR data) should depend on the content of the
preceding HCI commands. The current EIR data or CoD (as stored in hdev
variables) depends on the last completed write HCI command for the data.
When we decide whether another command needs to be sent we compare what
we want to send based on what the current value is and not what it will
be (based on what's already in the queue).

Another problem is the handling of HCI command complete events for the
same HCI commands. We don't know which pending mgmt command should be
indicated as completed since there's no tight coupling of HCI commands
and the mgmt commands that triggered them.

Since we strictly speaking don't need to send all those write_eir or
write_cod commands in the queue but just the very last one (since that's
what ultimately takes effect once everything is complete) we could in
principle go digging into the queue and remove any earlier duplicates of
the same HCI command and reply mgmt_cmd_complete for all pending
commands when this one single HCI command completes. This is a bit messy
for several reasons. One is that we still need to ensure that the
complete callbacks for the transactions/commands we removed still get
called. Another is that this will result in some quite interesting
behavior:

	1. Call add_uuid
	2. Call remove_uuid with the same uuid as in 1.
	3. The HCI command from 2. completes (the one from 1. was
	replaced).
	4. Success is returned for both mgmt commands when in fact the
	UUID added in 1 never got added in reality.

Considering the fact that we queue up all commands anyway I don't really
have such a strong opinion on whether we allow potentially messed up
behavior when such queuing doesn't happen, but the above is at least an
attempt at explaining why I added this busy check.

One possible solution I can think of is that we update the CoD or EIR
value in hdev as soon as we create a HCI command to update the value, as
opposed to updating the hdev value when the HCI command completes. This
would allow us to have sensible checks on whether new HCI commands need
to be queued or not. We'd then have to have some flag to indicate that
there are pending EIR or CoD commands so that any of these mgmt commands
don't return a direct cmd_complete just because it looks like everything
is fine based on the CoD/EIR values in hdev.

Johan
