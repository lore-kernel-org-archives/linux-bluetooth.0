Return-Path: <cyrus@holtmann.org>
Message-ID: <4910B2CE.5000500@slackdot.org>
Date: Tue, 04 Nov 2008 15:38:38 -0500
From: deker <deker@slackdot.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <490FCEFE.50302@slackdot.org> <20081104132403.GA22659@localhost>
	<49107496.9030409@slackdot.org>
In-Reply-To: <49107496.9030409@slackdot.org>
Subject: Re: [Bluez-devel] Multiple simultaneous audio streams?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Oops. I forgot to mention that this is with BlueZ 4.13.

-d

deker wrote:
> I've changed the MaxConnections setting and now I'm seeing something 
> different (this must mean I'm getting closer :)
>
> I'm using the following config/comandline to play audio:
>
> audio.conf:
> [General]
> SCORouting=PCM
> [Headset]
> HFP=False
> MaxConnections=2
>
> ~/.asoundrc:
>
> pcm.bluetooth {
>     type bluetooth
>     device 00:0B:2E:D5:27:DA  
>     profile auto
> }
> pcm.bluetooth2 {
>     type bluetooth
>     device 00:0B:2E:D4:EC:31
>     profile auto
> }
>
> mplayer command lines:
>
>  mplayer -ao alsa:device=bluetooth test.wav
>  mplayer -ao alsa:device=bluetooth2 test.wav
>
> Either execution of mplayer works properly as long as the other isn't 
> streaming to the device. If one is already running, mplayer reports the 
> following:
>
> [AO_ALSA] alsa-lib: pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) 
> BT_SETCONFIGURATION failed : Input/output error(5)
> [AO_ALSA] Unable to set hw-parameters: Input/output error
> Could not open/initialize audio device -> no sound.
> Audio: no sound
> Video: no video
>
>
> Exiting... (End of file)
>
> Also, it seems that I'm losing the beginning of the sample in playback. 
> I assume this is due to the delay of setting up the connection to the 
> headset, but I was wondering if there was a way to avoid this.
>
> Thanks,
>
> -d
>
>
>
>
> Johan Hedberg wrote:
>   
>> On Mon, Nov 03, 2008, deker wrote:
>>   
>>     
>>>  I am working on a project where it would be desirable to have audio 
>>> streams going to more than one SCO audio device at a time. My quick test 
>>> today of playing a WAV file with mplayer to two different devices didn't 
>>> work and bluetoothd was reporting "connection refused" when I tried to 
>>> get the second stream going. Once the first playback finished, I was 
>>> able to then play to the second device.
>>>
>>> So, I suppose m question is if BlueZ supports audio to multiple SCO 
>>> devices at the same time? If not, what might be involved in making it work?
>>>     
>>>       
>> If you're using BlueZ 4.17 or later you'll need to add something like
>> MaxConnections=2
>> to the [Headset] section in /etc/bluetooth/audio.conf to be able to
>> create a service level connection to more than 1 device.
>>
>> Johan
>>
>> -------------------------------------------------------------------------
>> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
>> Build the coolest Linux based applications with Moblin SDK & win great prizes
>> Grand prize is a trip for two to an Open Source event anywhere in the world
>> http://moblin-contest.org/redirect.php?banner_id=100&url=/
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>   
>>     
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
