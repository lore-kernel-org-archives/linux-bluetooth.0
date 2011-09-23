Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 09/14] Bluetooth: Send mgmt_discovering events
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1316522725.1937.87.camel@aeonflux>
Date: Fri, 23 Sep 2011 16:15:04 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <62CA6A50-8246-4345-97E4-478478537198@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org> <1316468136-12472-10-git-send-email-andre.guedes@openbossa.org> <1316522725.1937.87.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sep 20, 2011, at 9:45 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_event.c |    4 ++++
>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index c9d641b..47abba4 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -897,12 +897,16 @@ static void hci_cc_le_set_scan_enable(struct =
hci_dev *hdev,
>> 		return;
>>=20
>> 	if (cp->enable =3D=3D 0x01) {
>> +		mgmt_discovering(hdev->id, 1);
>> +
>> 		del_timer(&hdev->adv_timer);
>>=20
>> 		hci_dev_lock(hdev);
>> 		hci_adv_entries_clear(hdev);
>> 		hci_dev_unlock(hdev);
>> 	} else if (cp->enable =3D=3D 0x00) {
>> +		mgmt_discovering(hdev->id, 0);
>> +
>=20
> do we wanna send discovering on/off for BR/EDR and then again for LE.
> Don't we wanna have something like this:
>=20
> 	discovering on
> 	BR/EDR inquiry
> 	LE scan
> 	discovering off

Yes, we have exactly this.

Notice that at this point (patch 09/14) we don't have BR/EDR/LE
discovery supported yet. We are preparing for support LE-Only
discovery. In a further patch we implement BR/EDR/LE discovery
support and do the proper handling for mgmt_discovering event
(see patch 14/14).

BR,

Andre=
