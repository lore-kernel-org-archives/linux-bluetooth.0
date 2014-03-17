Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 17 Mar 2014 18:06:54 +0000
Message-ID: <CALdY0K7bMd=kX1zZ-XiZe58G-fZ1X8rHNdsp05cZ8RwSiUc08A@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Christian Bianchini <christian.bianchini@euservers.net>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I can try with your idea but if I continue to type commands to read
stuff, try to write, etc... the device doesn't disconnect. I guess
it's a timeout after I dont get or send any data, probably a
power-safe-mode.

i have bluez 4.101 :
ii  bluez                                       4.101-0ubuntu8b1
                 amd64        Bluetooth tools and daemons


What I dont get is that I can't write any parameters:
char-write-req a 0100
[CON][DC:7A:F8:10:AF:A5][LE]> Characteristic Write Request failed:
Attribute can't be written

I am following this guide to understand how a BLE device is made and
how to access specific information:
http://joost.damad.be/2013/08/experiments-with-bluetooth-low-energy.html

What I understood is that sending 0100 ( 0x01, 0x00 ) each
"functionality" ( that are 3 of them ) should send me a notification
of its status, but I am not able to write anything :(

As soon as I can write the data, I am sure I will have solved my
problem and I can read all the sensors!

Thanks again for your help

On Mon, Mar 17, 2014 at 5:50 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Christian,
>
> On Mon, Mar 17, 2014 at 12:30 PM, Christian Bianchini
> <christian.bianchini@euservers.net> wrote:
>> Tried to connect with bluez:
>> $ sudo bluez-simple-agent hci0 DC:7A:F8:10:AF:A5
>> Creating device failed: org.bluez.Error.ConnectionAttemptFailed: Page Timeout
>
> If you are using a 4.x BlueZ, you must run "test-discovery" until the
> device appears, and then attempt the simple-agent command above. This
> will feed an internal cache that allows BlueZ to know that this
> address is from a LE device, not a BR/EDR one. Since BlueZ 5.0, this
> is not necessary anymore.
>
> If this does not work, please post the output from hcidump when you
> run the "bluez-simple-agent" command.
>
>> Stupid question, how do I read the firmware version? Sorry to ask
>> silly questions but this my first attempt to use this kind of "AT
>> commands" via GATT
>
> Given that your connection is dropping after a few seconds, it is
> difficult to run commands on the gatttool prompt before fixing this
> connection timeout issue. Try running test-discovery + simple-agent as
> described above, and then try gatttool again and see if it stays
> connected.
>
>> Here is the dump:
>> [...]
>
> Unfortunately, the log only says your device is disconnecting due to
> "Connection Timeout". Are you getting this same error every time? And
> for how long the link stays up before disconnecting? (you can pass
> "-t" to hcidump to show the timestamp so you can measure easily).
>
> This error usually means there is a poor connection between your
> machine and the device, or that the device "disappeared" (i.e. became
> out of range). Is the device fully charged?
>
> Best Regards,
> --
> Anderson Lizardo
> http://www.indt.org/?lang=en
> INdT - Manaus - Brazil



-- 
---------------------------
Web/Mobile Developer
Luiis Group
christian@bianchini.ch
