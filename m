Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR BlueCore02
From: Marcel Holtmann <marcel@holtmann.org>
To: "Mateo, Jose-Luis" <Jose-Luis.Mateo@t-systems.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <D971A27FCD3DE04689089E8A98D8AF710361C301@G9JJ1.mgb01.telekom.de>
References: 
	 <D971A27FCD3DE04689089E8A98D8AF710361C301@G9JJ1.mgb01.telekom.de>
Content-Type: text/plain
Message-Id: <1087477969.4968.0.camel@localhost>
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
Date: Thu, 17 Jun 2004 15:12:49 +0200

Hi Jose,

> I can't install a Bluetooth CF Card in SuSE 9.0. The Card is from CC&C, with the Chipset CSR BlueCore02. It is recognized as "Serial or Modem" by SuSE. Which driver must I use?

use hci_uart and run hciattach with the correct settings.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
