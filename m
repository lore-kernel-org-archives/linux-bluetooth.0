Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060130144942.84846.qmail@web53105.mail.yahoo.com>
From: ermal mino <ermalmino1004@yahoo.it>
To: bluez <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] how to use more than one dongle at the same time
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 30 Jan 2006 15:49:42 +0100 (CET)

Hi,

I've been working around trying to use two ore more
usb dongles at the same time ,(by the way I could send
files from one dongle at the same time to more than
one cellphones.)
as usual i start command line tool to witch i give the
address of one dongle
and in another konsole i start another programm using
the other dongle.
Both programs are used to send different files from
different dongles.

the way i bind the socket I use is this.

        struct sockaddr_rc addr={0},laddr={0};
        s = socket(AF_BLUETOOTH, SOCK_STREAM,
BTPROTO_RFCOMM);

        addr.rc_family = AF_BLUETOOTH;
   	addr.rc_channel = port ; //remote port
    	str2ba( remote_addr, &addr.rc_bdaddr );
	
	laddr.rc_family = AF_BLUETOOTH;
	laddr.rc_channel=0; //local
    	str2ba( local_addr, &laddr.rc_bdaddr );
        
        bind(s, (struct sockaddr*)sockaddr,
sizeof(laddr));
         
        connect(s, (struct sockaddr *)&addr,
sizeof(addr));
        ......
         recv();
         send();
         .....
        close(s);

here remote_addr and local_addr are the string
representation of local and remote device addresses
given to the programm from the command line.

when one of the programs is working(sending and
recieving data)
i start the other one and after the first packet is
sent or the connection is made it all stops and both
the connections remains open.
I checked and i am the master in both cases.

Is this normal?
why i can't use them concurrently.

Best Regards
Ermal Mino.


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
