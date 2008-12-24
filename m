Return-Path: <cyrus@holtmann.org>
Message-ID: <4951808D.8020907@morrigan.ch>
Date: Wed, 24 Dec 2008 01:21:33 +0100
From: manuel gysin <gwydion.dot@morrigan.ch>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <494CE2CD.9010303@morrigan.ch>
	<1230074036.4954.15.camel@californication>
In-Reply-To: <1230074036.4954.15.camel@californication>
Subject: Re: [Bluez-users] BlueZ4.x, headset and oss problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

> Hi Manuel,
> 
>> I've manged to get my headset running with BlueZ4. Sound and Voice is 
>> working very well with Skype.
>>
>> Now I tried to use my headset with teamspeak. I tried to run it with 
>> aoss teamspeak, but the problem is now I have no /dev/dspx device for 
>> the headset.
> 
> I don't even have any idea what /dev/dspx is used for. Remember that all
> Bluetooth audio is virtual and lives in userspace. So if you require a
> kernel device node, then the kernel (meaning ALSA) has to do some magic
> here.
> 
> Regards
> 
> Marcel
> 
> 
> 

/dev/dspx should be an oss device like /dev/dsp0.
In the old version of BlueZ there was a plugin called snd-bt-sco and 
created an entry under /proc/asounds/cards.

With that the oss emulation created a dsp-device of the alsa device. But 
the wiki tells that this is no longer needed.

I use a 2.6.26 kernel with "ALSA for SoC audio support" (I know SoC is 
not ScO, I think this is not what I'm need).

My problem is now, that I can't use the aoss command cause there is no 
card entry for the headset and so no /dev/dspx will be created.

I searched around the internet but find nothing about it. So I don't 
know if it a mistake from my side or bluez does not have such a feature.

The man page of aoss told me that I can "fake" such e device with
"pcm.dsp0 {      type plug      slave.pcm "headset" }"
in ~/.asoundrc.
But this will not work, there is no such routing to the bluetooth device.

Regards
Manuel

PS: I hope my English is not to bad to understand

------------------------------------------------------------------------------
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
