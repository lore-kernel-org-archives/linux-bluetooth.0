Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <51100E6E.8070804@kamens.us>
References: <51100E6E.8070804@kamens.us>
Date: Sun, 24 Feb 2013 10:59:29 -0400
Message-ID: <CAJdJm_MsOBOGTBoG+Nua49DbwuXx5Pu5KRm9zMp2ma3_nhF2CQ@mail.gmail.com>
Subject: Re: HFP/HSP Telephony profile doesn't work with Bluetooth USB dongle
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jonathan Kamens <jik@kamens.us>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonathan,

On Mon, Feb 4, 2013 at 3:39 PM, Jonathan Kamens <jik@kamens.us> wrote:
> Greetings,
>
> Using Fedora 18 x86_64, I've tested two different USB Bluetooth dongles
> (cheap generic Cambridge Silicon and more expensive BlueRigger BTD-400) and
> two different headsets (Motorola SF600, BrainyTrade BH-M20), in all
> combinations, the A2DP High-Fidelity profile for audio output works, but the
> HFP/HSP Telephony profile does not.

More details on which steps you take to reproduce the problem should
help identifying the issue.

Also run "sudo hcidump -w hcidump.dump"  while you do these steps and
attach the generated hcidump.dump to your email so we can see what's
going on.

> I contacted BlueRigger about this and they tested for themselves on
> different hardware and got the same result. BlueRigger says the HFP/HSP
> Telephony profile works fine with Ubuntu, which they say doesn't use Bluez.

Ubuntu (as pretty much every Desktop Linux distro, as far as I know)
uses BlueZ. The only difference is that distros may use different
BlueZ and/or kernel versions and this may cause different levels of
hardware support.

> I don't know if this problem is new in Fedora 18, because I didn't get the
> dongles until after I upgraded from Fedora 17.

My suggestion is for you to download a Live CD/USB for Ubuntu (ideally
for the version BlueRigger tested) and confirm yourself it works.

> I've reported this in Red Hat bugzilla
> <https://bugzilla.redhat.com/show_bug.cgi?id=905283> and emailed the Fedora
> test list
> <http://lists.fedoraproject.org/pipermail/test/2013-February/113598.html>
> about it; there has been no response to either.
>
> Any suggestions or insights into how to resolve this issue would be
> appreciated.

Again, you need to provide more information:

* hcidump log (as explained above)

The information below is also important because not everyone here uses
Fedora 18:
* kernel version ("uname -r")
* bluez version ("bluetoothd --version", or at least the package
version from the distro).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
