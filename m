Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BlueZ and the ALSA support
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A11275.1090108@dark-reality.de>
References: <1100995285.7250.17.camel@pegasus>
	 <41A027BD.5020401@xmission.com> <1101057242.7250.34.camel@pegasus>
	 <41A0D34C.8070400@dark-reality.de> <1101061573.7250.68.camel@pegasus>
	 <41A0F6F4.6070707@dark-reality.de> <1101069548.7250.77.camel@pegasus>
	 <41A11275.1090108@dark-reality.de>
Content-Type: text/plain
Message-Id: <1101077143.7250.83.camel@pegasus>
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
Date: Sun, 21 Nov 2004 23:45:43 +0100

Hi Lars,

> | To be honest, I don't know. This ISOC stuff is still a mystery to me and
> | so far I don't know of any Linux driver that is using the ISOC transfers
> | and have to change the alternate setting at the same time. Selecting it
> | at probe() time is very easy.

> Maybe we simply have to try what happens *shudder*... any ideas whom we
> could ask for more information? linux usb devlist?

when you try, expect kernel freezes or crashes. The only place to ask is
the Linux USB developer mailing list, but I think we should first clean
up our URB management mess.

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
