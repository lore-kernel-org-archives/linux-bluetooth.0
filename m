Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 13:44:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
Message-ID: <20131002104444.GB24910@x220.p-661hnu-f1>
References: <1380705040-16300-1-git-send-email-johan.hedberg@gmail.com>
 <1380705040-16300-2-git-send-email-johan.hedberg@gmail.com>
 <6F59A8FC-14F1-4982-9A9A-66F4A022E0B1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6F59A8FC-14F1-4982-9A9A-66F4A022E0B1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> > @@ -1493,6 +1500,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
> > 		goto done;
> > 	}
> > 
> > +	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
> > +		err = -ENOTSUPP;
> > +		goto done;
> > +	}
> > +
> 
> quick question, shouldn't these be EOPNOTSUPP.

Yes, we should, except for the hci_conn.c change. I've fixed this in the
latest set.

Johan
