Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CF cards
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Valvatne <jon@valvatne.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1086292123.4353.27.camel@m117a.studby.ntnu.no>
References: <1086292123.4353.27.camel@m117a.studby.ntnu.no>
Content-Type: text/plain
Message-Id: <1086300734.4424.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 04 Jun 2004 00:12:14 +0200

Hi Jon,

> I'm in the market for a CF card for my laptop (Thinkpad X30, built-in CF
> slot), and after checking the hardware support list on bluez.org I had
> decided on the Socket card, since that was one of the few I could find
> in my country.
> 
> But in the archives of this list I stumbled across a few mentions of
> that card not working with the 2.6 kernel. Is this still true? Has there
> been any progress on solving that problem?
> 
> Alternately, is there any chance the Billionton (CFBT02) or Dell
> (Truemobile 300) cards are supported or will be supported in the near
> future?

actually the Socket card 2.5 is an excellent choise, because of their
size and its CSR based Bluetooth chip. But as you already read in the
archives there are some problems. With 2.6 some serial cards work and
some don't. I guess that this is a problem in the new serial layer of
2.6. So choosing the right card will be a non-trivial problem, because
most of them are serial based and you can't be sure that they work until
you tested them. If you don't care what Bluetooth chip is used I suppose
that you go with the Anycom CF card (bluecard_cs driver).

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
