Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1257341369.23167.149.camel@localhost.localdomain>
References: <f9d2a5e10911040014p238a14lb14a1a3d45942e44@mail.gmail.com>
	 <1257341369.23167.149.camel@localhost.localdomain>
Date: Wed, 4 Nov 2009 19:13:57 -0700
Message-ID: <f9d2a5e10911041813r36675253n9e0b6b81bd6b1055@mail.gmail.com>
Subject: Re: Bluetooth audio via pulse doesn't function unless I chant the
	magic incantations
From: Russ Dill <russ.dill@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 4, 2009 at 6:29 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Wed, 2009-11-04 at 01:14 -0700, Russ Dill wrote:
>> I have ubuntu lucid (its just karmic+2.6.32-rc5) and I can only get
>> pulseaudio to detect my Sony DR-BT50 headset if I send some dbus
>> commands:
>>
>> addr=00:1a:80:67:63:2c
>> hci=$(dbus-send --print-reply --system --dest=org.bluez /
>> org.bluez.Manager.DefaultAdapter | tail -n 1 | cut -f 2 -d '"')
>> dev=$(dbus-send --print-reply --system --dest=org.bluez $hci
>> org.bluez.Adapter.FindDevice string:$addr | tail -n 1 | cut -f 2 -d
>> '"')
>> dbus-send --print-reply --system --dest=org.bluez $dev org.bluez.Audio.Connect
>>
>> Additionally, the device shows up under the gnome bluetooth-properties
>> applet under "Known devices" with the gold star and the keys. The
>> connected plug doesn't appear until I exec the above commands.
>> Clicking the plug without the above commands does nothing.
>
> You're using bluez-gnome (or possibly an old version of
> gnome-bluetooth). Make sure you use the latest version (2.28.3).
>
> Cheers
>

Thank you for the awesomeness.

Next question, I get events from keypresses on the headset via a
/dev/input/eventX file, but how do I do things with those events?
