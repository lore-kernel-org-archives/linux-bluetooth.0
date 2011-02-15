Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <52BC896C-93BF-41F2-BC11-9D3FCBE3EFE7@gmail.com>
From: Justin Mattock <justinmattock@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20110215135245.GA11561@jh-x301>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: bluetooth disabled with current 2.6.38-rc4
Date: Tue, 15 Feb 2011 08:20:28 -0800
References: <1A8743E5-65EA-4625-82FD-658C9722629F@gmail.com> <20110215135245.GA11561@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Feb 15, 2011, at 5:52 AM, Johan Hedberg wrote:

> Hi Justin,
>
> On Sun, Feb 13, 2011, Justin Mattock wrote:
>> maybe I missed something, but my bluetooth is just not functioning  
>> with
>> 2.6.38-rc4(works with 2.6.37-rc4)
>>
>> I've done a bisect on this, but was pointed to:
>> c0e45c1ca3162acb2e77b3d9e152ce6e7b6fa3f5
>> but doesn't look correct to me
>>
>> here is what I am seeing with the bluetooth-applet etc..:
>>
>> working correctly:
>> http://www.flickr.com/photos/44066293@N08/5443727238/
>>
>> not working:
>> http://www.flickr.com/photos/44066293@N08/5443124859/
>>
>> my /var/log/daemon.log shows:
>>
>> Feb 13 17:12:22 Linux-2 acpid: 1 client rule loaded
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: HCI dev 0 registered
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: Listening for HCI events
>> on hci0
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: HCI dev 0 up
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: Unable to find matching
>> adapter
>>
>> I can try at another bisect, but might take some time.. let me know
>> if there is something I can test
>> or do.
>
> Are you sure this is a kernel problem? There was a similar issue with
> BlueZ 4.86 or 4.87 which was already fixed. Could you try with 4.88?
>
> Johan


yeah Ill give the latest a try(currently using 4.82)

Justin P. Mattock
