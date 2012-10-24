Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 01:36:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Bluetooth: mgmt: Add support for switching to LE
 peripheral mode
Message-ID: <20121024223635.GA11976@x220.P-661HNU-F1>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
 <1351112996-9597-6-git-send-email-johan.hedberg@gmail.com>
 <20121024221341.GA22764@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121024221341.GA22764@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Oct 24, 2012, Vinicius Costa Gomes wrote:
> On 00:09 Thu 25 Oct, Johan Hedberg wrote:
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index dc60d31..ed6b1e2 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -790,9 +790,24 @@ static void hci_set_le_support(struct hci_dev *hdev)
> >  		cp.simul = !!lmp_le_br_capable(hdev);
> >  	}
> >  
> > +	/* If the host features don't reflect the desired state for LE
> > +	 * then send the write_le_host_supported command. The command
> > +	 * complete handler for it will take care of any necessary
> > +	 * subsequent commands like set_adv_enable.
> > +	 *
> > +	 * If the host features for LE are already correct and
> > +	 * peripheral mode is enabled directly send the le_set_adv
> > +	 * command. The value of &cp.le is used so that advertising will
> > +	 * not be enabled in the exceptional case that LE for some
> > +	 * reason isn't enabled - something that should only be possible
> > +	 * if someone is doing direct raw access to HCI.
> > +	 */
> >  	if (cp.le != !!lmp_host_le_capable(hdev))
> >  		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
> >  			     &cp);
> > +	else if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
> > +		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(cp.le),
> > +			     &cp.le);
> >  }
> 
> I agree with Marcel, and one point that worried me was this
> unconditional advertising, I feel that we should be smarter about when
> to start advertising, for example, here we are not taking into account
> the user's visiblity settings.

If you're a peripheral and you're not connectable/discoverable then what
good does it do to have Bluetooth enabled at all? Since a peripheral
can't scan or initiate connections you can't really do anything. So if a
higher layer doesn't want us advertising it could either set LE to off
or central role or even power off the adapter completely.

Johan
