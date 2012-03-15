Return-Path: <cyrus@holtmann.org>
Message-ID: <1331836568.14217.131.camel@aeonflux>
Subject: Re: [PATCH v2 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Mar 2012 11:36:08 -0700
In-Reply-To: <CACJA=fXuWL1XPcNDvTqnHvyXzSdjX_dMLfJZ+vi3Q4pe-my7YA@mail.gmail.com>
References: <1331297862-28875-1-git-send-email-andre.guedes@openbossa.org>
	 <1331297862-28875-2-git-send-email-andre.guedes@openbossa.org>
	 <1331825216.14217.128.camel@aeonflux>
	 <CACJA=fXuWL1XPcNDvTqnHvyXzSdjX_dMLfJZ+vi3Q4pe-my7YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >> This patch adds to hci_core the hci_cancel_le_scan function which
> >> should be used to cancel an ongoing LE scan.
> >>
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >>  include/net/bluetooth/hci_core.h |    1 +
> >>  net/bluetooth/hci_core.c         |   21 +++++++++++++++++++++
> >>  2 files changed, 22 insertions(+)
> >>
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> index daefaac..87bca3e 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -1071,5 +1071,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> >>  int hci_cancel_inquiry(struct hci_dev *hdev);
> >>  int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> >>               int timeout);
> >> +int hci_cancel_le_scan(struct hci_dev *hdev);
> >>
> >>  #endif /* __HCI_CORE_H */
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 59ec99e..0320a02 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -1667,6 +1667,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
> >>       return 0;
> >>  }
> >>
> >> +int hci_cancel_le_scan(struct hci_dev *hdev)
> >> +{
> >> +     bool canceled;
> >> +
> >> +     BT_DBG("%s", hdev->name);
> >> +
> >> +     if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> >> +             return -EALREADY;
> >> +
> >> +     canceled = cancel_delayed_work(&hdev->le_scan_disable);
> >
> > why are we using the canceled variable here? Seems pointless.
> 
> Because le_scan_disable work may be running when cancel_delayed_work
> returns (canceled == 0). If le_scan_disable work is running, we should
> not send HCI_OP_LE_SET_SCAN_ENABLE command since le_scan_disable work
> already sends it.

I got that part, but I meant why using an extra variable here?

	if (cancel_delayed_work(&hdev->le_scan_disable)) {

		...

	}

This is as clean and does exactly the same job. Or do I miss something
here?

Regards

Marcel


