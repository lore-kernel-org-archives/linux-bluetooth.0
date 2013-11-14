Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Adapter name reset on suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1384421473.2229.1.camel@nuvo>
Date: Thu, 14 Nov 2013 23:33:18 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B8394ACD-FBC2-49AD-A470-99FAAE72C86A@holtmann.org>
References: <1384350278.5071.6.camel@nuvo> <130CE89B-A508-4FB9-B7EA-35D500742EC1@holtmann.org> <1384421473.2229.1.camel@nuvo>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

>>> After suspending and resuming my laptop, hci0's name is reset to what
>>> looks like the factory name:
>>> $ hciconfig -a | grep Name
>>> 	Name: 'BCM20702A'
>>> 
>>> This is the device in question:
>>> Bus 001 Device 004: ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0 [ThinkPad]
>>> 
>>> And my laptop is a Lenovo X1 Carbon.
>>> 
>>> Neither udevadm nor btmon show the device going away on suspend and
>>> coming back on resume.
>> 
>> can you start btmon, call hciconfig hci0 name, then suspend, then
>> resume, call hciconfig hci0 name again.
> 
> Bluetooth monitor ver 5.10
> = New Index: F4:B7:E2:E8:99:E2 (BR/EDR,USB,hci0)                   [hci0] 0.176335
> < HCI Command: Read Local Name (0x03|0x0014) plen 0                [hci0] 9.797930
>> HCI Event: Command Complete (0x0e) plen 252                      [hci0] 9.813834
>      Read Local Name (0x03|0x0014) ncmd 1
>        Status: Success (0x00)
>        Name: nuvo
> < HCI Command: Read Local Name (0x03|0x0014) plen 0               [hci0] 33.109166
>> HCI Event: Command Complete (0x0e) plen 252                     [hci0] 33.125157
>      Read Local Name (0x03|0x0014) ncmd 1
>        Status: Success (0x00)
>        Name: BCM20702A
> 
>> I am wondering if for some reason the suspend/resume actually does a
>> HCI Reset without telling us. The name normally only gets reset to
>> BCM20702A when doing a full reset.
> 
> Looks like that's what it's doing.
> 
>> Another possibility is that we actually forgot to set it in the first
>> place. I am pretty sure I have intensively tested and that should not
>> happen, but you might just found a corner case.
> 
> It's set on a normal boot, it seems to be reset only when suspending.

I have no idea on how to fix this at the moment. The problem is actually that this kind of behavior with a silent HCI reset will break remote wakeup.

Regards

Marcel

