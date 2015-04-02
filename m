Return-Path: <cyrus@holtmann.org>
Message-ID: <551D12CD.4080705@gmail.com>
Date: Thu, 02 Apr 2015 11:58:37 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Arman Uguray <armansito@chromium.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: How to get the hci_dev from an adv instance's work struct in
 a linked list?
References: <551CA5BC.5040307@gmail.com> <CAHrH25Tq4cQhiaGu7HnTu1ep1XNd85UJJr-FbcGnyx5c9W9Evw@mail.gmail.com>
In-Reply-To: <CAHrH25Tq4cQhiaGu7HnTu1ep1XNd85UJJr-FbcGnyx5c9W9Evw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

it's impressive how responsive you are on this list here. Really cool. :-)

 >> I got quite far today refactoring from
>>
>> struct hci_dev { ... struct adv_info adv_instance; ... };
>>
>> to
>>
>> struct hci_dev { ... struct list_head adv_instances; ... };
>>
>> But in the end I got stuck on refactoring the adv timeout callback.
>> Originally it looked like this:
>>
>> static void adv_timeout_expired(struct work_struct *work)
>> {
>>    struct hci_dev *hdev = container_of(work, struct hci_dev,
>>                                        adv_instance.timeout_exp.work);
>>    ...
>> }
>>
>> But now I would have to construct a pointer to the hci_dev struct from a
>> list entry:
>>
>> static void adv_timeout_expired(struct work_struct *work)
>> {
>>    struct adv_info *adv_instance = container_of(work, struct adv_info,
>>                                                 timeout_exp.work);
>>    ...
>> }
>>
>> I couldn't find a way to get the list head of the adv info list entry so
>> that I could retrieve its containing hci_dev structure, though.
>>
>
> Once simple solution is to add a struct hci_dev pointer to struct
> adv_info. Once you get the pointer to the instance then you can obtain
> the hci_dev pointer that way.

Yes, that's an obvious solution albeit it's a bit ugly as it introduces 
extra redundancy. I thought of it, too, but I hoped I could avoid it. 
Maybe I can solve it like that for now and then we see whether another 
solution emerges once we got the refactored code in front of us.

Florian
