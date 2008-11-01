Return-Path: <cyrus@holtmann.org>
Message-ID: <40aff9180810311704q7f7d1380rd7c80cda2f5fe47b@mail.gmail.com>
Date: Sat, 1 Nov 2008 01:04:09 +0100
From: Fiorellino <fiorellino@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: any TFM to read about BlueZ 4.x setup? (almost solved)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

and thanks a lot Sreevani.

Thanks to your hint I got much closer. I think now the pairing is
done, I just need to work on xorg.conf configuration to accept the
keyboard input. Now I see the led blinking when I press buttons, but
they don't seem to reach my X.

Anyway, some hints for future people in trouble like me. Sorry if some
steps are missing, but I didn't trace everything so I will use my
memory a lot.

My aim was to pair my wireless keyboard using just command line tools.
For some reason, using 3.xx the pairing was not asking me any PIN.

First, compile the main package (latest bluez-4.xx.tar.gz from
http://www.bluez.org/download/)

If you don't usually compile you need a lot of additional packages
(check README for a list of packages).

after compiling hciconfig will list your devices.

type hciconfig <yourdev> up (e.g. hciconfig hci0 up)

search for available devices: hcitool scan (remember to put your
device in discoverable mode)

so far so good... now it's were it got tricky for me. hcid (from bluez
3.xx) got renamed bluetoothd in bluez 4.xx ...

you can run it FOR NOW this way: bluetooth -nd for your tests...

then go in the test folder and run:

voyage:~/bluez-4.17/test# ./simple-agent hci0 00:18:00:00:78:86
(obviously this will be the HW address you got from hcitool scan)
RequestPinCode (/org/bluez/hci0/dev_00_18_00_00_78_86)
Enter PIN Code: 2233
Release
New device (/org/bluez/hci0/dev_00_18_00_00_78_86)

Again, if you don't have python you might need to install some stuff
(I needed python python-gtk2 python-dbus)

Is that simple... :)

Cheers,

alfonso

On Fri, Oct 31, 2008 at 11:46 AM, sreevani medhahal
<sreevani.medhahal@gmail.com> wrote:
> Hi,
>  Under the test folder in bluez. there is a python script
> simple-agent which allows to do pairing on the command line.
> format:./simple-agent hci0 <bd_addr>
>
> let me know if it doesnt work.
> Regards,
> Sreevani
>
> On Fri, Oct 31, 2008 at 3:10 PM, Fiorellino <fiorellino@gmail.com> wrote:
>> Hi there,
>>
>> http://wiki.bluez.org/wiki/HOWTO/Bonding refers to bluez-gnome
>> (graphical tool) and passkey-agent.c which is not any more in any
>> package (checked bluez-4.17.tar.gz bluez-gnome-1.8.tar.gz
>> bluez-firmware-1.2.tar.gz and bluez-hcidump-1.42.tar.gz).
>>
>> Is there any way to do pairing using command line tools?
>>
>> Can anyone please post an example of pure command line bonding / pairing?
>>
>> Thank you,
>>
>> alfonso
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
