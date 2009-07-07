Return-Path: <cyrus@holtmann.org>
Message-ID: <4A539352.1070003@gdatech.co.in>
Date: Tue, 07 Jul 2009 23:56:26 +0530
From: Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in>
MIME-Version: 1.0
To: Vladimir Botka <vbotka@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth Headset connection issue with PulseAudio
References: <4A4E0494.5060006@gdatech.co.in>	<20090703162508.3dd214b4@vlado.suse.cz>	<4A521DF9.8010901@gdatech.co.in>	<20090707111147.5241cbde@vlado.suse.cz>	<4A531A0C.1060600@gdatech.co.in> <20090707151914.37bc10c3@vlado.suse.cz>
In-Reply-To: <20090707151914.37bc10c3@vlado.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Vladimir Botka,
>>>>>> Hi All,
>>>>>> I am trying to connect my bluetooth headset to my Linux box using
>>>>>> Pulse Audio. I am able to successfully run the pactl sink command
>>>>>> but when I look at the debug log I could see the headset is
>>>>>> connecting and disconnects immediately due to an error returning
>>>>>> unknown connection handle in the SCO packet.
>>>>>>
>>>>>> My test configurations:
>>>>>> Linux Kernel version : 2.6.30
>>>>>> Bluez version : 4.32
>>>>>> Pulse audio version:  0.9.14
>>>>>> Linux Distro: Ubuntu Jaunty 9.04
>>>>>>
>>>>>> My BT Dongle: Gigabyte BTD02
>>>>>> HCI Ver: 1.2 (0x2) HCI Rev: 0x639 LMP Ver: 1.2 (0x2) LMP Subver:
>>>>>> 0x639 Manufacturer: Cambridge Silicon Radio (10)
>>>>>>
>>>>>> Pulse audio, pactl sink command output is as below:
>>>>>> btaudio~$ sudo pactl load-module module-alsa-sink
>>>>>> device=btheadsetsudo: unable to resolve host btaudio
>>>>>> 15
>>>>>>
>>>>>> I am getting the following error in the kernel message:
>>>>>> hci_scodata_packet: hci0 SCO packet for unknown connection handle
>>>>>> 45
>>>>>>
>>>>>> Please find the log of "bluetoothd -nd":
>>>>>> bluetoothd[4127]: Unix client disconnected (fd=13)
>>>>>> bluetoothd[4127]: State changed 
>>>>>> /org/bluez/4127/hci0/dev_AE_2D_CC_AA_BB_14: HEADSET_STATE_PLAYING
>>>>>> -> HEADSET_STATE_CONNECTED
>>>>>> bluetoothd[4127]: No matching connection found for handle 45
>>>>>> bluetoothd[4127]: telephony-dummy: device 0x2064d398 disconnected
>>>>>> bluetoothd[4127]: State changed 
>>>>>> /org/bluez/4127/hci0/dev_AE_2D_CC_AA_BB_14:
>>>>>> HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
>>>>>>
>>>>>> My asoundrc file:
>>>>>> btaudio:~$ more .asoundrc
>>>>>> pcm.btheadset {
>>>>>> type bluetooth
>>>>>> device AE:2D:CC:AA:BB:14
>>>>>> profile "auto"
>>>>>> }
>>>>>>
>>>>>> Anyone has come across this similar issue? Any suggestions.
>>>>>>         
>>>>>>             
>>>>> There are 2 kinds of bluetooth modules in pulseaudio. The 1st one
>>>>> sends the audio via alsa-bluetooth and the the 2nd one are the
>>>>> native pulseaudio bluetooth modules. None of them are working
>>>>> AFAIK.
>>>>>
>>>>> But, there is the possibility to use the bluetooth headphones and
>>>>> be able to use the pulseaudio. Use the following .asoundrc
>>>>>
>>>>> # cat ~/.asoundrc
>>>>>        pcm.!default {
>>>>>                type pulse
>>>>>        }
>>>>>        ctl.!default {
>>>>>                type pulse
>>>>>        }
>>>>>        pcm.btheadset {
>>>>>                type bluetooth
>>>>>                device "00:13:17:72:CD:FF"
>>>>>        }
>>>>>
>>>>> Thus all default alsa output is redirected to the pulseaudio and
>>>>> the bluetooth headphones can be used with the applications which
>>>>> allow to select specific device (btheadset in this case). You can
>>>>> find more details here [1]. 
>>>>>   
>>>>>       
>>>>>           
>>>> Thanks for your reply and the details on the asoundrc file.
>>>> We could hear only some sound at regular intervals. There is no
>>>> Music heared.
>>>>
>>>> Is there anything to do the version interoperability?
>>>>
>>>> My test configurations:
>>>> Linux Kernel version : 2.6.30
>>>> Bluez version : 4.32
>>>> Pulse audio version:  0.9.14
>>>> Linux Distro: Ubuntu Jaunty 9.04
>>>>
>>>> Does the following error cause the issue that I am facing? 
>>>> bluetoothd[3977]: audio handle_uuid: server not enabled for
>>>> 0000111e-0000-1000-8000-00805f9b34fb (0x111e)
>>>>
>>>>     
>>>>         
>>> Yes. This could be a problem. The described solution was tested on
>>> openSUSE 11.1 with the following versions.
>>>
>>> Linux Kernel version : 2.6.27
>>> Bluez version : 4.42
>>> Pulse audio version:  0.9.14
>>>
>>> But in this case the module which actually sends the sound to the
>>> bluetooth headset is bluez-alsa-4.42-67.1 .
>>>
>>> Have fun,
>>>   
>>>       
>> Thanks for your reply.
>>
>> Do you have any idea what does the following message indicates, Any
>> idea?
>>
>> *bluetoothd[3977]: audio handle_uuid: server not enabled for
>> 0000111e-0000-1000-8000-00805f9b34fb (0x111e)*
>>
>> Anything I need to enable before testing audio. Can you share your
>> audio.conf file?
>>
>> ...
>> bluetoothd[9663]: audio.conf: Key file does not have key 'AutoConnect'
>> bluetoothd[9663]: audio.conf: Key file does not have key
>> ...
>> HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
>> bluetoothd[9663]: Unix client disconnected (fd=18)
>> bluetoothd[9663]: State changed 
>> /org/bluez/9663/hci0/dev_AE_2D_CC_AA_BB_14: HEADSET_STATE_PLAYING -> 
>> HEADSET_STATE_CONNECTED
>> bluetoothd[9663]: client_free(0x204a2270)
>> *bluetoothd[9663]: No matching connection found for handle 45*
>> bluetoothd[9663]: telephony-dummy: device 0x204ba490 disconnected
>> bluetoothd[9663]: State changed 
>> /org/bluez/9663/hci0/dev_AE_2D_CC_AA_BB_14: HEADSET_STATE_CONNECTED
>> -> HEADSET_STATE_DISCONNECTED
>>     
>
> There is no audio.conf in my /etc tree. The
> bluez-audio is configured here /etc/alsa/bluetooth.conf (attached).
>   
I have same bluetooth.conf file.
> Tarball /etc/bluetooth is attached too. 
I had one audio.conf in the /etc/bluetooth which I deleted and tried. 
The device connects
in HFP and only noise we could hear.
> But, telephony-dummy is a2dp
> device ? Try with other a2dp (stereo) headphone. Maybe [1] can tell
> more. And try a simple "aplay -D bths foo.wav" for testing (where bths
> is your entry in ~/.aosundrc.
>
> [1] http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>   
I do not have a stereo headphone. I have a mono headset that supports 
HSP. When I play
using aplay -D btheadset <music file> I get the following error.
/Playing raw data 'Nagada Nagada.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono
aplay: set_params:961: Sample format non available

/But when I played using the following option
aplay -D plug:btheadset <music file>
the file is playing, I hear only noise.

Thanks & Regards,
Benjamin

