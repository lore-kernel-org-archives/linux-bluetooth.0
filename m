Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?iso-8859-1?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] name cache
References: <1064593223.12843.127.camel@saag> <200401292119.45926.bluez-devel@schaettgen.de> <1075486241.14644.34.camel@akka.yeti.nocrew.org>
In-Reply-To: <1075486241.14644.34.camel@akka.yeti.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401301949.18712.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 30 Jan 2004 19:49:18 +0100

On Friday 30 January 2004 19:10, Fredrik Noring wrote:
> Similar to the idea with /etc/bluetooth/keytab.socket, additional
> sockets can be created for other Bluetooth interface services such
> as name scans, lookups etc. Regular users have access to these
> capabilities based on socket file permissions.
..
> Command examples:
>    SCAN            - Returns something similar to "hcitool scan"

This would only duplicate interfaces, since you can do it via HCI already.

>    LOOKUP <bdaddr> - Returns the name if available in the names file
>    DELETE <bdaddr> - Removes the name from the names file
>    LIST            - Lists all names in the names file

LIST should return the list of all seen addresses, since names are not 
necessarily unique. Additionally there could be something like RESOLVE_NAME 
"<name>" and LAST_SEEN <bdaddr>..
Just like the key management it might be cleaner to use DBUS for it.

greetings
Fred



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
