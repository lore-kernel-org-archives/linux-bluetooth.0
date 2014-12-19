Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Dec 2014 12:13:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: Fix Add Device to wait for HCI before
 sending cmd_complete
Message-ID: <20141219101329.GA17821@t440s.lan>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
 <1418981017-10462-5-git-send-email-johan.hedberg@gmail.com>
 <C462E3B8-977F-4E80-A4C1-86C213B020F2@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C462E3B8-977F-4E80-A4C1-86C213B020F2@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 19, 2014, Marcel Holtmann wrote:
> > +	err = hci_req_run(&req, add_device_complete);
> > +	if (err < 0) {
> > +		if (err == -ENODATA) {
> > +			cmd->cmd_complete(cmd, MGMT_STATUS_SUCCESS);
> > +			err = 0;
> > +		}
> > +		mgmt_pending_remove(cmd);
> > +	}
> 
> But this command should also work when the controller is powered down.
> Who is doing these checks now?

That's covered by the ENODATA check. hci_update_background_scan() bails
out without doing anything if the hdev is powered off, leaving the
hci_request empty.

Johan
