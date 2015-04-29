Return-Path: <cyrus@holtmann.org>
Message-ID: <5540CCA7.2020305@gmail.com>
Date: Wed, 29 Apr 2015 14:20:55 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Arman Uguray <armansito@chromium.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_core: Introduce multi-adv inst
 list
References: <20150409094913.GB10676@t440s.lan>	<1428633041-18415-1-git-send-email-fgrandel@gmail.com>	<1428633041-18415-2-git-send-email-fgrandel@gmail.com> <CAHrH25S6iCxuThBz0ZtKRu7PpoZkBjTHsFEU+NBozaNFJVyPqA@mail.gmail.com>
In-Reply-To: <CAHrH25S6iCxuThBz0ZtKRu7PpoZkBjTHsFEU+NBozaNFJVyPqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

answers to your questions below:

 >> @@ -374,6 +377,8 @@ struct hci_dev {
>>          __u8                    scan_rsp_data_len;
>>
>>          struct adv_info         adv_instance;
>
> Is this still needed?

I leave this variable in the first patch and remove it in the second to 
get smaller patches without breaking the build. Is this ok?

>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 476709b..1859e67 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2613,6 +2613,119 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>          return 0;
>>   }
>>
>> +struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance)
>> +{
>
> Doesn't this require a lock as well?

Good catch, I actually found an instance where I called this method 
before locking hdev. Fixed.

>> +       struct adv_info *adv_instance;
>> +
>> +       list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
>> +               if (adv_instance->instance != instance)
>> +                       continue;
>> +               return adv_instance;
Florian
