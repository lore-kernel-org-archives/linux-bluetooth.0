Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] experience with TDK PCMCIA Bluetooth Card,
	(goBlue)?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41FE5D06.8080304@cloutier-vilhuber.net>
References: <41FE5D06.8080304@cloutier-vilhuber.net>
Content-Type: text/plain
Message-Id: <1107191122.7902.29.camel@pegasus>
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
Date: Mon, 31 Jan 2005 18:05:22 +0100

Hi Lars,

> ... after some filling up of /etc/pcmcia/ config files... yes. The lists
> helped on that:
> 
> config.opts AND bluetooth.conf (one may be redundant):
> card "TDK goBlue PCMCIA Bluetooth Adapter"
> ~  manfid 0x0105,0x4254
> ~  version "TDK","Bluetooth PC Card II","",""
> ~  bind "serial_cs" class "bluetooth"
> 
> and adding an elif condition in /etc/pcmcia/bluetooth conditional on MANFID.

this looks like a new generation of the card. Please post the output of
dump_cis.

> I should note that most everything works in principle:
> 	- I can browse services of other devices using this card
> ~        - I can receive browse requests from other devices
> ~          (T610, Palm T3)
> ~        - I can receive/send *small* data chunks (vcard, etc.)
> 	- I can *not* receive/send larger data chunks (jpeg)
> ~          or streams of data (PPP connection)
> 
> It all breaks apart at the short packet/bcsp/etc.

Sounds like a bug in the BCSP driver. Maybe this card uses a variant of
BCSP that the driver can't handle.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
