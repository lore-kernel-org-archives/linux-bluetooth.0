Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4470C77A.2080006@ens.fr>
From: Giuseppe Castagna <Giuseppe.Castagna@ens.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] report on new bluez headset
References: <446CDD43.3050604@free.fr> <446F383A.1040605@ens.fr> <4470B491.7040004@free.fr>
In-Reply-To: <4470B491.7040004@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 21 May 2006 22:03:06 +0200

Fabien Chevalier wrote:

>> - if I close and reopen the headset then ekiga no longer finds the 
>> audio device
> 
> Do you mean ending a call by closing the headset ??
> 

Yes, exactly. If I close the headset during a conversation then ekiga completely 
freezes.



>> - if I change the device in the preferences and then put back the
>>   bluetooth headset  ekiga no longer finds the bluetooth device.
>>
> Hmmm... strange. Could you please be a little more precise on that ?
> 


Even stranger, I can no longer reproduce it. Well.

>> In both cases the only solution is to close and reopen ekiga.
>>
>> Woth xmms instad the beahviour is *quite* bizarre. When I select the 
>> headset in the alsa plugin the music is played about 4 times faster 
>> and the console prints repeatedly the following warning.
>>
>> ** WARNING **: alsa_mmap_audio(): snd_pcm_mmap_commit returned 24, 
>> expected 104
> 
> I would even say 104 / 24 = 4,3333 time faster.
> 
> That's weird as xmms works really perfectly on my box. :-(
> COuld you give me details about your software configuration (xmms 
> version, alsa version, OS version..) ?
> 
alsa-lib-1.0.11-3.rc2.2
alsa-utils-1.0.11-4.rc2
alsa-lib-devel-1.0.11-3.rc2.2
xmms-1.2.10-23.fc5
xmms-mp3-1.2.10-16.fc5
xmms-libs-1.2.10-23.fc5
Linux mirto 2.6.17-rc4 #1 Tue May 16 17:58:16 CEST 2006 i686 i686 i386 GNU/Linux[


> Could you also try to remove line 322 in file pcm_bluez_headset,
> and see if it works better ?
> 

Done, and yes indeed it works. But the sound is not perfect. I hear some frying 
sound (un petit gresillement), not very disturbing though but it is absent when 
I use it with Ekiga.

>> - the device does not appear in the alsa mixer
> 
> You're wrong on this one.
> If you launch 'alsamixer -Dheadset' you will see your headset controls,
> and if you play with volume controls while in a middle of a call you 
> should ear the difference.
> 

Right. Just a couple of questions then. How can I have it appear in gnome volume 
control. And how to use the headset with, say, skype?

Thanks

Beppe


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
