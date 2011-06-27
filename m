Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Message-ID: <44c0c13.6e1d3014b80fb8f0331e4275187e6b1d@1oca1host.de>
From: thilo@cestona.ro
To: linux-bluetooth@vger.kernel.org
Subject: Re: Support for 0489:e031 Foxconn / Hon Hai
Date: Mon, 27 Jun 2011 16:57:35 +0200 (CEST)
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey again,

>>As Virtualbox does a direct usb passthrough to the client I could install the bluetooth adapter in windows with the original broadcom bluetooth driver.
>>Once I opened the settings there and "saved" theses, the adapter finds bluetooth devices nicely under windows AND linux.
>>
>>Sadly I have no idea what the broadcom driver did to "activate" the adapter.
>
>So, after a reboot the adapter is back in it's "no I don't want to do anything"-Mode and I have to activate it again via windows.
>
>stop bluetooth daemon
>unload btusb
>boot windows VM with attached Bluetooth Device (boot til the login is visible, is enough)
>dettach BD from Windows
>load btusb
>start bluetooth daemon
>
>Now I can use the adapter as usual. 
>So there is definitley some initalization going on in the windows driver.
>
>Any ideas how I can get more information whats going on during boot? Or is disassembling the windows driver the only way?
>

I still have no idea how I might figure out what is done during the init of the windows driver. Since I need to unload the btusb module so windows can use the device, I have no chance to use hcidump.
Any ideas what I should try?

Ciao
 Thilo


