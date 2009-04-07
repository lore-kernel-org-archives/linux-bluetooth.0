Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Date: Tue, 07 Apr 2009 00:47:12 -0400
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904061457.02511.gene.heskett@verizon.net>
 <alpine.LNX.2.00.0904062153190.3436@nge2.ngu.pk>
In-reply-to: <alpine.LNX.2.00.0904062153190.3436@nge2.ngu.pk>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Message-id: <200904070047.12382.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 06 April 2009, jayjwa wrote:

Whats with this list server, its broken!  Even if I hit reply all, it goes 
back out as personal unless I manually add the lists address.  Talk about a 
broken server setup...

>On Mon, 6 Apr 2009, Gene Heskett wrote:
>>> Another idea is try to re-pair the devices. Are you running the
>>> passkey-agent and auth-agent?
>>
>> What are those?  I never heard of them before.  I just built and installed
>> bluez-4.34
>
>That changes everything. I thought you had bluez-3.x here.

No, I started with the 4.30 rpms, and installed from the tarball over the top 
of that by --prefix=/usr when I configured it.

>I've never got
>anything working with 4.x, short of a partial headset test. But bluez-4.x
> has something like passkey-agent, the "simple-agent". You'll need to get
> the actual sources because I doubt it's in the RPM package.

That is what I'm trying to use, and dbus looks to be denying it.
----------------------------------------------------------------
[root@coyote test]# ./simple-agent hci0 00:0C:84:00:86:F8
ERROR:dbus.proxies:Introspect error on :1.67:/: dbus.exceptions.DBusException: 
org.freedesktop.DBus.Error.AccessDenied: A security policy in place prevents 
this sender from sending this message to this recipient, see message bus 
configuration file (rejected message had interface 
"org.freedesktop.DBus.Introspectable" member "Introspect" error name "(unset)" 
destination ":1.67")
Traceback (most recent call last):
  File "./simple-agent", line 84, in <module>
    path = manager.FindAdapter(sys.argv[1])
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68, in 
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140, in 
__call__
    **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 630, in 
call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.AccessDenied: A 
security policy in place prevents this sender from sending this message to 
this recipient, see message bus configuration file (rejected message had 
interface "org.bluez.Manager" member "FindAdapter" error name "(unset)" 
destination ":1.67")
-----------------------------------------------
No matter what I run in this test directory, the returned error msg is exactly 
the same as above.  I've posted to the fedora list to see if anyone there has 
a clue.

> If you have
> something else you're using to do pairing with, and it works, use that.

If I did, I sure would. :)

> Honestly, I don't know what people are supposed to use to pair with in 4.x,
> since most distrobutions come without simple-agent and bluez-gnome has so
> many dependences (GUI).

Its also installed but I'm a kde fan.

>> #!/bin/bash
>> echo attempting to get bt link to the coco3
>> echo "rfcomm release 0"
>> rfcomm release 0
>> sleep 2
>> ls -l /dev/rfcomm*
>> sleep 2
>> rfcomm -i 11:11:11:11:11:11 show hci0
>> sleep 2
>> echo "resetting hci0"
>> hciconfig reset hsi0
>> sleep 2
>> ls -l /dev/rfcomm*
>> sleep 2
>> rfcomm -i 11:11:11:11:11:11 show hci0
>> sleep 2
>> ls -l /dev/rfcomm*
>> sleep 2
>> echo "hciconfig -a"
>> hciconfig -a
>> sleep 2
>> ls -l /dev/rfcomm*
>> sleep 2
>> echo "rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8"
>> rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8
>
>This still shows "hci0" when I think it would be the rfcomm minor number,
>rfcomm bind 0 <bt addr> <channel>
>
>> sleep 2
>> ls -l /dev/rfcomm*
>> sleep 2
>> echo "rfcomm connect 0 00:0c:84:00:86:F8 1"
>> rfcomm connect 0 00:0c:84:00:86:F8 1
>> echo this should show the cocos address
>> rfcomm -i 11:11:11:11:11:11 show 0
>>
>>
>> And the shell output is:
>> [root@coyote bin]# ./connect2coco3
>> attempting to get bt link to the coco3
>> rfcomm release 0
>> ls: cannot access /dev/rfcomm*: No such file or directory
>> Get info failed: No such device
>> resetting hci0
>> hci0:   Type: USB
>>        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
>>        UP RUNNING PSCAN ISCAN
>>        RX bytes:15003 acl:10 sco:0 events:440 errors:0<-note RX count,
>> events TX bytes:4548 acl:10 sco:0 commands:403 errors:0<-TX will increase
>
>It would help to see the services running on the coco3:
>
>sdptool browse <coco btaddr>
-------------------------------------------
[root@coyote bin]# sdptool browse 00:0C:84:00:86:F8
Browsing 00:0C:84:00:86:F8 ...
[root@coyote bin]#
-----------------------------------------------
>> ls: cannot access /dev/rfcomm*: No such file or directory
>> rfcomm -i 11:11:11:11:11:11 bind 0 00:0c:84:00:86:F8
>> crw------- 1 root root 216, 0 2009-04-06 14:11 /dev/rfcomm0
>> rfcomm connect 0 00:0c:84:00:86:F8 1
>> Can't connect RFCOMM socket: Host is down
>> this should show the cocos address
>> rfcomm0: 11:11:11:11:11:11 -> 00:0C:84:00:86:F8 channel 1 clean
>
>The file will always be there, only it's not "pointing" to anything if
>everything didn't work out OK.

