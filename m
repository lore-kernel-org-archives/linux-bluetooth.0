Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Feb 2014 19:32:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix advertising address type when toggling
 connectable
Message-ID: <20140225173242.GA4779@localhost.P-661HNU-F1>
References: <1393333842-8380-1-git-send-email-johan.hedberg@gmail.com>
 <1393333842-8380-2-git-send-email-johan.hedberg@gmail.com>
 <84898D84-C149-4ABE-8CFE-55FB2E261CF6@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84898D84-C149-4ABE-8CFE-55FB2E261CF6@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 25, 2014, Marcel Holtmann wrote:
> > -	bool require_privacy;
> > +	bool connectable, require_privacy;
> > 
> > -	require_privacy = !test_bit(HCI_CONNECTABLE, &hdev->dev_flags);
> > +	connectable = get_connectable(hdev);
> > +	require_privacy = !connectable;
> > 
> > 	if (hci_update_random_address(req, require_privacy, &own_addr_type) < 0)
> > 		return;
> 
> can we use a comment here to explain require_privacy like we do with
> the other time it is used. the two variables are too much. And then
> call it like this ..address(req, !connectable, &own..).

Sure. v2 coming in a few minutes.

Johan
