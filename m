Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200401281510.36476.mtortonesi@ing.unife.it>
Subject: [Bluez-devel] bluez stability problems?
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
Date: Wed, 28 Jan 2004 15:10:36 +0100


hi to everybody,

sometimes when i start playing with bluez the bluetooth subsystem hangs:

[mauro@daneel nc6]$ cat src/main.c | ./src/nc6 -vvv --mtu=672 -b 
00:0D:88:8E:CA:07 10
nc6: unable to connect to remote address bluez socket
[mauro@daneel nc6]$ hcitool scan
Scanning ...
[mauro@daneel nc6]$
[mauro@daneel nc6]$ l2ping 00:0D:88:8E:CA:07
Can't create socket.: Operation not permitted
[mauro@daneel audiotest2]$ ./oggread -f 
/mnt/disk/mauro/art_blakey_and_the_jazz_messengers-impulse/01_alamode.ogg -d 
00:0D:88:8E:CA:07 -p 10
oggread[18536]: Can't connect. Operation already in progress(114)
Cannot connect to Bluetooth device 00:0D:88:8E:CA:07

i have experienced this problem with both recent 2.4 (2.4.25-pre7 included) 
and 2.6 kernels.

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
