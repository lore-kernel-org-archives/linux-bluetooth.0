Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Config for Socket CF card
From: Marcel Holtmann <marcel@holtmann.org>
To: digger vermont <dv_mlist@verizon.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074566227.3670.24.camel@myrna>
References: <1074566227.3670.24.camel@myrna>
Content-Type: text/plain
Message-Id: <1074597777.7088.2.camel@pegasus>
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
Date: Tue, 20 Jan 2004 12:22:57 +0100

Hi Digger,

> I give up. Its time to look for help.  After too much time I discovered
> that I was trying to use the wrong module (dtl1_cs) and for all the
> threads in the mailing list archives I haven't been able to figure it
> out.  Also keep in mind that anything I've done are wild guesses due to
> desperation :)
> 
> Here's the card I have:
> 
> -------------------------------------------
> product info: "Socket", "CF+ Personal Network Card Rev 2.5"
>   manfid: 0x0104, 0x0096
>   function: 2 (serial)
> -----------------------------------------
> 
> I believe that means I have the infamous revision G.

this is correct ;)

> My laptop is a powerbook G4.  The kernel is 2.6.1-ben1 using devfs.
> 
> Cardmgr seems to starting correctly.  Pcmcia had no config for this card
> or for the hci_uart so I added an entry to /etc/pcmcia/config.opts.  I
> also changed  the port and memory settings for the powerbook.  Is this
> correct?
> 
> ----------------------------------
> device "hci_uart"
>   class "bluetooth" module "hci_uart"
>  
> card "Socket Bluetooth Card"
>   version "Socket", "CF+ Personal Network Card Rev 2.5"
>   manfid 0x0104, 0x0096
>   bind "hci_uart"
> 
> include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
> include memory 0x80080000-0x8008ffff
> -------------------------------------
> 
> When I insert the card this is what I get in the log:

And the above config is wrong. You have to bind your card with the
serial_cs driver, because it is a serial PCMCIA card.

After that you can use "hciattach <dev> socket" to init the Bluetooth
chip on this card.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
