Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with OBEX Object Push Service Description
From: Edd Dumbill <edd@usefulinc.com>
To: beichuang@yahoo.com
Cc: BlueZ Users List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040202045646.51663.qmail@web40406.mail.yahoo.com>
References: <20040202045646.51663.qmail@web40406.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1075744909.5080.20.camel@saag>
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
Date: Mon, 02 Feb 2004 18:01:49 +0000

On Mon, 2004-02-02 at 04:56, beichuang wrote:
> Anyone can find the reason why it is not interoperable
> with my iPAQ? I can just not find any error with the
> comparison with another working OBEX server.

It may be that you need the object exchange bit set in your device
service class.  Try running hciconfig hci0 class 0x100100 and trying
again.  You can make this setting permanent in hcid.conf.

-- Edd




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
