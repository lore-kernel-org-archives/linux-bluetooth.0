Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
Subject: Re: The link I had working quit.  Help
Date: Tue, 07 Apr 2009 17:35:28 -0400
Cc: Zygo Blaxell <zblaxell@dactyl.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904071454.54317.gene.heskett@verizon.net>
 <20090407200201.GA18671@hungrycats.org>
In-reply-to: <20090407200201.GA18671@hungrycats.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904071735.28381.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 07 April 2009, Zygo Blaxell wrote:
>On Tue, Apr 07, 2009 at 02:54:54PM -0400, Gene Heskett wrote:
>> But nothing seems to enable the pairing, and everytime I do that that far
>> in the 'bluetooth-wizard' and it sees the eb101, it tells me to enter an
>> apparently randomly derived 4 digit pin number, but the wizard gives me no
>> place to enter it. Nor is there a 'proceed' button, and in 5 seconds or so
>> it clears that screen and reports pairing failed.
>
>bluez-gnome (where your bluetooth-wizard comes from?) has a really stupid
>UI design.  If bluetooth-wizard thinks you *can* enter a PIN into your
>device, it will *require* you to enter a random one.  This idea doesn't
>work so well on devices that don't have keyboards or that have fixed PINs,
>and bluetooth-wizard knows only about broad categories of devices and a
>handful of exceptions.  The opposite problem occurs on devices where
>bluez-gnome thinks it knows a fixed-PIN device's PIN, but it actually
>doesn't.
>
>Also, bluez-gnome's discovery page won't show you discoverable devices that
>are already known, so it can't tell you if a known device is in range.
>'hcitool scan' will tell you about all devices in range, but it causes some
>problems for bluetoothd if both are running at the same time.
>
>If you can, use simple-agent instead of bluetooth-wizard.
>
>> Aha!  A chance comment I read someplace paid off!  I knew the PIN code for
>> that device was 0000 after a factory reset, which had been done several
>> times. The comment was that if a pairing failed, they had to be powered
>> off before it could be tried again, so I went to the other end and did a
>> powerdown reset, than came backup up to here and swapped one for the other
>> of the 2 devices I had here, which have identical bdaddr's.
>
>How do you have two devices with identical bdaddr's?  Doesn't that wreak
>all sorts of havoc for a piconet?  I would expect it to make all the link
>key management stop working, since link keys are randomly generated on
>each device, but stored in a database keyed by bdaddr.  Also, the piconet
>master clock for radio frequency hopping is keyed off the master's bdaddr,
>and has to be unique for each piconet.
>
>> Then I ran
>> [root@coyote test]# ./simple-agent hci0 00:0C:84:00:86:F8
>> RequestPinCode (/org/bluez/2008/hci0/dev_00_0C_84_00_86_F8)
>> Enter PIN Code: 0000
>> Release
>> New device (/org/bluez/2008/hci0/dev_00_0C_84_00_86_F8)
>>
>> Ok, tapped the hdwe reset on the coco3 and let it reboot which restarts
>> the shell I killed that should be available for minicom to talk to..
>
>So at this point you should have a link key established between your
>Bluetooth devices.  You have successfully completed pairing, and
>if the remote device has non-volatile storage, it will stay paired.
>Normal remote devices do have non-volatile storage for link keys,
>but I'm not sure your devices are normal.
>
>> Operative word is 'should':
>> [root@coyote test]# minicom
>> minicom: cannot open /dev/rfcomm0: No such file or directory
>> [root@coyote test]# ./simple-agent hci0 00:0C:84:00:86:F8
>> Creating device failed: org.bluez.Error.AlreadyExists: Bonding already
>> exists
>
>Yep, still paired...at least on the BlueZ side.
>
>> [root@coyote test]# rfcomm release all
>> [root@coyote test]# rfcomm bind 0 00:0c:84:00:86:F8
>
>I think this creates a device file named "0".  Try "/dev/rfcomm0" instead.

[root@coyote test]# rfcomm release all

[root@coyote test]# ls -l /dev/rfcomm*
ls: cannot access /dev/rfcomm*: No such file or directory

[root@coyote test]#  rfcomm bind /dev/rfcomm0 00:0c:84:00:86:F8

