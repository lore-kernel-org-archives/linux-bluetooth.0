Return-Path: <cyrus@holtmann.org>
Message-ID: <1331229212.14217.11.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 08 Mar 2012 09:53:32 -0800
In-Reply-To: <CACJA=fVtgKyywx4O3u5w+wta5A6tJNp8hS1s+y+Q0i-ZtYUMKA@mail.gmail.com>
References: <1331074474-12868-1-git-send-email-andre.guedes@openbossa.org>
	 <1331074474-12868-2-git-send-email-andre.guedes@openbossa.org>
	 <20120306230730.GA8386@joana>
	 <CACJA=fXCBNMGvqWFUAHPi-XMaq6QFm=Lq3E8vdLOEucBavk2+g@mail.gmail.com>
	 <1331148191.3392.185.camel@aeonflux>
	 <CACJA=fVtgKyywx4O3u5w+wta5A6tJNp8hS1s+y+Q0i-ZtYUMKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >> > * Andre Guedes <andre.guedes@openbossa.org> [2012-03-06 19:54:33 -0300]:
> >> >
> >> >> This patch adds to hci_core the hci_cancel_le_scan function which
> >> >> should be used to cancel an ongoing LE scan.
> >> >>
> >> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> >> ---
> >> >>  include/net/bluetooth/hci_core.h |    1 +
> >> >>  net/bluetooth/hci_core.c         |   21 +++++++++++++++++++++
> >> >>  2 files changed, 22 insertions(+)
> >> >>
> >> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> >> index 25cb0a1..0db2934 100644
> >> >> --- a/include/net/bluetooth/hci_core.h
> >> >> +++ b/include/net/bluetooth/hci_core.h
> >> >> @@ -1072,5 +1072,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> >> >>  int hci_cancel_inquiry(struct hci_dev *hdev);
> >> >>  int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> >> >>                                                               int timeout);
> >> >> +int hci_cancel_le_scan(struct hci_dev *hdev);
> >> >>
> >> >>  #endif /* __HCI_CORE_H */
> >> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> >> index 661d65f..0c2ceaa 100644
> >> >> --- a/net/bluetooth/hci_core.c
> >> >> +++ b/net/bluetooth/hci_core.c
> >> >> @@ -1672,6 +1672,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
> >> >>       return 0;
> >> >>  }
> >> >>
> >> >> +int hci_cancel_le_scan(struct hci_dev *hdev)
> >> >> +{
> >> >> +     bool canceled;
> >> >> +
> >> >> +     BT_DBG("%s", hdev->name);
> >> >> +
> >> >> +     if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> >> >> +             return -EPERM;
> >> >
> >> > Are you sure about this -EPERM return error here? At a glance -EALREADY looks
> >> > better to me.
> >>
> >> This function cancels an operation (LE scan). If the operation is not
> >> running, it makes more sense to me returning "Operation not permitted"
> >> instead of "Operation already in progress".
> >
> > actually EPERM is for operation not permitted because you do not have
> > rights to access is. Not because it is invalid operation.
> >
> > You need to find a better error code.
> 
> Ok, then, as Gustavo suggested, EALREADY looks really better.
> Are you fine with EALREADY?

seems fine to me.

Regards

Marcel


