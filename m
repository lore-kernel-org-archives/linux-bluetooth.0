Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Keeping hci interface powered
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <FC3579EF-F5AF-4B28-9E70-97080FA6DD2C@holtmann.org>
Date: Mon, 26 Jan 2015 18:47:06 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D396E7CE-E288-4BEA-BEC9-CAF85A6825BB@holtmann.org>
References: <m3oaqfl79f.fsf@carbon.jhcloos.org> <D043D131-E9F8-43C1-8671-0EACAE810420@holtmann.org> <m361cklxwo.fsf@carbon.jhcloos.org> <C5CDA647-8415-44F3-9F89-0D596D76498F@holtmann.org> <m3zj9wkfsw.fsf@carbon.jhcloos.org> <FFFB52BA-6CC2-4E9E-ACA3-C3D2099BAA9B@holtmann.org> <m3tx04kat2.fsf@carbon.jhcloos.org> <FC3579EF-F5AF-4B28-9E70-97080FA6DD2C@holtmann.org>
To: James Cloos <cloos@jhcloos.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

> So the max_page value is 0, but it should be 1 for this controller. I think that is what is tripping up the command and not reading page 1. The page is clearly available as the other trace shows. And yes, the keyboard has Secure Simple Pairing enabled.

I got this keyboard now and the max_page value set to 0 is a clear bug with this keyboard. However, the kernel already works around this one. I did fix the command line userspace tools to include the same fix now.

>> MH> The LegacyPairing: no is not a 100% indication, but I assume your
>> MH> keyboard is actually a Bluetooth 2.1 keyboard with Secure Simple
>> MH> Pairing.
>>>> 
>> MH> Do you have an exact model number or link? We might have to buy one
>> MH> of these keyboards.
>>>> 
>>>> Lenovo's pages are:
>>>> 
>>>> http://shop.lenovo.com/us/en/itemdetails/0B47189/460/60AC6A0372B14F5BA7B12F1FF88E33C7
>>>> http://support.lenovo.com/en/documents/pd026744
>>>> 
>>>> I got that one to support my trackpoint addiction. :^/
>>>> 
>>>> Are there any good tech specs for bt available w/o cost?
>> 
>> MH> Can you capture a pairing procedure with your keyboard with btmon?
>> MH> Then I can tell what is actually going on between these two devices.
>> 
>> After unpairing, it refuses to re-pair at all.  So now no keyboard
>> whatsoever......
> 
> Most likely it has a button that you need to press or hold to make it forgot the current key.
> 
> And when in bluetoothctl, make sure you start an agent. That is the piece that will ask you for the passkey.

So I did a basic pairing with this keyboard and it works as expected. It has SSP enabled and it does proper keyboard input handling for the passphrase.

What I am thinking is that you initially pairing with Legacy Pairing and then switched on SSP later on. This confused the keyboard and it things to allow Legacy Pairing. However that is really not how this works in the end.

When you make sure to remove all pairings and re-pair the keyboard it should all work fine and the keyboard should re-establish the encryption before trying to open HID control and interrupt channels.

Regards

Marcel

