Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 00:26:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/7] Bluetooth: Add support for setting LE advertising
 data
Message-ID: <20121023212637.GA17404@x220.ger.corp.intel.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
 <1351011241-32515-5-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_MhB79eQSAHUqOa7Xwf+ujrnQZtG_jqEgMfEFzuoqB9-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_MhB79eQSAHUqOa7Xwf+ujrnQZtG_jqEgMfEFzuoqB9-w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 23, 2012, Anderson Lizardo wrote:
> On Tue, Oct 23, 2012 at 12:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > +       if (hdev->adv_tx_power) {
> > +               ptr[0] = 2;
> > +               ptr[1] = EIR_TX_POWER;
> > +               ptr[2] = (u8) hdev->adv_tx_power;
> > +
> > +               ad_len += 3;
> > +               ptr += 3;
> > +       }
> 
> 0dBm is a valid TX power. Not sure the if() clause is valid here.

If it's not, we'd need to extend the storage size of hdev->adv_tx_power
(to have some invalid value) or add another variable to hdev to indicate
that we know the tx_power. FWIW, create_eir also uses the same test for
including the inq_tx_power, so either both or neither should be fixed.
For simplicity I'd just keep the 0-test unless 0 is a really common
value.

> Also, I'm worried how we are going to put other advertising data here,
> i.e. Manufacturer Specific data or Service Data. On last BlueZ meeting
> we proposed (and have been implementing) the Set Controller Data mgmt
> command to set them. Is this still an acceptable approach?

Yes, though we only have 31 bytes to play with here which is quite
little. Also, we might want to make this dependent on the LE GAP role.
E.g. we might be more interested in manufacturer specific data for
broadcaster role than for peripheral role (maybe a user space
application *only* wants its data for broadcaster role).

Johan
