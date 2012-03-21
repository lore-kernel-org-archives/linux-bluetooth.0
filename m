Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332258822.1870.17.camel@aeonflux>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
	<1332210772-13806-3-git-send-email-aguedespe@gmail.com>
	<1332258822.1870.17.camel@aeonflux>
Date: Tue, 20 Mar 2012 23:21:41 -0300
Message-ID: <CAG6x5o3Q87j4zQ+-5YqpPMnR96vy0a19oj7q1dnvVGhgeW1ksw@mail.gmail.com>
Subject: Re: [RFC 2/4] Bluetooth: Add HCI_PINQUIRY to dev_flags
From: Andre Guedes <aguedespe@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 20, 2012 at 12:53 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Andre,
>
>> This patch adds the HCI_PINQUIRY flag to dev_flags. This flag tracks
>> if periodic inquiry is enabled or not.
>>
>> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
>> ---
>> =A0include/net/bluetooth/hci.h | =A0 =A01 +
>> =A0net/bluetooth/hci_event.c =A0 | =A0 10 +++++++++-
>> =A02 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index d74645e..b3e89bf 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -102,6 +102,7 @@ enum {
>> =A0 =A0 =A0 HCI_DISCOVERABLE,
>> =A0 =A0 =A0 HCI_LINK_SECURITY,
>> =A0 =A0 =A0 HCI_PENDING_CLASS,
>> + =A0 =A0 HCI_PINQUIRY,
>
> call this HCI_PERIODIC_INQ. Since PINQUIRY is horrible to distinguish
> from INQUIRY.

Ok, I'll rename it.

>> =A0};
>>
>> =A0/* HCI ioctl defines */
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index af0c5a2..4d13843 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -75,6 +75,11 @@ static void hci_cc_periodic_inq(struct hci_dev *hdev,=
 struct sk_buff *skb)
>> =A0 =A0 =A0 __u8 status =3D *((__u8 *) skb->data);
>>
>> =A0 =A0 =A0 BT_DBG("%s status 0x%x", hdev->name, status);
>> +
>> + =A0 =A0 if (status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 set_bit(HCI_PINQUIRY, &hdev->dev_flags);
>> =A0}
>>
>> =A0static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_=
buff *skb)
>> @@ -86,6 +91,8 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *h=
dev, struct sk_buff *skb)
>> =A0 =A0 =A0 if (status)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 clear_bit(HCI_PINQUIRY, &hdev->dev_flags);
>> +
>> =A0 =A0 =A0 hci_conn_check_pending(hdev);
>> =A0}
>>
>> @@ -200,7 +207,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struc=
t sk_buff *skb)
>> =A0 =A0 =A0 hci_req_complete(hdev, HCI_OP_RESET, status);
>>
>> =A0 =A0 =A0 /* Reset all non-persistent flags */
>> - =A0 =A0 hdev->dev_flags &=3D ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLAS=
S));
>> + =A0 =A0 hdev->dev_flags &=3D ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLAS=
S) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(HCI_PINQUIRY));
>
> And as homework for another patch, we should have a simple mask define
> for persistent or non-persistent flags that is defined right next to the
> enum. This will otherwise get out of control.
>
>>
>> =A0 =A0 =A0 hdev->discovery.state =3D DISCOVERY_STOPPED;
>> =A0}
>
> Other than the flag name change, this looks fine.
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

I'm gonna rename the flag, fix subsequent patches and send a new
version of this series as PATCH.

BR,

Andre
