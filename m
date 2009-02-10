Return-Path: <cyrus@holtmann.org>
Message-ID: <499189F6.7010305@powercraft.nl>
Date: Tue, 10 Feb 2009 15:06:46 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote Control still does not make input event, what
 part of the driver is driver missing?
References: <49750C60.4090001@powercraft.nl> <1232982561.3330.3777.camel@cookie.hadess.net>
In-Reply-To: <1232982561.3330.3777.camel@cookie.hadess.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Tue, 2009-01-20 at 00:27 +0100, Jelle de Jong wrote:
>> Hi all,
>>
>> I thought I gave my Sony PS3 Bluetooth remote an other try, see all my
>> previous messages trials and bug reports back in the mail archive.
>>
>> The device still does not create an input event that can be used out of
>> the box. What parts are missing to get this working?
> 
> modprobe uinput?
> 
>> The device connects with the gnome bluetooth tool, you see the connect
>> icon go on very short then the connect icons goes away. hcitool con also
>> does not show the device and there is no input event created.
>>
>> What is going on here? And what need to be done here.
> 

Hi Bastien,

I did some more testing and loaded the uinput module, put the device
in pairing/connecting mode, then started bluetooth-applet. Connected
the device and stil NO input device is created and uninput is not used.

$ lsmod | grep uinput
uinput                  6592  0

Could somebody show me any prove that it is possible to create an
input device with the Sony BD Remote Control? A list of the below
command for the device would be nice to.

evtest /dev/input/eventX

Thanks in advance,

Jelle


