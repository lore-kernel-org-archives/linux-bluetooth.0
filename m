Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth PCMCIA progress...
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <B7A120329D087840A54E2A221FCCE8D0747334@PSCMAIL01.rochester.itsphoenix.com>
References: 
	 <B7A120329D087840A54E2A221FCCE8D0747334@PSCMAIL01.rochester.itsphoenix.com>
Content-Type: text/plain
Message-Id: <1116581734.8970.7.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 20 May 2005 11:35:34 +0200

Hi John,

> I am using the 3COM 3CRWB6096B ver 3 card in a arm-linux system. I
> insert the card and see two serial ports come online  ttyS03 and
> ttyS04. When I   "hciattach ttyS3 any" and then "hciconfig -a" I can
> see that the hci_uart driver has attached as an hci0 device...but the
> card BD address is all zeros. If I try to "hciattach ttyS3 3com"  the
> command always returns with "Initialization timed out". Do I need to
> update/enter a CIS somewhere for this device?   "cardctl ident"
> returns with correct info for this card.  "hciconfig hci0 up" fails
> with "Can't init device hci0: Connection timed out (110) "

that is no progress. The "any" method is only dump. What about trying a
2.6 kernel?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
