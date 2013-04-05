Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <515EBB91.1020006@start.ca>
References: <515EBB91.1020006@start.ca>
Date: Fri, 5 Apr 2013 14:16:50 +0200
Message-ID: <CANT-zCVRwyR9de4gHp5+ur3_oDcMnL4RttQFayBmUKYUrgJODA@mail.gmail.com>
Subject: Re: Bluetooth pulseaudio multiple device entries
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Colin Beckingham <colbec@start.ca>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Fri, Apr 5, 2013 at 1:54 PM, Colin Beckingham <colbec@start.ca> wrote:
> Good day: using Opensuse 12.3 with standard desktop kernel from repo,
> pulseaudio under Gnome.
>
> Steps to reproduce:
> 1. clean boot of machine.
> 2. USB Bluetooth adapter Belkin which works reliably
> 3. Issue command as root "hciconfig 0 sspmode 0" - this is essential
> otherwise bluetooth device not recognized.
> 4. Open gnome sound settings from user menu; onboard sound device is
> present, only one entry
> 5. switch on bluetooth device Samsung WEP 475
> 6. device is recognized and paired, an entry appears in PA list
> 7. about 10 sec later a second entry for the same BT device appears in the
> list
> 8. after playing with the windows sometimes the second entry will go away
> 9. at least one of the entries will work and PA shows amplitude changes
> registering for the input device
> 10. sometimes clicking the wrong one will cause Gnome settings window to
> crash, but BT and PA are still running and device is working and gnome
> window can be opened again.
>
> Clearly the multiple entries thing is not normal behaviour.
> Might be a BT issue, or a PA issue, or a Gnome issue or other.
> It's a tossup where where to start, can I rule out the BT side?

Can you specify which versions of BlueZ and PulseAudio you're using?

Also, please check:
a. which modules are loaded during the issue by doing "pactl list
modules" or similar.
b. which bluetooth devices BlueZ registers on D-Bus: "test-device
list"/"bluez-test-device list" or similar. You can alternatively use a
tool such as d-feet.

Cheers,
Mikel
