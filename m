Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40449A86.5020404@itelefonica.com.br>
From: Daniel Moraes <ra002890@itelefonica.com.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] BlueZ and CSR BC02!
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
Date: Tue, 02 Mar 2004 11:30:30 -0300

I'm trying to install a csr bc02  board under linux, but I'm having no 
success!! All modules were installed! My hciattach command get a 
successfull message :
    [root@goodman root]# hciattach -t 20 ttyS0 csr 115200 flow
    CSR build ID 0x02-0xC1
    [root@goodman root]# hciconfig
    hci0:   Type: UART
            BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
            DOWN
            RX bytes:0 acl:0 sco:0 events:0 errors:0
            TX bytes:0 acl:0 sco:0 commands:0 errors:0
But when I try to put module to up status, it didn't work at all!
And send me this message:
    [root@goodman root]# hciconfig hci0 up
    Can't init device hci0. Connection timed out(110)
Someone could help me?!?

Thanks in advance!!
                Daniel Moraes, directly from Brasil!



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
