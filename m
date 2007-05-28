Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <465AF314.5090206@rousse.org>
Date: Mon, 28 May 2007 17:19:48 +0200
From: Alexander <amour@rousse.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] dbus api
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello list,

I'm working on a C++ library that invokes bluez over dbus. I'm currently 
having some trouble understanding the logic of a local service. Could 
someone explain me the way local services are managed? Like, calling 
RegisterService() of the org.bluez.Database, what does that method do? 
Does it create a new ServiceRecord on hciX? If so, what happens with the 
protocol descriptors of that service record? How can I list all the 
registered services on hciX? I see Add and Update methods for service 
records but no ListServiceRecords()? There is a ListServices() method on 
the manager interface but this interface is just for the /org/bluez 
object path, so this won't give me a list just for hciX. Also, the 
org.bluez.Service interface, does it have anything to do with 
Add/UpdateServiceRecord() methods of the database interface? Can I 
modify the service record (for example the protocol descriptors) of a 
service represented by the org.bluez.Service interface?
What happened with the RFCOMM API? I agree it wasn't very nice by 
forcing you to open /dev/tty* but it was at least something, now there 
isn't anything dbus based. A RFCOMM API with connect(), disconnect(), 
read() and write() will be just great (all dbus based ofcourse, no 
/dev/tty* stuff :) ).

best regards,
Alexander

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
