Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331148191.3392.185.camel@aeonflux>
References: <1331074474-12868-1-git-send-email-andre.guedes@openbossa.org>
	<1331074474-12868-2-git-send-email-andre.guedes@openbossa.org>
	<20120306230730.GA8386@joana>
	<CACJA=fXCBNMGvqWFUAHPi-XMaq6QFm=Lq3E8vdLOEucBavk2+g@mail.gmail.com>
	<1331148191.3392.185.camel@aeonflux>
Date: Wed, 7 Mar 2012 17:05:06 -0300
Message-ID: <CACJA=fVtgKyywx4O3u5w+wta5A6tJNp8hS1s+y+Q0i-ZtYUMKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Mar 7, 2012 at 4:23 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Andre,
>
>> > * Andre Guedes <andre.guedes@openbossa.org> [2012-03-06 19:54:33 -0300=
]:
>> >
>> >> This patch adds to hci_core the hci_cancel_le_scan function which
>> >> should be used to cancel an ongoing LE scan.
>> >>
>> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> >> ---
>> >> =A0include/net/bluetooth/hci_core.h | =A0 =A01 +
>> >> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 21 ++++++++++++++++=
+++++
>> >> =A02 files changed, 22 insertions(+)
>> >>
>> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
>> >> index 25cb0a1..0db2934 100644
>> >> --- a/include/net/bluetooth/hci_core.h
>> >> +++ b/include/net/bluetooth/hci_core.h
>> >> @@ -1072,5 +1072,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 len=
gth);
>> >> =A0int hci_cancel_inquiry(struct hci_dev *hdev);
>> >> =A0int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 w=
indow,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int timeout);
>> >> +int hci_cancel_le_scan(struct hci_dev *hdev);
>> >>
>> >> =A0#endif /* __HCI_CORE_H */
>> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> >> index 661d65f..0c2ceaa 100644
>> >> --- a/net/bluetooth/hci_core.c
>> >> +++ b/net/bluetooth/hci_core.c
>> >> @@ -1672,6 +1672,27 @@ static int hci_do_le_scan(struct hci_dev *hdev=
, u8 type, u16 interval,
>> >> =A0 =A0 =A0 return 0;
>> >> =A0}
>> >>
>> >> +int hci_cancel_le_scan(struct hci_dev *hdev)
>> >> +{
>> >> + =A0 =A0 bool canceled;
>> >> +
>> >> + =A0 =A0 BT_DBG("%s", hdev->name);
>> >> +
>> >> + =A0 =A0 if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
>> >
>> > Are you sure about this -EPERM return error here? At a glance -EALREAD=
Y looks
>> > better to me.
>>
>> This function cancels an operation (LE scan). If the operation is not
>> running, it makes more sense to me returning "Operation not permitted"
>> instead of "Operation already in progress".
>
> actually EPERM is for operation not permitted because you do not have
> rights to access is. Not because it is invalid operation.
>
> You need to find a better error code.

Ok, then, as Gustavo suggested, EALREADY looks really better.
Are you fine with EALREADY?

Andre
