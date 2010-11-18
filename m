Return-Path: <cyrus@holtmann.org>
Message-ID: <4CE48602.1000009@gmx.net>
Date: Thu, 18 Nov 2010 02:48:50 +0100
From: Andre Kuehne <andre.kuehne@gmx.net>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Apple Wireless Keyboard connection issue
References: <20101116212701.50060@gmx.net> <20101117013009.GA15855@vigoh> <20101117090534.GA11494@jh-x301> <4CE45F63.7030902@gmx.net> <20101117222751.GA20735@jh-x301>
In-Reply-To: <20101117222751.GA20735@jh-x301>
Content-Type: multipart/mixed;
 boundary="------------050109060402080401040809"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050109060402080401040809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

On 11/17/2010 11:27 PM, Johan Hedberg wrote:
> Hi,
>
> On Thu, Nov 18, 2010, Andre Kuehne wrote:
>> On 11/17/2010 10:05 AM, Johan Hedberg wrote:
>>> On Tue, Nov 16, 2010, Gustavo F. Padovan wrote:
>>>> * "André Kühne"<andre.kuehne@gmx.net>   [2010-11-16 22:27:01 +0100]:
>>>>> I noticed the following on my system: After upgrading to bluez-4.79
>>>>> connecting my Apple Wireless Keyboard does not work anymore. With
>>>>> bluez-4.77 the connection works just fine.
>>>>
>>>> My Microsoft keyboard is not working too. That is probably due to commit
>>>> abe7cd44124a from Johan. It should be fixed soon.
>>>
>>> The only real difference that patch makes is the reuse of the HCI socket
>>> inside hciops.c. Maybe that screws up the event filters somehow or
>>> something similar. I don't have a keyboard to verify a fix, but could
>>> you try the attached patch and see if it helps?
>>>
>> I installed
>>
>>    http://www.kernel.org/pub/linux/bluetooth/bluez-4.79.tar.gz + hciops_encrypt.patch
>>
>> but the patch does not work for me. For verification I downloaded
>>
>>    http://www.kernel.org/pub/linux/bluetooth/bluez-4.77.tar.gz
>>
>> and compiled/installed it the same way (without the patch) and the connection works.
>>
>> I did the same using bluez-4.78 with the result that both my keyboard and mouse failed to connect.
>
> Ok, so then it seems like abe7cd44124a might not be to blame. Could you
> do a proper git bisect so we can figure out exactly at which point this
> broke. abe7cd44124a is really the only commit touching HID code since
> 4.77 so this is starting to get a bit strange.
>
> Johan
>
Please find attached my bisect results.

Best regards
Andre

--------------050109060402080401040809
Content-Type: text/plain;
 name="bluez-bisect.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bluez-bisect.txt"

> git bisect good
a352058752e541539b09e55124d411a534cc14af is the first bad commit
commit a352058752e541539b09e55124d411a534cc14af
Author: Johan Hedberg <johan.hedberg@nokia.com>
Date:   Thu Nov 4 04:38:35 2010 +0200

    Cache adapter address for quick lookup

:040000 040000 b7b14eb9f69c0b74ebda87b2fa40a4574f08be44 b96739e2d58fcc5a5c6654431ba49a36ee623932 M	plugins

> git bisect log
git bisect start
# good: [b079cca768419d11e011cc5a7d59bc802226e633] Release 4.77
git bisect good b079cca768419d11e011cc5a7d59bc802226e633
# bad: [018c5b71748c178dcd2ffb0164c1d975788a2acc] Release 4.78
git bisect bad 018c5b71748c178dcd2ffb0164c1d975788a2acc
# good: [d5d0fa3be8f7a20d128dcbaf8fc529c38bc52395] Optimize device disconnect callback processing
git bisect good d5d0fa3be8f7a20d128dcbaf8fc529c38bc52395
# good: [b67a8a42e6ea9c2d2b0877ac3832de75ec4e00e5] Fix bdaddr naming consistency
git bisect good b67a8a42e6ea9c2d2b0877ac3832de75ec4e00e5
# bad: [5295b6a0ab0ad67a27926273a3fbf61f02663219] Fix not ignoring case of uuid given to RegisterEndpoint
git bisect bad 5295b6a0ab0ad67a27926273a3fbf61f02663219
# good: [db5266f0afedc33e2fd6fc3601c16498865f746d] Remove redundant tracking of ignored adapters
git bisect good db5266f0afedc33e2fd6fc3601c16498865f746d
# bad: [a352058752e541539b09e55124d411a534cc14af] Cache adapter address for quick lookup
git bisect bad a352058752e541539b09e55124d411a534cc14af
# good: [b289e54d53c332a51be483c1660a42c267991dd3] Remove redundant hci_devinfo call
git bisect good b289e54d53c332a51be483c1660a42c267991dd3

--------------050109060402080401040809--
