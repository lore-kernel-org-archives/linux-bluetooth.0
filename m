Return-Path: <cyrus@holtmann.org>
Message-ID: <48FD397F.2020101@dtsp.co.nz>
Date: Tue, 21 Oct 2008 15:07:59 +1300
From: David Sainty <David.Sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
CC: linux-bluetooth@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
	rbrito@ime.usp.br
Subject: Re: [Bugme-new] [Bug 11779] New: No way to disable bluetooth
References: <bug-11779-10286@http.bugzilla.kernel.org/> <20081020172426.4e28ba79.akpm@linux-foundation.org>
In-Reply-To: <20081020172426.4e28ba79.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Andrew Morton wrote:
>> http://bugzilla.kernel.org/show_bug.cgi?id=11779
>>
>> According to the manual, under Windows Vista (which is what came with
>> the box, but which I never used), this button is supposed to cycle
>> between 4 states:
>>
>> * both disabled;
>> * bluetooth enabled & wifi enabled;
>> * bluetooth disabled & wifi enabled;
>> * bluetooth enabled & wifi disabled.
>>
>> Unfortunately, under Linux (tested with Ubuntu's 8.10 pre-releases,
>> which includes a kernel based on 2.6.27-rc*, if I understand it
>> correctly), it is all or nothing: both disabled or both enabled.
>>
>> If I launch powertop, it recommends to disable bluetooth with
>> "hciconfig hci down; rmmod hci_usb", but the led of bluetooth is still
>> lit and I fear that the device is still drawing power from the battery.
>> (Actually, it seems that the modules for bluetooth go renamed also).
>>
>>     
If the LED is on, it's obviously drawing at least enough power to light 
the LED :)

>> Is there any way to get it to disable completely the device?
>>
>>     

This is a guess, but probably turning it on and off has nothing to do 
with the bluetooth support, it's probably intended to be powered on and 
off through ACPI or something - it's probably very specific to that 
particular laptop.

However, "hciconfig hci down" should at least minimise any drain the 
device is causing.
