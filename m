Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jul 2009 16:25:08 +0200
From: Vladimir Botka <vbotka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in>
Subject: Re: Bluetooth Headset connection issue with PulseAudio
Message-ID: <20090703162508.3dd214b4@vlado.suse.cz>
In-Reply-To: <4A4E0494.5060006@gdatech.co.in>
References: <4A4E0494.5060006@gdatech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 03 Jul 2009 18:46:04 +0530
Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in> wrote:

> Hi All,
> I am trying to connect my bluetooth headset to my Linux box using
> Pulse Audio. I am able to successfully run the pactl sink command but
> when I look at the debug log I could see the headset is connecting
> and disconnects immediately due to an error returning unknown
> connection handle in the SCO packet.
> 
> My test configurations:
> Linux Kernel version : 2.6.30
> Bluez version : 4.32
> Pulse audio version:  0.9.14
> Linux Distro: Ubuntu Jaunty 9.04
> 
> My BT Dongle: Gigabyte BTD02
> HCI Ver: 1.2 (0x2) HCI Rev: 0x639 LMP Ver: 1.2 (0x2) LMP Subver: 0x639
> Manufacturer: Cambridge Silicon Radio (10)
> 
> Pulse audio, pactl sink command output is as below:
> btaudio~$ sudo pactl load-module module-alsa-sink
> device=btheadsetsudo: unable to resolve host btaudio
> 15
> 
> I am getting the following error in the kernel message:
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 45
> 
> Please find the log of "bluetoothd -nd":
> bluetoothd[4127]: Unix client disconnected (fd=13)
> bluetoothd[4127]: State changed 
> /org/bluez/4127/hci0/dev_AE_2D_CC_AA_BB_14: HEADSET_STATE_PLAYING -> 
> HEADSET_STATE_CONNECTED
> bluetoothd[4127]: No matching connection found for handle 45
> bluetoothd[4127]: telephony-dummy: device 0x2064d398 disconnected
> bluetoothd[4127]: State changed 
> /org/bluez/4127/hci0/dev_AE_2D_CC_AA_BB_14: HEADSET_STATE_CONNECTED
> -> HEADSET_STATE_DISCONNECTED
> 
> My asoundrc file:
> btaudio:~$ more .asoundrc
> pcm.btheadset {
> type bluetooth
> device AE:2D:CC:AA:BB:14
> profile "auto"
> }
> 
> Anyone has come across this similar issue? Any suggestions.
> 
> Thanks & Regards,
> Benjamin
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.

There are 2 kinds of bluetooth modules in pulseaudio. The 1st one sends
the audio via alsa-bluetooth and the the 2nd one are the native
pulseaudio bluetooth modules. None of them are working AFAIK.

But, there is the possibility to use the bluetooth headphones and be
able to use the pulseaudio. Use the following .asoundrc

# cat ~/.asoundrc
       pcm.!default {
               type pulse
       }
       ctl.!default {
               type pulse
       }
       pcm.btheadset {
               type bluetooth
               device "00:13:17:72:CD:FF"
       }

Thus all default alsa output is redirected to the pulseaudio and the
bluetooth headphones can be used with the applications which allow to
select specific device (btheadset in this case). You can find more
details here [1]. 

Ciao,
-- 
	-vlado
	Vladimir Botka

[1] http://en.opensuse.org/Bluetooth_headphones
