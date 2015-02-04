Return-Path: <cyrus@holtmann.org>
Message-ID: <54D27D68.7040501@cogentembedded.com>
Date: Wed, 04 Feb 2015 23:13:28 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 'Chen Gang S' <gang.chen@sunrus.com.cn>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "gustavo@padovan.org" <gustavo@padovan.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: bluetooth: hci_sock: Use 'const void *' instead
 of 'void *' for 2nd parameter of hci_test_bit()
References: <54CFE8BE.5030700@sunrus.com.cn> <063D6719AE5E284EB5DD2968C1650D6D1CADA5E1@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CADA5E1@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

On 02/04/2015 02:59 PM, David Laight wrote:

>> -static inline int hci_test_bit(int nr, void *addr)
>> +static inline int hci_test_bit(int nr, const void *addr)
>>   {
>>   	return *((__u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
>>   }

> Is there a 'standard' function lurking that will do the above.
> On x86 the cpus 'bit test' instruction will handle bit numbers
> greater than the word size - so it can be a single instruction.

    Of course, there's test_bit().

> 	David

WBR, Sergei
