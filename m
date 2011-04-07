Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix unconditional call to mgmt interface in hci_event.c
Date: Thu, 7 Apr 2011 08:26:36 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "par-gunnar.p.hjalmdahl@stericsson.com" <par-gunnar.p.hjalmdahl@stericsson.com>,
 "henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1302087740-18244-1-git-send-email-szymon.janc@tieto.com> <1302098907.2572.174.camel@aeonflux>
In-Reply-To: <1302098907.2572.174.camel@aeonflux>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201104070826.36505.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,

Hi Marcel,

> please just exit the function if flag is not set:
> 
> 	if (!test_bit(...))
> 		return
> 
> > -	mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
> > +	if (test_bit(HCI_MGMT, &hdev->flags))
> > +		mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
> >  						rp->randomizer, rp->status);
> >  }

Other hci_cc_*_reply functions do
    if (test_bit(..))
        mgmt_call();

I'd prefer to keep the same convention for all of them.

BR,
Szymon Janc
