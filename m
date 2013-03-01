Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Mar 2013 08:55:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 02/16] Bluetooth: Split HCI init sequence into three
 stages
Message-ID: <20130301065502.GA14811@x220.P-661HNU-F1>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
 <1361951844-13719-3-git-send-email-johan.hedberg@gmail.com>
 <06B5DEA7-BB85-48EB-80F5-F876C9C8F049@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06B5DEA7-BB85-48EB-80F5-F876C9C8F049@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 28, 2013, Marcel Holtmann wrote:
> > +static void hci_set_le_support(struct hci_dev *hdev)
> > +{
> > +	struct hci_cp_write_le_host_supported cp;
> > +
> > +	memset(&cp, 0, sizeof(cp));
> > +
> > +	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
> > +		cp.le = 1;
> > +		cp.simul = lmp_le_br_capable(hdev);
> > +	}
> 
> I fully realise that you just copied this code, but use 0x01 here
> instead of just 1 for variables inside HCI command structs.

Sure, I'll fix it for the next iteration of this set.

Johan
