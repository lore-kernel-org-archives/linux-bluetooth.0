Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cuso8n$4g1$2@sea.gmane.org>
References: <cusgdr$4g1$1@sea.gmane.org> <4211C910.1020204@dark-reality.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <4211C910.1020204@dark-reality.de>
Subject: [Bluez-devel] Re: snd-bt-sco built-in
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
Date: Tue, 15 Feb 2005 13:02:52 +0100

Hi Lars,

thanks for your fast reply!

 > | I'm trying to build snd-bt-sco directly into the kernel.
 >
 > why?
I'm working on a project in which a "communication-server" should use
bluetooth headsets...
So I want to have the kernel with all functions built-in. If this is
not possible I'll have to load it on startup. ;-(


 > I can't tell for sure why this function is failing this way. Did you
 > build snd-hw-dep and put it in the kernel, too? If it's missing than
 > that could be the problem.
That was my first guess too! But it's built-in

grep SND /boot/config-2.6.10-mh4-sr1 | grep -v "^#"
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_EMU10K1=y
CONFIG_SND_USB_AUDIO=y
CONFIG_SND_BT_SCO=y


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
