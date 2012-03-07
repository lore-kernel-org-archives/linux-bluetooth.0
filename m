Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120306230730.GA8386@joana>
References: <1331074474-12868-1-git-send-email-andre.guedes@openbossa.org>
	<1331074474-12868-2-git-send-email-andre.guedes@openbossa.org>
	<20120306230730.GA8386@joana>
Date: Wed, 7 Mar 2012 09:54:57 -0300
Message-ID: <CACJA=fXCBNMGvqWFUAHPi-XMaq6QFm=Lq3E8vdLOEucBavk2+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add hci_cancel_le_scan() to hci_core
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Mar 6, 2012 at 8:07 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> Hi Andre,
>
> * Andre Guedes <andre.guedes@openbossa.org> [2012-03-06 19:54:33 -0300]:
>
>> This patch adds to hci_core the hci_cancel_le_scan function which
>> should be used to cancel an ongoing LE scan.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  include/net/bluetooth/hci_core.h |    1 +
>>  net/bluetooth/hci_core.c         |   21 +++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 25cb0a1..0db2934 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1072,5 +1072,6 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>>  int hci_cancel_inquiry(struct hci_dev *hdev);
>>  int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>>                                                               int timeout);
>> +int hci_cancel_le_scan(struct hci_dev *hdev);
>>
>>  #endif /* __HCI_CORE_H */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 661d65f..0c2ceaa 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1672,6 +1672,27 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
>>       return 0;
>>  }
>>
>> +int hci_cancel_le_scan(struct hci_dev *hdev)
>> +{
>> +     bool canceled;
>> +
>> +     BT_DBG("%s", hdev->name);
>> +
>> +     if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +             return -EPERM;
>
> Are you sure about this -EPERM return error here? At a glance -EALREADY looks
> better to me.

This function cancels an operation (LE scan). If the operation is not
running, it makes more sense to me returning "Operation not permitted"
instead of "Operation already in progress".

BR,

Andre
