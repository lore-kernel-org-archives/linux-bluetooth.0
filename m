Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Mar 2009 23:31:46 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Flood of "urb ... submission failed" with bluetooth headset
In-Reply-To: <7337540c0903290328o57d99321h638315cdf79c8e52@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.0903292156230.32436@nge2.ngu.pk>
References: <7337540c0903290328o57d99321h638315cdf79c8e52@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Sun, 29 Mar 2009, Ludovico Cavedon wrote:

> When I try to play some audio on the my bluetooth headset, my syslog
> is flooded with messages like
>
> btusb_send_frame: hci0 urb ffff8800624bd800 submission failed
>
> The command I tried are:
>
>  aplay -D plug:headset /usr/share/sounds/card_shuffle.wav
> ->The headset activates, but I do not hear the audio and the syslog
> keep being flooded until I kill aplay
>
> mplayer -ao alsa:device=headset /usr/share/sounds/card_shuffle.wav
> ->works with low quality, but the syslog still gets flooded for the
> duration of the wav file
>
> Linux distribution: Ubuntu jaunty beta


Same thing happen here, too:

btusb_send_frame: hci0 urb d093f200 submission failed
btusb_send_frame: hci0 urb d093f400 submission failed
btusb_send_frame: hci0 urb d093fa00 submission failed
...
btusb_send_frame: hci0 urb d093fc00 submission failed
btusb_send_frame: hci0 urb d093fe00 submission failed
btusb_send_frame: hci0 urb d7271e00 submission failed
btusb_send_frame: hci0 urb d7271400 submission failed

Seems to be related to the new btusb kernel module, because it didn't used to 
happen with hci_usb kmod. Since the address keeps changing, syslog 
rate-limiting can't remove them as dups . Maybe one out of the flurry of 
patches we see on this list will address this soon.


If you use rsyslog, *I think* this line, placed near the top of rsyslog.conf 
file will keep them out of the log at least:

:msg, contains, "hci0 urb"      ~


