Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <112A7600-CE46-4467-B45E-38FC61B90920@holtmann.org>
References: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
	<1362783979-10142-4-git-send-email-andre.guedes@openbossa.org>
	<112A7600-CE46-4467-B45E-38FC61B90920@holtmann.org>
Date: Mon, 11 Mar 2013 14:25:12 -0300
Message-ID: <CACJA=fUvNoUcB-2zDaba9tT2Cd7fQHZerE67HTejOX1Gi8_=QA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] Bluetooth: Remove timeout handling from hci_cancel_le_scan
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 8, 2013 at 10:28 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This patch moves the LE scanning timeout handling from hci_cancel_
>> le_scan helper to stop_discovery.
>>
>> Since we want discovery code handling LE scanning timeout, we should
>> handle it in stop_discovery instead of hci_cancel_le_scan.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> net/bluetooth/hci_core.c | 14 +++++---------
>> net/bluetooth/mgmt.c     | 15 ++++++++++++---
>> 2 files changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 59f583b..200ec5a 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1905,20 +1905,16 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
>>
>> int hci_cancel_le_scan(struct hci_dev *hdev)
>> {
>> +     struct hci_cp_le_set_scan_enable cp;
>> +
>>       BT_DBG("%s", hdev->name);
>>
>>       if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>>               return -EALREADY;
>>
>> -     if (cancel_delayed_work(&hdev->le_scan_disable)) {
>> -             struct hci_cp_le_set_scan_enable cp;
>> -
>> -             /* Send HCI command to disable LE Scan */
>> -             memset(&cp, 0, sizeof(cp));
>> -             hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>> -     }
>> -
>> -     return 0;
>> +     /* Send HCI command to disable LE Scan */
>> +     memset(&cp, 0, sizeof(cp));
>> +     return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>> }
>
> so we have HCI request framework now and we keep using hci_send_cmd without checking if it fails or succeeds. I don't really think so. This needs to be done as a HCI request as well.
>
> If you want a convenience helper for a single command with a complete callback, then please add that one, but sending commands where the error is not handling from hci_event.c is not acceptable.

I'll fix this and use hci request here instead.

Regards,

Andre
