Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110621205505.GA8124@dell.ger.corp.intel.com>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
	<20110621205505.GA8124@dell.ger.corp.intel.com>
Date: Wed, 22 Jun 2011 13:40:24 -0300
Message-ID: <BANLkTimFRq621hQqHZgAvEiEAEYi05ruYg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Add extfeatures to struct hci_dev
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Jun 21, 2011 at 6:27 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Since the extended features command is only available from 1.2 onwards I
> don't think it's right to unconditionally send it in hci_init_req.
> Instead, you should probably be checking for the feature bit in the
> (non-extended) feature mask, i.e. in the command complete callback for
> HCI_Read_Local_Features and only send the command if the feature bit is
> set.

Ok, I'll check the extended features flag.

Thanks,

Andre.
