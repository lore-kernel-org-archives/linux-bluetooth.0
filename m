Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Stuart Anderson <subs@iduniken.com>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1078848325.9713.5.camel@donivin.nx14.com>
Mime-Version: 1.0
Subject: [Bluez-users] Missing libopenobex-1.0.so.1
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
Date: Tue, 09 Mar 2004 16:05:25 +0000

hi all,
   Im following the tutorial at
http://www.frasunek.com/HOWTO-Nokia7650-Bluetooth.txt and ive got down
to the stage of running runing ObexSERVER at the bottom of step five but
when i do i get the error:
    "obexserver: error while loading shared libraries:
libopenobex-1.0.so.1: cannot open shared object file: No such file or
directory"
   I've searched for libopenobex-1.0.so.1 and found it in:
[root@donivin openobex-1.0.1]# ls -al
/usr/local/lib/libopenobex-1.0.so.1
lrwxrwxrwx    1 root     root           24 Mar  9 15:48
/usr/local/lib/libopenobex-1.0.so.1 -> libopenobex-1.0.so.1.0.0
   Can anyone tell me how i can get the ObexSERVER to run?

Anderson
-- 
Anderson



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
