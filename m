Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45CB57A7.1050505@killesreiter.de>
Date: Thu, 08 Feb 2007 18:02:31 +0100
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45C7C6DF.20106@killesreiter.de>
	<45C7FFD2.9080300@xmission.com>	<45C83D70.9030900@killesreiter.de>
	<45CA5412.9070702@killesreiter.de>
In-Reply-To: <45CA5412.9070702@killesreiter.de>
Subject: Re: [Bluez-users] headset /SCO / plugz
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Gerhard Killesreiter wrote:
> Gerhard Killesreiter wrote:
>> Brad Midgley wrote:
>>> Gerhard
>>>
>>>> 6) now what? a2dpd doesn't show up in my output choices in xmms, 
>>>> "headset" shows up as a choice for the mixer device, but not the 
>>>> general output device.
>>> I have to type
>>>  a2dpd
>>>   or
>>>  headset
>>> freehand in the device choice in xmms. It's true it doesn't find it
>>> automatically and we've tried to document that.
>>>
>>
>> Ok, tried that, but it still doesn't work.
>>
>> Set to a2dpd and ran a2dpd:

Ok, I've given up on a2dpd and tried headsetd for SCO (what I wanted to 
do anyway): It works!

My problem apparently was that hibernating the laptop didn't allow 
usb/alsa/bluetooth to work properly after waking up the machine. 
Switching the headset on/off also seems to help. I've now added all usb 
modules to the hibernate blacklist and will see if it still works after 
the next hibernation.

I have booted and headsetd will now work, I can direct sound output to 
my headset as given on the "build" page and I can also record sound from 
the microphone doing:

arecord -D headset --format=S16_LE blah.wav

My problem is now that most apps don't allow for specific sound options 
on the command line. I am thinking of skype and krut 
(http://sourceforge.net/projects/krut/). Is there a way to make the 
headset the default alsa device?

(later)

Apparently, the answer is yes and I need to modify my .asoundrc file. 
Does anybody have a copy that works in such a way that when the headset 
is available it is the default and in other cases the normal speaker/micro?


Cheers,
	Gerhard

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
