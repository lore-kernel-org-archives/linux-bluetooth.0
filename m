Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2] net: bluetooth: hci_sock: Use 'const void *' instead of 'void *' for 2nd parameter of hci_test_bit()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54D27D68.7040501@cogentembedded.com>
Date: Wed, 4 Feb 2015 13:09:47 -0800
Cc: David Laight <David.Laight@ACULAB.COM>,
	Chen Gang S <gang.chen@sunrus.com.cn>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <0AB99BEA-C379-439C-AD80-5F2122AE37E5@holtmann.org>
References: <54CFE8BE.5030700@sunrus.com.cn> <063D6719AE5E284EB5DD2968C1650D6D1CADA5E1@AcuExch.aculab.com> <54D27D68.7040501@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sergei,

>>> -static inline int hci_test_bit(int nr, void *addr)
>>> +static inline int hci_test_bit(int nr, const void *addr)
>>>  {
>>>  	return *((__u32 *) addr + (nr >> 5)) & ((__u32) 1 << (nr & 31));
>>>  }
> 
>> Is there a 'standard' function lurking that will do the above.
>> On x86 the cpus 'bit test' instruction will handle bit numbers
>> greater than the word size - so it can be a single instruction.
> 
>   Of course, there's test_bit().

we did leave hci_test_bit in the code since there are some userspace facing API that we can not change. Remember that the origin of this code is from 2.4.6 kernel.

So we can only change this if you can ensure not to break the userspace API. So might want to write unit tests to ensure working HCI filter before even considering touching this.

Regards

Marcel

