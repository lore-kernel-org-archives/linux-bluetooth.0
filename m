Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket Rev H?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051007150204.GA18594@suave.net>
References: <20051007150204.GA18594@suave.net>
Content-Type: text/plain
Message-Id: <1128774980.5212.6.camel@blade>
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
Date: Sat, 08 Oct 2005 14:36:20 +0200

Hi Anthony,

>   I have been looking all around and going crazy. It seems like 
> every time I buy Linux supported hardware the manufacturer has
> upped the revision to screw my compatibilty (WRT54GS, PVR-150, now
> the socket card, sigh).
> 
>   As far as I can tell this card does work, but I am having trouble
> finding directions on which incantation I need to perform the proper
> magic.
> 
>   I am trying to put it on a Zaurus SL-5500 running OpenZaurus 3.5.3
> which has a 2.4x kernel in it.
> 
>   Can someone point me in the right direction, please? 

the revision H of the card should work with the serial_cs driver and
then you have to use the hci_uart driver and hciattach to make this card
known to the Bluetooth core.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
