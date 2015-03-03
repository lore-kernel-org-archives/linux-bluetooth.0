Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJZ8O2FFrj-ycxjGKZb_C7ew3=A_UdoDry4Jfso0Z_s-w@mail.gmail.com>
References: <CAPygXWLHcbw_qYA2bk9T9hSCABN-kwPQyPZeH_sedWo+-e50DA@mail.gmail.com>
 <CABBYNZJZ8O2FFrj-ycxjGKZb_C7ew3=A_UdoDry4Jfso0Z_s-w@mail.gmail.com>
From: Rich Rath <rath@way.net>
Date: Mon, 2 Mar 2015 23:44:43 -1000
Message-ID: <CAPygXWKD4RMmZ-OPT6ZDSPFvwtt0+eB4LXaBmZC3iRDJrSzivA@mail.gmail.com>
Subject: Re: unable to get bluez to recognize apple magic trackpad by name
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 2, 2015 at 10:52 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> You can check with bluetoothctl if the name is set, using command info.
>

this returned:
Alias: Apple Touchpad
Class: 0x002594
Icon: input-tablet
Paired: yes
Trusted: yes
Blocked: no
Connected: yes
LegacyPairing: yes
UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
Modalias: usb:v05ACp030Ed0160

BUT PLZ NOTE "Apple touchpad" is the alias I supplied via testdevice,
which would probably go away if I rebooted.  the name in dmesg and
/proc is  [Apple Wireless Trackpad]

> Have you tried with anything more recent than 3.14,
oops, forgot this info.  running fully up-to-date Manjaro stable
(based on Arch but a week or two behind).  current kernel is
3.16.7.7-1.  I have access to 3.18.7-1 and 3.19.0-1 but I would have
to install.  let me know if you want this and which one.

> also make sure you
> have an up to date version of bluetoothd.

doh.
bluez is version 5.28-1 which I assume will be the version for bluetoothd.

sorry for not providing basic info in the first place.

Rich
