Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Billionton CF card (bt950)
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050307153436.GB13771@fuchi>
References: <20050307153436.GB13771@fuchi>
Content-Type: text/plain
Message-Id: <1110392099.10620.272.camel@justakiss>
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
Date: Wed, 09 Mar 2005 19:14:59 +0100

Am Mon, den 07.03.2005 schrieb Sebastian Henschel um 16:34:
> howdy folks...
> 
> i have a CF card from Billionton here with the P/N CFBT02-B2.
> cardctl ident reveals:
>     product info: "Compact Flash", "Bluetooth Card", "", ""
>     manfid: 0x0279, 0x950b
>     function: 2 (serial)
> 
> /etc/pcmcia/bluetooth.conf reads:
>     card "Billionton Bluetooth Card"
>         version "Compact Flash", "Bluetooth Card"
>         bind "serial_cs"
> 
> having read in the archives, bt950_cs and btuart_cs should not be used
> nowadays, but serial_cs with the combination of hciattach. you
> should forget about the other two, right?

Hi,
your card has the same manufacturer/device id as the Conceptronic
CBT100C. Try serial_cs and "hciattach ttyS.. bcsp"

Regards,
Erwin



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
