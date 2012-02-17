Return-Path: <cyrus@holtmann.org>
Message-ID: <1329468528.28848.139.camel@aeonflux>
Subject: Re: [RFC 4/4] Bluetooth: Interleaved discovery support
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:48:48 +0100
In-Reply-To: <CACJA=fV3-GvzLd3WKGDRwO7q06rQ8j+3ts9Vo8GTiE_0T42XwA@mail.gmail.com>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	 <1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
	 <20120216221213.GA3889@x220.ger.corp.intel.com>
	 <CACJA=fV3-GvzLd3WKGDRwO7q06rQ8j+3ts9Vo8GTiE_0T42XwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> > On Thu, Feb 16, 2012, Andre Guedes wrote:
> >>  #define INQUIRY_LEN_BREDR            0x08    /* TGAP(100) */
> >> +#define INQUIRY_LEN_BREDR_LE         0x04    /* TGAP(100)/2 */
> >> +
> >>
> >>  #define SERVICE_CACHE_TIMEOUT (5 * 1000)
> >
> > One unnecessary empty line added above.
> 
> Thanks, I'll fix it.
> 
> >> +int mgmt_interleaved_discovery(struct hci_dev *hdev)
> >> +{
> >> +     int err;
> >> +
> >> +     BT_DBG("%s", hdev->name);
> >> +
> >> +     err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
> >> +     if (err < 0) {
> >> +             hci_dev_lock(hdev);
> >> +             hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >> +             hci_dev_unlock(hdev);
> >> +     }
> >> +
> >> +     return err;
> >> +}
> >
> > The locking doesn't look right to me above. hci_do_inquiry should be
> > called with the lock held. I think it might be simpler if you make
> > mgmt_interleaved_discovery() require the caller to hold the lock.
> 
> Yes, you're right. I just realized hci_do_inquiry now calls inquiry_
> cache_flush which requires hdev->lock held. I'll fix this too. Thanks.

please keep the lock inside mgmt_interleaved_discovery() for now. We
have enough locking crazy. I don't wanna add to it by making the caller
deal with it right now.

Otherwise looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