/dev/rfcomm0 is removed by the release, and created by the bind.

>>> That would refer to the bt device 0000, which isn't even a valid address
>>> format:
>>>
>>> putkey     <bdaddr>     Store link key on the device
>>
>> Ok, understood, but where does it get the link key to 'putkey' then?>
>> The current version of the script doesn't have this command anymore.
>
>>>From pairing, I'm guessing.
>
>>>> echo "rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8"
>>>> rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8
>>>
>>> This worked with no channel named? Then again, I don't know if one is
>>> really needed. Uncharted waters I'm heading into here...
>>
>> Acc. the manpage, channel is optional, uses channel 1 if not given.>
>
>So we hope your service you want to access on the remote end is indeed
> running on channel 1! If not, this won't work.

According to the docs I got from the a7 site, channel 1 is the default.
>
>> I had a 'watch' running, stopped that: then
>> [root@coyote sysconfig]# rfcomm  show rfcomm0
>> rfcomm0: 11:11:11:11:11:11 -> 00:0C:84:00:86:F8 channel 1 closed
>> rfcomm connect 0 00:0c:84:00:86:F8  (a good 10 sec delay here)
>> Can't connect RFCOMM socket: Connection timed out
>
>Let the application make the connection. Just bind the device. That's how
> I've done it always. The application will then open /dev/rfcomm0 and do its
> thing.

except:
[root@coyote bin]# minicom
minicom: cannot open /dev/rfcomm0: No such file or directory

but its there right now.
[root@coyote bin]# ls -l /dev/rfcomm*
crw------- 1 root root 216, 0 2009-04-07 00:33 /dev/rfcomm0

I've downloaded all the bluez-3.30 stuff and if no more answers seem to be 
forthcoming, I may try it sometime tomorrow.

>>> uses headsets under 4.x. From the other questions on the list, no-one
>>> uses anything successfully under 4.x, unless you count /usr/bin/patch.
>>> Really I'm thinking of unsubscribing.
>>
>> It doesn't seem to be all that helpful, you and I believe one other person
>> has replied, always by personal email rather than the list.  That is not
>> what keeping an archive of a list is all about. BTW, where is that list
>> archive?
>
>Well, I replied directly to you because no one else was answering or
> helping. I assumed they either didn't know or care.
>
>> I went to google and looked up 'bluetoogh pairing' and got this:
>> http://www.bluetomorrow.com/content/section/180/284/
>> but no real howto.  And I did chase down quite a few other links, mostly
>> for pairing with mobile phones or headsets, nothing on using them as a
>> wireless rs232 circuit.  Which is what I want of course.
>
>I'm guessing pairing is still needed, but you're really outside my area of
>experience here.
>
>> Thank you jayjwa, and I appreciate very much your use of english as its
>> the only language this old (74) fart knows.
>
>Me too, though I did pick up a very small amount of German when I was there.

There was a time 60 years ago when I could read enough german to fix a 
telefunken radio, but then the japanese moved in with their dialect of 
Engrish, some of which is pretty comical.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
When smashing monuments, save the pedstals -- they always come in handy.
		-- Stanislaw J. Lem, "Unkempt Thoughts"

