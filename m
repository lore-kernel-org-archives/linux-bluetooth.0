Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth connection goes down
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657604111621221753c870@mail.gmail.com>
References: <2de46576041116061851f9e35f@mail.gmail.com>
	 <1100616835.7235.13.camel@notepaq>
	 <2de4657604111621221753c870@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100673743.7208.125.camel@pegasus>
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
Date: Wed, 17 Nov 2004 07:42:23 +0100

Hi Manjunath,

> 1> i am using the hcitool to get the rssi, lq and tpl
> values........hcitool gives me these values only after a "cc" to my
> neighbor BT device. Is there some other method to get these values????
> Also, are there any other performance parameters specific to BT i can
> measure, like delay??

the RSSI, link quality and transmit power level commands of hcitool also
work when you created the connection through L2CAP etc. If you confuse
your Bluetooth chips with creation and termination of the low level HCI
connection then it is your fault.

> 2> I am using linux kernel 2.6.6 and currently available bluetooth
> debian packages.

Update to at least 2.6.9-mh3 or use 2.6.10-rc2.

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
