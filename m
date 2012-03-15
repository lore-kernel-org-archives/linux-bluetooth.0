Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331836568.14217.131.camel@aeonflux>
References: <1331297862-28875-1-git-send-email-andre.guedes@openbossa.org>
	<1331297862-28875-2-git-send-email-andre.guedes@openbossa.org>
	<1331825216.14217.128.camel@aeonflux>
	<CACJA=fXuWL1XPcNDvTqnHvyXzSdjX_dMLfJZ+vi3Q4pe-my7YA@mail.gmail.com>
	<1331836568.14217.131.camel@aeonflux>
Date: Thu, 15 Mar 2012 16:04:18 -0300
Message-ID: <CACJA=fWHeO8YEAUvF-1Ro_EFkq_FwhRySy3mSQmTwnw=kYH2iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Mar 15, 2012 at 3:36 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
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
>> >> index daefaac..87bca3e 100644
>> >> --- a/include/net/bluetooth/hci_core.h
>> >> +++ b/include/net/bluetooth/hci_core.h
>> >> @@ -1071,5 +1071,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 len=
gth);
>> >> =A0int hci_cancel_inquiry(struct hci_dev *hdev);
>> >> =A0int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 w=
indow,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int timeout);
>> >> +int hci_cancel_le_scan(struct hci_dev *hdev);
>> >>
>> >> =A0#endif /* __HCI_CORE_H */
>> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> >> index 59ec99e..0320a02 100644
>> >> --- a/net/bluetooth/hci_core.c
>> >> +++ b/net/bluetooth/hci_core.c
>> >> @@ -1667,6 +1667,27 @@ static int hci_do_le_scan(struct hci_dev *hdev=
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
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EALREADY;
>> >> +
>> >> + =A0 =A0 canceled =3D cancel_delayed_work(&hdev->le_scan_disable);
>> >
>> > why are we using the canceled variable here? Seems pointless.
>>
>> Because le_scan_disable work may be running when cancel_delayed_work
>> returns (canceled =3D=3D 0). If le_scan_disable work is running, we shou=
ld
>> not send HCI_OP_LE_SET_SCAN_ENABLE command since le_scan_disable work
>> already sends it.
>
> I got that part, but I meant why using an extra variable here?
>
> =A0 =A0 =A0 =A0if (cancel_delayed_work(&hdev->le_scan_disable)) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
>
> =A0 =A0 =A0 =A0}

Oh, sorry, now I see your point.

> This is as clean and does exactly the same job. Or do I miss something
> here?

You're right, I'll remove the variable and send a new version.

Thanks,

Andre
