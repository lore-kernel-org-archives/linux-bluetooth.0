Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4562367E.90409@xmission.com>
Date: Mon, 20 Nov 2006 16:13:02 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1163882230.3025.18.camel@TesterBox.tester.ca>	<1164011400.28397.12.camel@localhost>	<4561F690.3040608@gmail.com>	<4561FE99.1030201@xmission.com>
	<45622169.3020708@gmail.com>
In-Reply-To: <45622169.3020708@gmail.com>
Subject: Re: [Bluez-devel] Gumstix / speed setting in Infineon PBA31308
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brian

> Do you know if the gumstix's NSSP is visible in userspace?

yes but you'll have to dig into the wiki to get the details and the
results may be subpar even running as root with a negative nice value.

 I might have
> a poke around in the kernel and try and get the audio stream working. 
> (there looks to be some docu in the kernel about it).  I think 
> carwhisperer can get a SCO session open at least (I think). might play 

You open an rfcomm connection to the headset and use some AT commands to
do things. It's really quite simple (get the headset profile docs at
bluetooth.com)

> with that. Is your 'scoot' program available? Do you have any pointer so 
> more documentation on this stuff? If the audio is streamed direct to the 

I won't write scoot after all... we're putting things together in a more
general way.

> CPU once sco is opened, why is it necessary for the hci connection to 
> run at 912k ? Is there a choice of whether to take the audio from hci or 
> direct from pcm then?

it's not necessary for sco. 921k would be nice for stereo audio.

on csr adapters it's well known how to kick them back and forth between
pcm and hci for sco but I don't know about this adapter.

Brad


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
