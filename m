Return-Path: <cyrus@holtmann.org>
Message-ID: <4962C9D0.1030005@dtsp.co.nz>
Date: Tue, 06 Jan 2009 16:02:40 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Khem Raj <raj.khem@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [patch] hid2hci check usb_init return value
References: <20081225231444.GA23751@gmail.com>	 <1230552751.15666.17.camel@californication>	 <20081230062656.GA31902@gmail.com> <1231210468.13304.20.camel@californication>
In-Reply-To: <1231210468.13304.20.camel@californication>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
>> What you have is libusb-0.1 which has older API I suppose. There is 
>> libusb-compat which can be used as a wrapper over libusb1 to give
>> libusb0 like interfaces. 
>>
>> Actually I was using libusb-1.0.0 API as mentioned here
>> http://libusb.sourceforge.net/api-1.0/group__lib.html
>> that also means that the patch I attached should have been using
>> libusb_init() instead. 
>>
>> Here is updated patch
>>     
>
> this still breaks with a system that has libusb-0.1 installed like the
> current Ubuntu 8.10 does. So either we switch to libusb-1.0 completely
> or we leave it as it is.
>   

This looks like a job for autoconf?
