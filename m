Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Jun 2013 12:13:38 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
Message-ID: <20130620091331.GA3317@aemeltch-MOBL1>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
 <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org>
 <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, Jun 19, 2013 at 08:18:09PM -0700, Alex Deymo wrote:
> Hi Marcel,
> 
> On Wed, Jun 19, 2013 at 6:04 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Alex,
> >
> >> I'm experiencing a problem that wedges the bluetooth adapter from time
> >> to time. The repro case can be hit with this scenario:
> >>
> >> run bluetoothd
> >> while hciconfig hci0 up && hciconfig hci0 down; do echo -n .; done
> >>
> >> In few iterations you will have a timeout while trying to bring up the
> >> interface. This is just a repro case, the real scenario just happens
> >> from time to time if you for instance restart bluetoothd at the right
> >> (or wrong!) moment.
> >
> > can you give us at least a few details on the kernel you are running and what hardware this is?
> 
> I'm running kernel 3.8.11 on a x86_64 and BlueZ 5.4. The hardware is a
> chromebook (I saw it with different hardware and I can also repro it
> on my ubuntu) that uses the ath9k and ath3k drivers for the wifi/bt
> chip (MD222)
> 
> > If you do not use hciconfig and instead use btmgmt or bluetoothctl, do you see the same issue?
> 
> Using btmgmt I see the same issue with a very similar hcidump (just
> the timing is different).
> while btmgmt power on && btmgmt power off; do echo -n; done
> btmgmt power on after about 4 iterations is blocked and never returns.
> 
> Using the dbus interface to the running bluetoothd apparently doesn't
> hit the problem (ran fine for a few hundred times)
> while dbus-send --system --print-reply --dest=org.bluez
> /org/bluez/hci0 org.freedesktop.DBus.Properties.Set
> string:org.bluez.Adapter1 string:Powered variant:boolean:true &&
> dbus-send --system --print-reply --dest=org.bluez /org/bluez/hci0
> org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
> string:Powered variant:boolean:false; do echo -n; done

The D-Bus interface is very slow so you never face race condition.

Best regards 
Andrei Emeltchenko 
