Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueLogic Wingkey problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20041114T133356-876@post.gmane.org>
References: <loom.20041114T133356-876@post.gmane.org>
Content-Type: text/plain
Message-Id: <1100449789.21403.47.camel@pegasus>
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
Date: Sun, 14 Nov 2004 17:29:49 +0100

Hi Andres,

> I just bought a BlueLogic Wingkey keyboard-trackball bluetooth combo (which I 
> think is perfect for sofa-surfing). It does not work in a useful way. I could 
> not find any information about this device and linux until now. 

first I need some more information about this device

	hcitool inq
	hcitool scan
	hcitool info 00:xx:xx:xx:xx:xx

Then compile the libs2 CVS repository and run

	./test/sdptest records 00:xx:xx:xx:xx:xx > sdp_records.txt

and send me the file sdp_records.txt.

> config: 
> - vanilla 2.6.9 kernel 
> - x86 
> - tried with planet and epox usb bt adapters 
> - gentoo setup, with hidd etc. installed and enabled. 

Use a 2.6.9-mh3 kernel and see if this helps.

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
