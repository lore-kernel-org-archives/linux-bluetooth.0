Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 19:46:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/9] Bluetooth: mgmt: Fix New Settings event for
 connectable/discoverable
Message-ID: <20120221174600.GA7955@x220.P-661HNU-F1>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
 <1329840005-4977-6-git-send-email-johan.hedberg@gmail.com>
 <1329841303.2049.29.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329841303.2049.29.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 21, 2012, Marcel Holtmann wrote:
> >  	if (!hdev_is_powered(hdev)) {
> > +		bool changed = false;
> > +
> >  		if (cp->val) {
> > +			if (!test_and_set_bit(HCI_DISCOVERABLE,
> > +							&hdev->dev_flags))
> > +				changed = true;
> >  			set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
> > -			set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
> > -		} else
> > -			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
> > +		} else {
> > +			if (test_and_clear_bit(HCI_DISCOVERABLE,
> > +							&hdev->dev_flags))
> > +				changed = true;
> > +		}
> > +
> 
> does it really need to be this complicated? If we remove the set_bit for
> CONNECTABLE, then we can just send this one out. Since we know that
> something changed.

Since we don't treat trying to change a setting to a value it already
has as an error it's not guaranteed that there will always be a change
in settings. Therefore, we do always need to send the cmd_complete but
not always the new_settings event. In the new set of patches I sent I've
simplified this logic a bit but the check is still there.

Johan
