Return-Path: <cyrus@holtmann.org>
Message-ID: <1361227295.1583.31.camel@aeonflux>
Subject: Re: [RFC v2 1/8] Bluetooth: Setup LE scan with no timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 18 Feb 2013 23:41:35 +0100
In-Reply-To: <CACJA=fVD_0z5o6D0L-1roj19GTaOCYiroAXEWWhXMY4tC5+1Xw@mail.gmail.com>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
	 <1360970828-24004-2-git-send-email-andre.guedes@openbossa.org>
	 <1361053591.1583.9.camel@aeonflux>
	 <CACJA=fVD_0z5o6D0L-1roj19GTaOCYiroAXEWWhXMY4tC5+1Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >> This patch modifies hci_do_le_scan and hci_cancel_le_scan helpers so
> >> we are able to start and stop LE scan with no timeout. This feature
> >> will be used by the LE connection routine.
> >>
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >>  net/bluetooth/hci_core.c | 17 +++++++++--------
> >>  1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 22e77a7..3aa0345 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -1618,26 +1618,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
> >>       if (err < 0)
> >>               return err;
> >>
> >> -     queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> >> -                        msecs_to_jiffies(timeout));
> >> +     if (timeout > 0)
> >> +             queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
> >> +                                msecs_to_jiffies(timeout));
> >>
> >>       return 0;
> >>  }
> >
> > I really do not like this magic handling of scan disable. Maybe you
> > better remove the timeout handling completely and put it into the
> > discovery functionality.
> >
> > Doing it like this seems pretty much hacked together. It no longer looks
> > like the right place to do handle it.
> 
> The le_scan_disable work should be scheduled only if LE scanning was
> started successfully.
> 
> So hci_do_le_scan seems to be a better place than discovery
> functionality for the timeout handling. Besides, these LE scan helpers
> were originally designed to provide a self-contained framework to
> start and stop LE scanning.
> 
> The framework lacks support for starting LE scanning with no timeout.
> This patch aims to address this issue.
> 
> Anyway, if you still think it is a good idea to remove this timeout
> handling, I'll remove it in the next series.

look into what Johan is working on with the transaction support. I am
getting the feeling that moving everything over to proper transaction
and not just trying it hack stuff in seems to be the right approach.

For example the actual discovery handling needs to be able to report
errors anyway. So that can be handled there.

Regards

Marcel


