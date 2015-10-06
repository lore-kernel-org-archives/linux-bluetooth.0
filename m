Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with small
 transfers"
To: Greg KH <gregkh@linuxfoundation.org>, andriy.shevchenko@linux.intel.com
References: <1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
 <20151006135503.GA13250@kroah.com>
Cc: linux-serial@vger.kernel.org, peter@hurleysoftware.com,
 linux-bluetooth@vger.kernel.org, heikki.krogerus@linux.intel.com,
 marcel@holtmann.org
From: Frederic Danis <frederic.danis@linux.intel.com>
Message-ID: <5613D968.7000505@linux.intel.com>
Date: Tue, 6 Oct 2015 16:23:36 +0200
MIME-Version: 1.0
In-Reply-To: <20151006135503.GA13250@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Greg,

On 06/10/2015 15:55, Greg KH wrote:
> On Tue, Oct 06, 2015 at 03:08:40PM +0200, Frederic Danis wrote:
>> This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.
>>
>> This commit prevents from sending "big" file using Bluetooth.
>> When sending a lot of data quickly through the Bluetooth interface, and
>> after a variable amount of data sent, transfer fails with error:
>>      kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
>>
>> Found on T100TA.
>>
>> After reverting this commit, send works fine for any file size.
>>
>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> v2: Re-send to correct people
>>
>>   drivers/tty/serial/8250/8250_dma.c | 4 ----
>>   1 file changed, 4 deletions(-)
>
> Andy, any objections?
>
> Frederic, don't you want to see this backported to 4.0 and newer?

Yes, you're right, unless Andy has any objection this should be good

Regards

Fred
