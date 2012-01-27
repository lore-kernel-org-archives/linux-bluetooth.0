Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NEgtqkbfyDy7OXRoA6U_7WoX5OiZjYF1Bofr6YSW=BgA@mail.gmail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	<1327679246-2667-3-git-send-email-dh.herrmann@googlemail.com>
	<CAJdJm_NEgtqkbfyDy7OXRoA6U_7WoX5OiZjYF1Bofr6YSW=BgA@mail.gmail.com>
Date: Fri, 27 Jan 2012 17:56:50 +0100
Message-ID: <CANq1E4TnqmTE31sA859FJPEuWRoW0mNy_Rb9zPpNhWc-=4mbjg@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Remove hci_dev->driver_data
From: David Herrmann <dh.herrmann@googlemail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson

On Fri, Jan 27, 2012 at 5:51 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi David,
>
> On Fri, Jan 27, 2012 at 11:47 AM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_=
main.c
>> index 66b58fd..8d0e090 100644
>> --- a/drivers/bluetooth/btmrvl_main.c
>> +++ b/drivers/bluetooth/btmrvl_main.c
>> @@ -394,12 +394,12 @@ static int btmrvl_send_frame(struct sk_buff *skb)
>>
>> =A0 =A0 =A0 =A0BT_DBG("type=3D%d, len=3D%d", skb->pkt_type, skb->len);
>>
>> - =A0 =A0 =A0 if (!hdev || !hdev->driver_data) {
>> + =A0 =A0 =A0 priv =3D hci_get_drvdata(hdev);
>> + =A0 =A0 =A0 if (!hdev || !priv) {
>
> The change above will cause problems if hdev is NULL.
> hci_get_drvdata() dereferences hdev without checking for NULL.

Thanks for reviewing. I will resend it without the check for !priv. It
doesn't make sense to check this. It can never be NULL, anyway.

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BT_ERR("Frame for unknown HCI device");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 priv =3D (struct btmrvl_private *) hdev->driver_data;
>> =A0 =A0 =A0 =A0if (!test_bit(HCI_RUNNING, &hdev->flags)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BT_ERR("Failed testing HCI_RUNING, flags=
=3D%lx", hdev->flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_hex_dump_bytes("data: ", DUMP_PREFI=
X_OFFSET,
> [...]
>> @@ -614,6 +613,16 @@ static inline struct hci_dev *hci_dev_hold(struct h=
ci_dev *d)
>>
>> =A0#define to_hci_dev(d) container_of(d, struct hci_dev, dev)
>>
>> +static inline void *hci_get_drvdata(struct hci_dev *hdev)
>> +{
>> + =A0 =A0 =A0 return dev_get_drvdata(&hdev->dev);
>> +}
>> +
>> +static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
>> +{
>> + =A0 =A0 =A0 dev_set_drvdata(&hdev->dev, data);
>> +}
>> +
>> =A0struct hci_dev *hci_dev_get(int index);
>> =A0struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
>
> Regards,

Regards
David
