Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Network Access Point - pairing problem
Message-ID: <20041104134346.GA207615@kosh.hut.fi>
References: <7166.1099563749@www18.gmx.net> <1099566332.7022.12.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099566332.7022.12.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 4 Nov 2004 15:43:46 +0200

Hi MH,

On Thu, Nov 04, 2004 at 12:05:32PM +0100, Marcel Holtmann wrote:
> > > HCI Event: PIN Code Request(0x16) plen 6
> >   B0 3A 4C 3D 0F 00 
> > < HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
> >   B0 3A 4C 3D 0F 00 05 42 6C 75 65 5A 00 00 00 00 00 00 00 00 
> >   00 00 00 
> 
> The PIN code you entered is simply wrong. Try "BlueZ".

btw, what and where is the tried PIN code in that hex dump? B0 3A 4C 3D 0F 00
is obviously Bluetooth address of the remote host, so somewhere here
is the PIN code "05 42 6C 75 65 5A 00 00 00 00 00 00 00 00 00 00 00",
but how it is encoded?

// jouni



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
