Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Thangella, Pruthvidhar" <pthangel@qca.qualcomm.com>,
	"marcin.kraglak@tieto.com" <marcin.kraglak@tieto.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: Add setup callback for chip init
 on USB
Date: Mon, 23 Feb 2015 02:56:19 +0000
Message-ID: <F76256A0-F007-4034-83D3-154C12BB5D6E@qca.qualcomm.com>
References: <ed9be4d986c749d7a0b35a335184a932@nalasexr02e.na.qualcomm.com>,<5F078510-AE2E-4790-99CA-21AC7ECC0FBE@holtmann.org>
In-Reply-To: <5F078510-AE2E-4790-99CA-21AC7ECC0FBE@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Feb 23, 2015, at 11:36 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
>=20
> Hi Ben,
>=20
>> Some of chipset does not allow to send a patch or config files through
>> HCI VS channel at early stage as well as they don't support to send
>> USB patch files to other channel except USB bulk path.
>>=20
>> New callback added is for initialization of BT controller through USB
>>=20
>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>> ---
>> drivers/bluetooth/btusb.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
>>=20
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 3ca2e1b..73e1066 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -337,6 +337,8 @@ struct btusb_data {
>>=20
>>    int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
>>    int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
>> +
>> +    int (*setup_on_usb)(struct hci_dev *hdev);
>=20
> I am trying to come up with a better callback name here. _on_usb is kind =
of a duplicate information. Since it is a USB driver. My problem is that I =
have not come up with a great name for the callback yet.
>> };
>>=20
>> static inline void btusb_free_frags(struct btusb_data *data)
>> @@ -878,6 +880,15 @@ static int btusb_open(struct hci_dev *hdev)
>>=20
>>    BT_DBG("%s", hdev->name);
>>=20
>> +    /* Patching USB firmware files prior to starting any URBs of HCI pa=
th
>> +     * It is more safe to use USB bulk channel for downloading USB patc=
h
>> +     */
>=20
> While you would be using it for firmware patching, it is a bit more gener=
ic. So the comment should be a bit more generic as well.
>=20

I'm okay to change better callback name here and update comments with more =
general. It would be appreciated let us know once merging changes.

>> +    if (data->setup_on_usb) {
>> +        err =3D data->setup_on_usb(hdev);
>> +        if (err <0)
>> +            return err;
>> +    }
>> +
>=20
> Regards
>=20
> Marcel
>=20

Thanks
Ben Kim=
