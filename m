Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Use only 2 bits for controller type information
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_Ova_rzJy8pnO2VJRki7N=L=PEk=r=D5Zk1oPDkA=2mOA@mail.gmail.com>
Date: Mon, 30 Sep 2013 06:01:30 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <4C2644C5-D946-4CB6-AEF5-3948DC241BA6@holtmann.org>
References: <1380427749-14427-1-git-send-email-marcel@holtmann.org> <CAJdJm_Ova_rzJy8pnO2VJRki7N=L=PEk=r=D5Zk1oPDkA=2mOA@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> The controller type is limited to BR/EDR/LE and AMP controllers. This
>> can be easily encoded with just 2 bits and still leave enough room
>> for future controller types.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> net/bluetooth/hci_core.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 4549b5c..ebba5a6 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1610,7 +1610,7 @@ int hci_get_dev_info(void __user *arg)
>> 
>>        strcpy(di.name, hdev->name);
>>        di.bdaddr   = hdev->bdaddr;
>> -       di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
>> +       di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x30) << 4);
> 
> Shouldn't it be (hdev->dev_type & 0x03) here?

yes, this it should be 0x03 here. My mistake.

Regards

Marcel

