Return-Path: <cyrus@holtmann.org>
Message-ID: <4A56013D.70004@gdatech.co.in>
Date: Thu, 09 Jul 2009 20:09:57 +0530
From: Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in>
MIME-Version: 1.0
To: balaji_palaniswami@yahoo.com
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Recommended asoundrc for bluetooth headset
References: <6AC5A55546F64545AE996F8200E3AC4E06A506A3@NL0105EXC01V01.eur.slb.com>	<353624.65161.qm@web95411.mail.in2.yahoo.com> <6AC5A55546F64545AE996F8200E3AC4E06A50ABC@NL0105EXC01V01.eur.slb.com>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06A50ABC@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Balaji,
> ----- Original Message ----
> From: John Frankish <j-frankish@slb.com>
> To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
> Sent: Thursday, 18 June, 2009 12:11:53 PM
> Subject: Recommended asoundrc for bluetooth headset
>
> Is there a recommended .asoundrc for use with a bt headset? I've seen at least three versions and would be interested to know which is the "correct" one:
>
> ------
> pcm.bluetooth {
> type bluetooth
> device "00:12:EE:A6:1D:F4"
> profile "auto"
> }
>
> ctl.bluetooth {
> type bluetooth
> }
> -----
> pcm.rawbluetooth {
>    type bluetooth
>    device 00:12:EE:A6:1D:F4
> }
>
> pcm.bluetooth {
>    type plug
>    slave {
>       pcm {
>          type bluetooth
>       }
>    }
> }
> -----
> pcm.bluetoothraw {
>    type bluetooth
>    device 00:12:EE:A6:1D:F4
>    profile auto
> }
>
> pcm.bluetooth {
>    type plug
>    slave {
>         pcm bluetoothraw
>    }
> }
> -----
> --
> John,
> Third  asoundrc is right one, this asoundrc is working for me upto bluez 4.32.
> I am upgrading kernel to 2.6.rc8, bluez 4.41  and other depnedencies whatever you mentioned.
> then i will update you result of a2dp , headset profile.Inmeanwhile please try 3rd asoundrc ,let me know your result.
>
> Thanks,
> Balaji.P
> ----
>
> Using first asoundrc
>
> $ aplay -Dbluetooth -v /usr/local/share/sounds/alsa/Noise.wav
> correct sound.
>
> $ aplay -Dplug:bluetooth -v /usr/local/share/sounds/alsa/Noise.wav
> incorrect sound.
>
> Using third asoundrc
>
> $ aplay -Dbluetooth -v /usr/local/share/sounds/alsa/Noise.wav
> incorrect sound.
>
> $ aplay -Dplug:bluetooth -v /usr/local/share/sounds/alsa/Noise.wav
> correct sound.
>
> Using first or third asoundrc
>
> $ arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE
> Correct sound
>
> ..and if I could remember the aplay command switch to play an mp3, I would have tried that...
Apart from .asoundrc file what are the other configuration files that 
need to be taken care if we need to try mono and stereo headset.(HSP and 
A2DP)
What is the significance of the audio.conf file in the /etc/bluetooth? 
Whether this is required for the Bluetooth headset proper audio routing?
If you are using the audio.conf for the A2DP/HSP can you share what 
additional configurations you have made.

Also can you please share your experience with the 4.41+ on your side 
with the Bluetooth headset Mono or stereo.

Thanks & Regards,
Benjamin
