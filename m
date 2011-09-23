Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 11/14] Bluetooth: Report LE devices
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1316522972.1937.89.camel@aeonflux>
Date: Fri, 23 Sep 2011 16:15:28 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98B2D1F6-DC66-4FE4-910E-D73B32578909@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org> <1316468136-12472-12-git-send-email-andre.guedes@openbossa.org> <1316522972.1937.89.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 20, 2011, at 9:49 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> Devices found during LE scan should be reported to userspace through
>> mgmt_device_found events.
>>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_event.c |   10 ++++++++++
>> 1 files changed, 10 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index f097649..166f8fa 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2830,6 +2830,7 @@ static inline void hci_le_adv_report_evt(struct =
hci_dev *hdev,
>> {
>> 	struct hci_ev_le_advertising_info *ev;
>> 	u8 num_reports;
>> +	s8 rssi;
>>=20
>> 	num_reports =3D skb->data[0];
>> 	ev =3D (void *) &skb->data[1];
>> @@ -2838,9 +2839,18 @@ static inline void =
hci_le_adv_report_evt(struct hci_dev *hdev,
>>=20
>> 	hci_add_adv_entry(hdev, ev);
>>=20
>> +	rssi =3D ev->data[ev->length];
>> +	mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, ev->data,
>> +								=
ev->length);
>> +
>> 	while (--num_reports) {
>> 		ev =3D (void *) (ev->data + ev->length + 1);
>> +
>> 		hci_add_adv_entry(hdev, ev);
>> +
>> +		rssi =3D ev->data[ev->length];
>> +		mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, =
ev->data,
>> +								=
ev->length);
>> 	}
>=20
> any reason we are treating the first entry different than the =
potential
> other ones? This code looks too complex to me. And we have to repeat =
the
> same calls which easily leads to typos.

There is no special reason unless it was the easiest implementation
when this function was created. But as long as new stuff are added
to this function things may become a bit ugly.

I'll do some code refactoring in hci_le_adv_report_evt() and send it
as a separated patch.

BR,

Andre=
