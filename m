Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05050208322febd0bf@mail.gmail.com>
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
	 <e1effdeb05042905267bc91413@mail.gmail.com>
	 <1114778617.8836.88.camel@pegasus>
	 <e1effdeb0504291520167b9bb8@mail.gmail.com>
	 <1114819470.8836.124.camel@pegasus>
	 <e1effdeb050501141626c62c35@mail.gmail.com>
	 <1114989490.21785.80.camel@pegasus>
	 <e1effdeb05050208322febd0bf@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1115051077.21785.133.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 02 May 2005 18:24:37 +0200

Hi Claudio,

> After analyze both approachs and consider the future enhancements
> for BlueZ, implement DBUS  service at BlueZ level can be better
> because it open a new perspective, local services can provided:
> - dial-up networking
> - business card exchange
> - fax
> - file transfer
> - headset
> - audio gateway
> - ...
> 
> This is very interesting for embedded environment because
> only the assigned application will handle the request/notifications.
> 
> Regarding the service name, I suggest:
> "org.bluez.pand"
> Is it fine for you?

the name is fine with me.

> Do you want a macro to enable this feature at
> build time?

Follow the hcid example. The configure script already detects if D-Bus
is available or not.

Make sure that the current tasks (--connect and --listen) of pand are
working the same and use --dbus for starting a pand with a D-Bus
interface.

Keep all the D-Bus specific things in a separate files.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