[root@coyote test]# ls -l /dev/rfcomm*
crw------- 1 root root 216, 0 2009-04-07 17:25 /dev/rfcomm0

[root@coyote test]# minicom
minicom: cannot open /dev/rfcomm0: No such file or directory

[root@coyote test]# ls -l /dev/rfcomm*
crw------- 1 root root 216, 0 2009-04-07 17:25 /dev/rfcomm0

and still dead.

>
>Also make sure that /dev/rfcomm0 exists after you've finished rfcomm bind.
>If you're using udev (which all modern distros should be), this should
>happen automatically after binding.  If it doesn't, you can try "MAKEDEV
>rfcomm0" or "mknod /dev/rfcomm0 c 216 0".
>
>> [root@coyote test]# minicom
>> minicom: cannot open /dev/rfcomm0: No such file or directory
>>
>> I think I'm battling with a bad error message that isn't telling me what I
>> think it is.
>
>No, in this case it's probably telling you that /dev/rfcomm0 really
>doesn't exist.  *Why* it doesn't exist is a separate question.  ;)

If it doesn't exist, why can I see it in the /dev directory?

>> [root@coyote test]# rfcomm connect 0 00:0c:84:00:86:F8 1
>> Can't connect RFCOMM socket: Host is down
>
>This usually means your remote device isn't connectable, or out of
>range, or has turned itself off, or has crashed, or maybe some other
>device has connected to the device you're trying to connect to.

>Apparently it can also mean the device isn't paired...or at least I get
>the same error when trying to bind rfcomm sockets to unpaired devices.
>So maybe you're not so paired after all.
>
>It should be /dev/rfcomm0, not just 0, I think.
>
>> [root@coyote test]# sdptool browse 00:0c:84:00:86:F8
>> Failed to connect to SDP server on 00:0C:84:00:86:F8: Host is down
>>
>> So what is the real problem here other than I'm a clueless newbie?
>
>It looks like your remote device is pairable, but maybe requires some kind
>of magic button sequence to make it connectable.  That would be odd, but
>within the realm of possibility.
>
>Or, your Bluetooth adapter hangs right after pairing.  That would also
>be odd, but possible.  There would probably be kernel log messages in
>that case at around the time it fails.  Also, 'hciconfig hci0 reset'
>might help if this is the case.

I didn't even have to pair it to make it work late friday evening, and for 
several hours last saturday.  But I thought I'd change the default PIN and it 
hasn't worked since.

>Another thing to watch out for is that a few devices like to power
>themselves off if nothing is connected to them for some time.  I have a
>headset that does this, which pretty much guarantees I'll never receive
>a phone call with it.

I'd have to call that cute, and it hasn't anything to do with being bow 
legged.

>Or possibly you have two devices with identical bdaddr, and they're both
>turned on at the same time, or you've paired with one and are now trying
>to connect to the other.

Only one of those is plugged in at once.  I got them from USBGear, and both 
show the same bdaddr when queried by hciconfig -a.

>> Did that:
>> [root@coyote test]# rfcomm release all
>> [root@coyote test]# rfcomm bind /dev/rfcomm0 00:0C:84:00:86:F8 1
>
>[...]
>
>> Terminal programs such as minicom cannot connect to /dev/rfcomm0, claiming
>> it does not exist.
>> root@coyote test]# ls -l /dev/rfcomm*
>> crw------- 1 root root 216, 0 2009-04-07 13:08 /dev/rfcomm0
>> [root@coyote test]# minicom
>> minicom: cannot open /dev/rfcomm0: No such file or directory
>>
>> Next?
>
>You seem to have paired successfully, but can't get any connections to
>work afterwards.

Correct.
>
>Maybe try 'l2ping' to verify the remote device is still on?
Variations on the theme:
[root@coyote test]# l2ping 00:0c:84:00:86:F8
Can't connect: Host is down
[root@coyote test]# l2ping -i hci0 00:0c:84:00:86:F8
Can't connect: Host is down
[root@coyote test]# l2ping -i /dev/rfcomm0 00:0c:84:00:86:F8
Can't connect: Host is down

So maybe there is a clue here?

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Linux, because we don't need no steenkin' Blue Screen of Death!

