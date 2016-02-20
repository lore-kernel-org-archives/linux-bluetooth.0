Return-Path: <tore@fud.no>
Date: Sat, 20 Feb 2016 21:30:28 +0100
From: Tore Anderson <tore@fud.no>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160220213028.35760428@envy.w5.y.home>
In-Reply-To: <20160220182919.GA2620@t440s.P-661HNU-F1>
References: <20160220181259.1e28f8da@envy.w5.y.home>
	<20160220182339.GA1648@t440s.P-661HNU-F1>
	<20160220182919.GA2620@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Do you see the same issue if you don't use blueman? (a piece of
> > software I'm not really familiar with).

If I disable or uninstall blueman, the mouse doesn't come back to life
after a suspend/resume (or initial bootup) until I manually issue
"hciconfig hci0 up". This is the case for both pre- and post-2ff1389
kernels.

> > What exactly do you do when you say you "manually disable and then
> > re-enable bluetooth"? "btmgmt power off; btmgmt power on"?
> > bluetoothctl power off/on? Something else?

I right-click the blueman systray icon, and it pops up a meny where I
can select either =C2=ABTurn Bluetooth Off=C2=BB or =C2=ABTurn Bluetooth On=
=C2=BB (only one
of the options are shown, depending on blueman's idea of the current
status).

> > It'd be important to understand what exactly your user space
> > software (blueman) does when you resume. So any logs that you can
> > take of this would be helpful. You could e.g. take a HCI log using
> > btmon and enable kernel debug logs for the bluetooth module (see
> > Documentation/dynamic-debug-howto.txt in the kernel
> > documentation).

I uploaded debug files to http://filebin.net/pfmb8043cx :

- timestamps.$KVER.txt: my notes of the timestamps of when I did
  specific actions, for easy cross-referencing with the other files.
- blueman-applet.$KVER.txt: output from "blueman-applet |& ts".
- btmon.$KVER.txt: output from "btmon -T".
- kernel-debug-messages.$KVER.txt: kernel output (journalctl -k), after
  having written "module bluetooth +p" to
  the /sys/kernel/debug/dynamic_debug/control file.

Where $KVER is either 4.4.0-rc3-00801-gbf943cb (the last rev where the
bluetooth mouse comes back to life automatically after resume) or
4.4.0-rc3-00802-g2ff1389 (the first rev where it doesn't).

> Another thing to try in addition to disabling blueman: Add
> AutoEnable=3Dtrue under the [Policy] section
> in /etc/bluetooth/main.conf. It might make a difference assuming that
> your Bluetooth adapter gets detached and reattached to the USB bus
> when you suspend/resume.

This made no difference. Note that I had to create that file and its
containing directory anew, it didn't already exist on my Fedora 23
system.

Tore
