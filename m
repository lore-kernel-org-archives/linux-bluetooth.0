Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201002082106.06301.edt@aei.ca>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
	 <87vdebfvfk.fsf@troilus.org>
	 <1265392303.31341.235.camel@localhost.localdomain>
	 <201002082106.06301.edt@aei.ca>
Date: Mon, 8 Feb 2010 23:22:40 -0800
Message-ID: <dd18b0c31002082322m4238a4a6m73fc30752ba30447@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Keep a copy of each HID device's report
	descriptor.
From: Justin Mattock <justinmattock@gmail.com>
To: Ed Tomlinson <edt@aei.ca>
Cc: Marcel Holtmann <marcel@holtmann.org>, Michael Poole <mdpoole@troilus.org>,
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jkosina@suse.cz>, "Gunn, Brian" <bgunn@solekai.com>,
	Ping <pinglinux@gmail.com>, linux-kernel@vger.kernel.org,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

> TIA
> Ed Tomlinson
>
> On Friday 05 February 2010 12:51:43 Marcel Holtmann wrote:
>> Hi Michael,
>>
>> > > looks good to me. I just prefer that you do the allocation of the re=
port
>> > > descriptor before the HID object:
>> >
>> > An updated patch is below. =A0Sorry for the delay -- inclement weather
>> > here got in the way of testing this as quickly as I would have liked.
>> >
>> > From e245ef87247f5e257db40c412af7991c9af375ab Mon Sep 17 00:00:00 2001
>> > From: Michael Poole <mdpoole@troilus.org>
>> > Date: Fri, 5 Feb 2010 12:21:38 -0500
>> > Subject: [PATCH] Bluetooth: Keep a copy of each HID device's report de=
scriptor.
>> >
>> > The report descriptor is read by user space (via the Service
>> > Discovery Protocol), so it is only available during the ioctl
>> > to connect. =A0However, the probe function that needs the
>> > descriptor might not be called until a specific module is
>> > loaded. =A0Keep a copy of the descriptor so it is available for
>> > later use.
>>
>> patch has been applied. Thanks.
>>
>> Regards
>>
>> Marcel
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/


> Hi,
>
> I have been trying to test Michael's magic mouse drivers against 32.7 (or=
 .8-rc).   Is there a tree
> based on .32 with these patches?  If not would it be possible to post the=
 patches to lkml?  I do not
> mind sorting out a few conflicts - this thread assume one knows a little =
more about the process being
> used here than is obvious.
>


just got one of those magic things as well.
I did apply the patchs to the current HEAD, but
am getting a lifeless result i.g. here's what I did:

sudo /usr/bin/hcitool scan
sudo /usr/bin/simple-agent hci0 D4:9A:20:88:C7:48
sudo /usr/bin/dbus-send --system --dest=3Dorg.bluez --print-reply
/org/bluez/1897/hci0/dev_D4_9A_20_88_C7_48 org.bluez.Input.Connect
sudo /usr/bin/test-device trusted D4:9A:20:88:C7:48

the thing works after that(no scroll), fast cursor though.
then reboot
once up and running nothing.
cat /var/log/daemon.log (shows this)

Feb  8 22:57:40 Linux-1 bluetoothd[1973]: link_key_request
(sba=3D00:25:00:C0:6C:4F, dba=3DD4:9A:20:88:C7:48)
Feb  8 22:58:21 Linux-1 bluetoothd[1973]: last message repeated 5 times
Feb  8 22:59:21 Linux-1 bluetoothd[1973]: last message repeated 3 times
Feb  8 23:03:10 Linux-1 bluetoothd[1973]: link_key_request
(sba=3D00:25:00:C0:6C:4F, dba=3DD4:9A:20:88:C7:48)

(could be missing something though(don't use gnome/kde-bluetooth)although
mightymouse works).

bluez is v59(in the morning I can load up the latest and see).
and then go from there if you need me to be a test subject let me know.


BTW: ed I can attach the patch(seperate e-mail) which is updated to
rc6*(to the most part)
 if you want.? this way you can give it a try, then once these are in
the mainline
you wont have todo so.

--=20
Justin P. Mattock
