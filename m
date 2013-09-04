Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130904130832.GA23776@x220.p-661hnu-f1>
References: <CANq1E4ThsLwpWKs2VR+2DT41cDfV+_XX+DdLDF7Yo+Sm+t1ryw@mail.gmail.com>
	<20130904130832.GA23776@x220.p-661hnu-f1>
Date: Wed, 4 Sep 2013 15:25:46 +0200
Message-ID: <CANq1E4TZPY2vHXuwNEaHm1OuDwsbzQ=u_-zWvopnnUq5jXdQjA@mail.gmail.com>
Subject: Re: [BUG bluetoothd] reconnecting input devices results in org.bluez.Error.NotAvailable
From: David Herrmann <dh.herrmann@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Wed, Sep 4, 2013 at 3:08 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi David,
>
> On Wed, Sep 04, 2013, David Herrmann wrote:
>> I run the following commands in bluetoothctl on bluez-5.7-1 (but I
>> know this bug since I started using bluetoothctl (probably 5.0 or
>> 5.1), just didn't get around reporting it, yet. Sorry.):
>>   [bluetooth]# power on
>>     [CHG] Controller 00:25:00:50:C4:C9 Class: 0x00010c
>>     Changing power on succeeded
>>     [CHG] Controller 00:25:00:50:C4:C9 Powered: yes
>>   [bluetooth]# connect 00:1E:35:3B:7E:6D
>>     Attempting to connect to 00:1E:35:3B:7E:6D
>>     Connection successful
>>     [CHG] Device 00:1E:35:3B:7E:6D Connected: yes
>>
>> Works just fine. Then I disconnect the device by removing its
>> batteries. bluez notices this and removes the connection:
>>     [CHG] Device 00:1E:35:3B:7E:6D Connected: no
>>
>> However, a following connect always fails immediately:
>>   [bluetooth]# connect 00:1E:35:3B:7E:6D
>>     Attempting to connect to 00:1E:35:3B:7E:6D
>>     Failed to connect: org.bluez.Error.NotAvailable
>>
>> Any following commands, whether "connect" or "info" on the given
>> device result in:
>>   [bluetooth]# info  00:1E:35:3B:7E:6D
>>     Device  00:1E:35:3B:7E:6D not available
>>
>> power off -> power on doesn't help. I need to restart bluetoothd to
>> make it work again. The related debug log is appended below. Any hints
>> where to start debugging is welcome.
>>
>> I tested this with two HIDP devices.
>
> I fixed a few issues like this for 5.8. Could you try with that (or even
> better with latest git) before we proceed further with this.

Hm, I finally got up reporting this issue and then you fix it few days
earlier. Ahh... Sorry for not testing -git before. I thought it was
broken for several releases, so I didn't have to.

Just for the reference: fixed with bluez-git
Didn't do any bisect, though. Might be even fixed with 5.8.

Sorry for the noise, Thanks
David
