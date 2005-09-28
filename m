Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Itzhak Ben-Akiva <benakiva@gmail.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1127914574.2662.22.camel@hexa0xfb>
Mime-Version: 1.0
Subject: [Bluez-devel] problems with AnyCom CF-300 on ARM920 Integrator/AP
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
Date: Wed, 28 Sep 2005 16:36:14 +0300

Hi everybody,

I'm having a very hard time trying to make bluetooth work on the ARM
Integrator/AP platform.

Initially, I had a problem with pccard that was not recognized by pcmcia
yenta_socket. Then, Russell King (ARM Linux Maintainer) provided my a
patch that solved this problem.

Then, now pccard bus works properly. PCMCIA system recognizes my card:
Socket 0:
  product info: "BTCFCARD", "LSE139"
  manfid: 0x0264, 0x000b
  function: 6 (network)

However, bluecard_cs fails to allocate IO regions.

Has anybody same similar problems on ARM? Is there anyone working with
AnyCom CF-300 card?

I'd appreciate any hint/help that could help me solve this problem.

Thanks,
Itzhak



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
