Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110713202128.GD23921@joana>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
	<1310418719-12296-2-git-send-email-andre.guedes@openbossa.org>
	<20110713202128.GD23921@joana>
Date: Thu, 14 Jul 2011 11:28:41 -0300
Message-ID: <CACJA=fVqr3DTAUXCrc2Kd+Ce6dOiX+HB6z_1f6jJEGVtawe0Xw@mail.gmail.com>
Subject: Re: [PATCH 01/16] Bluetooth: Periodic Inquiry and mgmt discovering event
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jul 13, 2011 at 5:21 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>> @@ -1340,13 +1335,16 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
>>
>>       BT_DBG("%s status %d", hdev->name, status);
>>
>> -     if (test_bit(HCI_MGMT, &hdev->flags) &&
>> -                             test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
>> -             mgmt_discovering(hdev->id, 0);
>> +     hci_conn_check_pending(hdev);
>> +
>> +     if (!test_bit(HCI_INQUIRY, &hdev->flags))
>> +             return;
>> +
>> +     clear_bit(HCI_INQUIRY, &hdev->flags);
>
> this can be test_and_clear_bit

Yes, I could have done like this. However it would be replaced by
test_bit and clear_bit anyway later on patch 03/16.

Andre
