Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] baseband characteristics
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576041118021674822573@mail.gmail.com>
References: <2de46576041118021674822573@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100774178.7164.20.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 18 Nov 2004 11:36:18 +0100

Hi Manjunath,

> is it possible to study the frequency hopping pattern........i mean,
> if i could  some way dump the changing channel numbers into a log
> file.???

you can't do this without a protocol analyzer.

> i also want to understand the baseband throughput.....can i get the
> bit error rate before FEC is applied....is it possible????

No. You can only do things that are defined in the HCI part of the
Bluetooth specification.

> also, what does a transmit power level of 4 mean??

Check the HCI commands description for that.

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
https://lists.sourceforge.net/lists/listinfo/bluez-users
