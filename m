Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 01 May 2017 14:50:19 -0400 (EDT)
Message-Id: <20170501.145019.1619484787513762409.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2017-04-30
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170501184221.GA2093@x1c>
References: <20170430140928.GA2753@x1c>
        <20170430.230336.142225761153252889.davem@davemloft.net>
        <20170501184221.GA2093@x1c>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Mon, 1 May 2017 21:42:21 +0300

> Hi Dave,
> 
> On Sun, Apr 30, 2017, David Miller wrote:
>> From: Johan Hedberg <johan.hedberg@gmail.com>
>> Date: Sun, 30 Apr 2017 17:09:28 +0300
>> 
>> > Here's one last batch of Bluetooth patches in the bluetooth-next tree
>> > targeting the 4.12 kernel.
>> > 
>> >  - Remove custom ECDH implementation and use new KPP API instead
>> >  - Add protocol checks to hci_ldisc
>> >  - Add module license to HCI UART Nokia H4+ driver
>> >  - Minor fix for 32bit user space - 64 bit kernel combination
>> > 
>> > Please let me know if there are any issues pulling. Thanks.
>> 
>> Pulled, thanks Johan.
> 
> Thanks, however I don't see the patches in net-next yet. I have seen
> other patches go in there since your response though. Cause for concern?

Shuld be there now.
