Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Oops in hci_usb
From: Marcel Holtmann <marcel@holtmann.org>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040503193747.GA21331@kos.to>
References: <20040501173626.GA3866@kos.to> <1083587205.4666.0.camel@pegasus>
	 <20040503193747.GA21331@kos.to>
Content-Type: text/plain
Message-Id: <1083686495.4666.39.camel@pegasus>
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
Date: Tue, 04 May 2004 18:01:35 +0200

Hi Riku,

> > do you enabled CONFIG_BT_HCIUSB_SCO in your kernel? If yes, disable it
> > and try again.
> 
> Thanks for everyone for help!
> 
> Getting rid SCO option and updating to 2.6.6-RC3 makes the bluetooth 
> on x40 work like a charm, no more oops and pairing worked first try. 
> I can try 2.6.6-RC3 with CONFIG_BT_HCIUSB_SCO if you want to track 
> the problem deeper. 

please do so, because actually I don't know why it happens. Do anyone
with an AVM BlueFRITZ! USB and the bfusb driver have seens this oops? I
don't get the point what it has to do with the ISOC URB's.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
