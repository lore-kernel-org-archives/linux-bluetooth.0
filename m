Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100371962.6564.4.camel@localhost>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>  <1099942733.5806.7.camel@localhost>
	 <1099943605.29330.21.camel@pegasus>  <1100326156.6216.29.camel@localhost>
	 <1100350419.7349.43.camel@pegasus>  <1100371962.6564.4.camel@localhost>
Content-Type: text/plain
Message-Id: <1100372735.21403.1.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 13 Nov 2004 20:05:35 +0100

Hi Matthew,

> Actually, maybe could a new release should be done for this?  It fixes a
> lot of boot script problems on big-endian systems with things not being
> shutdown properly for hidd.  I have observed that not having BT
> connections cleanly closed off upsets my Apple keyboards.

you are two days too late. I just released a new library version and
there are other things that should be done first before I will release
another version. However I think Edd will include the fix in the Debian
package and this should be enough.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
