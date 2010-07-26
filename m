Return-Path: <cyrus@holtmann.org>
Message-ID: <4C4D2AD8.8060005@Atheros.com>
Date: Mon, 26 Jul 2010 11:57:36 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] Bluetooth: Provide access to reassembled Rx packets
References: <1280124157-16693-1-git-send-email-suraj@atheros.com> <1280124788.2621.37.camel@localhost.localdomain>
In-Reply-To: <1280124788.2621.37.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 7/26/2010 11:43 AM, Marcel Holtmann wrote:
> Hi Suraj,
>
>> Provide the HCI transport driver access to reassembled Rx packets before
>> sending to Host.
>>
>> Signed-off-by: Suraj Sumangala<suraj@atheros.com>
>> ---
>>   include/net/bluetooth/hci_core.h |    1 +
>>   net/bluetooth/hci_core.c         |    4 ++++
>>   2 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 350b3e6..769530b 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -156,6 +156,7 @@ struct hci_dev {
>>   	int (*close)(struct hci_dev *hdev);
>>   	int (*flush)(struct hci_dev *hdev);
>>   	int (*send)(struct sk_buff *skb);
>> +	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);
>
> besides the fact that skb->dev == hdev, why would be doing something
> like this? This is highly inefficient.
The idea was to provide the driver access the hci_dev structure.
Yes, as long as we have "skb->dev == hdev", called should be able to 
extract it from the skbuff.
>
> Regards
>
> Marcel
>

Regards
Suraj
