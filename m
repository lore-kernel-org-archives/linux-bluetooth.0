Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Andres Meyer <andres.meyer@computer.org>
Message-ID: <loom.20041114T133356-876@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] BlueLogic Wingkey problems
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
Date: Sun, 14 Nov 2004 16:03:07 +0000 (UTC)

I just bought a BlueLogic Wingkey keyboard-trackball bluetooth combo (which I 
think is perfect for sofa-surfing). It does not work in a useful way. I could 
not find any information about this device and linux until now. 
 
Hints? 
 
Andres 
 
 
config: 
- vanilla 2.6.9 kernel 
- x86 
- tried with planet and epox usb bt adapters 
- gentoo setup, with hidd etc. installed and enabled. 
 
problems: 
- the keyboard is detected 
- when pressing a key, the pressed char appears, but then in about 70% of all 
cases, some other key  stroke, eg "arrow up", follows immediately. 
- the integrated trackball is not detected 
- in various howtos, separate bt addresses are detected for mouse/keyboards. I 
can only detect one bt address for the whole keyboard/trackball combo (using 
the hcitool scan command). 
 



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
