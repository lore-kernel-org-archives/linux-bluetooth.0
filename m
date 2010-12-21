Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4] Bluetooth: Fix __hci_request synchronization for
 hci_open_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20101221150258.GA25824@jh-x301>
References: <1292590111-6564-1-git-send-email-johan.hedberg@gmail.com>
	 <1292942802.2658.49.camel@aeonflux>  <20101221150258.GA25824@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Dec 2010 07:06:06 -0800
Message-ID: <1292943966.2658.50.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > And actually hci_init_req is not the only function where you would need
> > to add hdev->req_last_cmd entries. There are hci_reset_req and some
> > others. Without that, the rest of your patch makes hci_req_complete a
> > non functional operation.
> 
> Actually no, if req_last_cmd is 0 (which it is in all cases except
> hci_init_req) then the comparison is not done:
> 
> > +	if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
> > +		return;
> 
> I did this to keep the patch simple and to not have to change all the
> single HCI command cases. I.e. only multi-HCI command requests need to
> set this variable.

not a huge fan of this, but if you put a comment on top then I could be
convinced ;)

Regards

Marcel


