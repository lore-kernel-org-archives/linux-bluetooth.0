Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1100949891.419f2983a8527@www.bluebottle.com>
From: jago25_98 <jago25_98@bluebottle.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Can l2ping phone but can't `sdptool browse` or discover?
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
Date: Sat, 20 Nov 2004 05:24:51 -0600

Well I don't know. I can ping bond to the P800 now my initiating it
from the phone end but can't discover the phone from the bluez end. I
can even send files but I can't `sdptool browse` or `hcitool scan`:

---
root@betty.net[/dev] # hcitool scan
Scanning ...
root@betty.net[/dev] # hcitool scan
Scanning ...
root@betty.net[/dev] # l2ping 00:0A:D9:5E:FB:FE
Ping: 00:0A:D9:5E:FB:FE from 00:0C:41:E2:0D:BE (data size 20) ...
0 bytes from 00:0A:D9:5E:FB:FE id 200 time 59.90ms
0 bytes from 00:0A:D9:5E:FB:FE id 201 time 42.98ms
0 bytes from 00:0A:D9:5E:FB:FE id 202 time 28.93ms
0 bytes from 00:0A:D9:5E:FB:FE id 203 time 48.91ms
4 sent, 4 received, 0% loss
root@betty.net[/dev] # 
---

This is a problem because I can't use "sdptool browse":

---
root@betty.net[/dev] # sdptool  browse
Inquiring ...
root@betty.net[/dev] # 
---

Again, I don't know how to get more verbose output:
---
sdptool - SDP Tool v1.5
Usage:
        sdptool [options] <command> [command parameters]
Options:
        --help          Display help
        --source        Specify source interface
Commands:
        search          Search for a service
        browse          Browse all available services
        add             Add local service
        del             Delete local service
        get             Get local service
        setattr         Set/Add attribute to a SDP record
        setseq          Set/Add attribute sequence to a SDP record

Services:
        SP DUN LAN HSET FAX OPUSH FTRN NAP GN HID CIP CTP 
---


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
