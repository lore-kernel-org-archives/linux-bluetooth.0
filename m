Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
In-Reply-To: <20040204015825.GA2217@bougret.hpl.hp.com>
Cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402041223.29088.mtortonesi@ing.unife.it>
Subject: [Bluez-devel] bluez & qos
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
Date: Wed, 4 Feb 2004 12:23:29 +0100


hi to everybody,

	i was trying to do some qos setup tests with bluez and i have seen that there 
is barely no qos support in bluez. it would be nice to develop an 
ioctl(2)-based extension to set up qos on bluez sockets. i have just started  
working on the code. marcel, would you be intested in having qos support for 
bluez?

BTW: i have seen that Jean Tourrilhes (included in cc) has been working on qos 
with CSR chips a while ago. jean, since i have seen no announcements on this 
list i suppose that you haven't production-quality code adding qos support 
for bluez...

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
