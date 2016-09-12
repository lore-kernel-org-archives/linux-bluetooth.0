Return-Path: <jerome.debretagne@gmail.com>
Message-ID: <1473712975.3667.81.camel@gmail.com>
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Sep 2016 22:42:55 +0200
In-Reply-To: <1C6C9A5E-3E82-4BC0-8FE1-CA72722B5EE1@holtmann.org>
References: 
	<CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
	 <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org>
	 <1473283543.3400.48.camel@gmail.com>
	 <57368BCF-67A1-416C-A4DF-19289E7E06A8@holtmann.org>
	 <1473372206.3263.39.camel@gmail.com>
	 <1C6C9A5E-3E82-4BC0-8FE1-CA72722B5EE1@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> > [...] For that part, I will continue my investigations off the list as
> > I've found blogs / articles explaining several solutions and how to do
> > it using systemd for instance.
> > 

I've shared my results so far here on StackExchange:

http://unix.stackexchange.com/questions/309219/how-to-enable-bluetooth-autom
atically-at-boot-for-recent-intel-and-broadcom-ch/309263#309263

To sum up in a few words:
1/ launching btattach from a udev rule enables Bluetooth but it gets killed.
2/ launching btattach via systemd works, only when adding a few sec delay.
3/ launching the systemd service from 2/ directly via udev, using the exact
same trigger conditions as in 1/ ends up with Bluetooth not working...

What leaves me really puzzled is the difference between 1/ and 3/, as they
launch exactly the same command at almost the same time during the boot
process, but they give a different result in a 100% reproducible way.

In both cases I can see btattach launched (when checking with $ ps auxw) and
the firmware properly loaded (from $ dmesg) but in scenario 3/ Bluetooth is
simply stuck. I need to kill the existing btattach and trigger a new one to
have Bluetooth working.

That's what gave me the idea to try and add a delay leading to option 2/. I
wasn't really expecting this to work as I had the feeling that launching
btattach from systemd wasn't working for other reasons but that wasn't the
case. I am using this setup 2/ currently and it is doing the job quiet well.

I just don't like this ugly hack and would like to better understand what's
going on, to replace the random delay with the real needed pre-condition to
load btattach "at the right time". So far, my udev rule is simply looking
for the "BCM2E55:00" device event. I've looked at the btattach source code
quickly but I didn't find any clear reference saying what's needed for
btattach to work during the boot sequence.

Do you have any clues or suggestions that I could try on my system?


> we could add a --daemon mode into btattach that can be just started at
> boot and then monitors udev to auto-attach devices.

Coming back to your proposition, if I interpret it correctly, I don't think
that Linux distributions would like the idea of launching btattach as a
daemon (when and in which case?) to then auto-attach devices via udev later
on if needed (on which condition? The above one? With the same timing
issue?). That would add one more dependency. It seems backwards to me, as
udev or systemd monitoring are designed to be the trigger and that's what
I've assessed and got working based on your earlier suggestion.

Once the above boot sequence order / timing dependency is solved, I have the
feeling that option 3/ will be the way to go.

btattach doesn't seem to need such a modification as it is working perfectly
fine as-is. It just needs to be properly integrated within the existing
distro stack. And with serial bus enumeration in-kernel in the future, all
of this will disappear of course :-)

Regards,

Jérôme
