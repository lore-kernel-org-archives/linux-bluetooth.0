Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FEDD73.7090109@cloutier-vilhuber.net>
From: Lars Vilhuber <lists.all@cloutier-vilhuber.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] experience with TDK PCMCIA Bluetooth Card, (goBlue)?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 31 Jan 2005 20:37:55 -0500

>>> config.opts AND bluetooth.conf (one may be redundant):
>>> card "TDK goBlue PCMCIA Bluetooth Adapter"
>>> ~  manfid 0x0105,0x4254
>>> ~  version "TDK","Bluetooth PC Card II","",""
>>> ~  bind "serial_cs" class "bluetooth"
>>> 
>>> and adding an elif condition in /etc/pcmcia/bluetooth conditional on MANFID.
> 
> this looks like a new generation of the card. 

I believe the right link is

http://www.tdksystems.com/products/intro.asp?id=3

I bought it here:

http://www.expansys-usa.com/product.asp?code=106260

 > Please post the output of
 > dump_cis.
 >

Socket 0:
   dev_info
     NULL 0ns, 512b
   manfid 0x0105, 0x4254
   funcid unknown [post]
   vers_1 7.1, "TDK", "Bluetooth PC Card II", "", ""
   config base 0x00f8 mask 0x000f last_index 0x04
   cftable_entry 0x03 [default]
     [rdybsy]
     Vcc Vnom 5V
     io 0x01e0-0x01ef [lines=8] [8bit] [range]
     irq mask 0xffff [level] [shared]
   cftable_entry 0x04
     io 0x0000-0x7fff [lines=15] [8bit]

Looks like it is new...

Let me know - if it is new, I will just give it to a Windows-only 
colleague - I need it on a machine where I do not want to run 
non-distribution kernels (I would on another machine, but that's not a 
laptop...), but let me know either way. I'll be happy to run a couple of 
tests until then.

lars
-- 
Lars Vilhuber                    lists.all@cloutier-vilhuber.net


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
