Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: JOSERIVERAPONCE@terra.es,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <23917817.1164177063296.JavaMail.root@cps6>
References: <23917817.1164177063296.JavaMail.root@cps6>
Date: Wed, 22 Nov 2006 07:49:55 +0100
Message-Id: <1164178195.23477.20.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] MSWindows bluetooth sniffer?
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

Hi Jose,

> I am looking for a good MSWindows bluetooth protocol sniffer.

you can use the Merlin from LeCroy or FTS4BT from Frontline, but both
solution will be expensive.

If you are lucky there is a Windows equivalent to hcidump, but don't ask
me. I don't use Windows at all.

> I want to launch the bluetooth application that connects to my 
> bluetooth
> mobile phone and be able to see what are they communicating so I can
> write software in Linux to manage that mobile phone.

You can do that without a sniffer. Create the correct SDP records on
another Linux machines and copy the class of device and simple pretend
to be a phone. This way, I hacked most of the secret protocols.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
