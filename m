Return-Path: <cyrus@holtmann.org>
Message-ID: <48F5BA5C.2080304@comcast.net>
Date: Wed, 15 Oct 2008 02:39:40 -0700
From: Brian Rogers <brian_rogers@comcast.net>
MIME-Version: 1.0
To: Mario Limonciello <mario_limonciello@dell.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: SCO headset not working with 4.12
References: <48EB9FCF.6070907@dell.com>
In-Reply-To: <48EB9FCF.6070907@dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mario Limonciello wrote:
> Hi:
>
> I recently upgraded to bluez-4.12 and added in the SCO patch that came
> shortly after the 4.12 release.  It seems that my SCO headset is
> connecting, and receiving commands for volume levels, etc, but doesn't
> actually play back any audio.  I was trying to use the test/hstest app
> to verify like this:
>
>     ./hstest play /usr/share/sounds/alsa/Front_Center.wav
>     00:19:7F:30:47:AB 1
>     Voice setting: 0x0060
>     RFCOMM channel connected
>     SCO audio channel connected (handle 1, mtu 64)
>
> It just idles there sitting at that until I hit ctrl-c.  I've attached
> bluetoothd -nd output as well.
>   
I've noticed this as well with the bluez 4.12 build that's currently 
included in Intrepid. My test is to output to the headset using mplayer 
and the alsa plugin. It doesn't always fail to start playing, but when 
it does fail I get the same endless delay. But with a few tries, 
sometimes requiring a restart of headsetd, it will eventually start 
working, and it usually continues to work.

My Bluetooth device is this:
Bus 003 Device 004: ID 0a5c:2101 Broadcom Corp. A-Link BlueUsbA2 Bluetooth

And my headset is the Jabra BT350.

