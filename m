Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid updated
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200311101225.09925.cijoml@volny.cz>
References: <20031106014519.GA31868@schnell>
	 <1068109845.1288.153.camel@pegasus>  <200311101225.09925.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1068465144.31420.18.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 10 Nov 2003 12:52:24 +0100

Hi Michal,

> > Let's talk a little bit about the freezing of the Microsoft devices,
> > because I already solved this for my own HID implementation, but I
> > forgot to share my knowledge. The mouse and the keyboard drop both L2CAP
> > connections after 12 minutes of idle time and try to disconnect the ACL
> > link after that, but on the Linux side we don't handle this correctly.
> 
> Maybe M$ handle it incorrectly on theit side :)

I don't think that this is a Microsoft problem, because it works fine
with the XP Bluetooth stack and the keyboard and mouse are running the
HID implementation from CSR.

> > Keeping the HID device alive with some kind of pinging is not a good
> > idea, because it consumes to much power ;)
> 
> For now I prefer working solution if non other and better is known...

Try to include my approach into the code from Peter and see if it works
for you.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
