Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connection Timeout
Message-ID: <20041030102213.GA517280@kosh.hut.fi>
Reply-To: bluez-users@lists.sourceforge.net
References: <1099090255.12760.26.camel@athene.covidimus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099090255.12760.26.camel@athene.covidimus.net>
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
Date: Sat, 30 Oct 2004 13:22:13 +0300

On Fri, Oct 29, 2004 at 05:50:55PM -0500, Stephen Quattlebaum wrote:
> usbview shows the dongle with the name "Wireless Radio for Bluetooth",
> and its name is in red, which I've been led to believe means that no
> drivers have attached themselves to the device.  I don't know if that's
> important here or not.  I'd paste in the usbview output but usbview
> appears to not support whatever flavor of cut-and-paste gnome uses.

Try lsusb as root.
# lsusb --vv

// jouni




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
