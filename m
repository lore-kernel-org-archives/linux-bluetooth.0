Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco - unknown symbol snd_hwdep_new
	undefined!
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200411271059.42204.ruben@hotheads.de>
References: <200411270038.51554.ruben@hotheads.de>
	 <1101524868.6514.67.camel@pegasus>  <200411271059.42204.ruben@hotheads.de>
Content-Type: text/plain
Message-Id: <1101585182.27074.11.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 27 Nov 2004 20:53:02 +0100

Hi Ruben,

> > you may need to make "depmod -e" first or simply load the "snd-hwdep"
> > kernel module.
> 
> The problem is that there doesn't exist a module called snd-hwdep.
> For my last kernel I generated a kernel patch from the cvs kernel module.
> Building only the module that is included in the cvs btsco module doesn't 
> work.

this module is not always built. Select CONFIG_SND_USB_USX2Y and it
should be built.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
