Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17262.9574.50552.492352@waldo.lisle.iphase.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco + aplay produces only silence on headset
From: bbosch@iphase.com
In-Reply-To: <436DB826.2090406@libero.it>
References: <17261.23534.882674.809679@waldo.lisle.iphase.com>
	<436DB826.2090406@libero.it>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 6 Nov 2005 09:46:46 -0600

jimmi writes:
 > It  looks like  you have  the alsa  module separate:  the bluetooth-alsa
 > page  tells that  you need  "a recent  (2.6.11.7 or  newer) kernel  with
 > *integrated* alsa  enabled", therefore you  cannot use the  debian image
 > but recompile the source.

Actually, I don't use the pre-built Debian kernels.  I'm running
2.6.14-rc4 which I configured and built myself.  I have included the
sound related settings from my .config file. I interpreted the quoted
text above to mean that I should use the version of ALSA which ships
with newer kernels and not the third party alsa project distribution.
I did use ALSA back in 2.4 days before the kernel adopted it but not
for a long time.  Are you saying I also must configure the sound
system _not_ to be built as modules even from the 2.6.14 kernel
source?  In other words, must CONFIG_SND be set to "y" rather than
"m"?

Thanks for the quick response!

--Brad

CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
