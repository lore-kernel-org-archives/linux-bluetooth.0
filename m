Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cut6je$4g1$3@sea.gmane.org>
References: <cusgdr$4g1$1@sea.gmane.org> <4211C910.1020204@dark-reality.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <4211C910.1020204@dark-reality.de>
Subject: [Bluez-devel] Re: snd-bt-sco built-in (solved)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 15 Feb 2005 17:07:33 +0100

Hi,

I found the problem! To built it into the kernel I added a directory
under sound called bluetooth. Getting the make-system to compile the
module you have to add this path to sound/Makefile:

cat /usr/src/linux/sound/Makefile
...
obj-$(CONFIG_SND) += bluetooth/ core/ i2c/ drivers/ isa/ pci/ ppc/ arm/
synth/ usb/ sparc/ parisc/ pcmcia/
...

Really don't know why but I've put it in the first position (before
core). This leads to the problem that on bootup ALSA isn't initialized
yet when snd_bt_sco is trying to use it. oops...


cat /usr/src/linux/sound/Makefile #(correct one!)
...
obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/
usb/ sparc/ parisc/ pcmcia/ bluetooth/
...

Now the kernel boots up! A brief test with one of the headsets was ok!

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
