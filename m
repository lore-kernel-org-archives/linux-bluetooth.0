Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050501141626c62c35@mail.gmail.com>
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
	 <e1effdeb05042905267bc91413@mail.gmail.com>
	 <1114778617.8836.88.camel@pegasus>
	 <e1effdeb0504291520167b9bb8@mail.gmail.com>
	 <1114819470.8836.124.camel@pegasus>
	 <e1effdeb050501141626c62c35@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114989490.21785.80.camel@pegasus>
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
Date: Mon, 02 May 2005 01:18:10 +0200

Hi Claudio,

> I suggested provide a DBUS message service in another
> level because I will try contribute with NetworkManager
> project:
> http://people.redhat.com/dcbw/NetworkManager/index.html

then this is not about D-Bus integration. What you need is to make the
NetworkManager daemon capable of dealing with Bluetooth PAN connections.

> I will analyze these two approachs and define the most
> interesting solution for my project.

Both parts are fine with me, but the NetworkManager thing should be done
outside of the BlueZ utilities.

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
