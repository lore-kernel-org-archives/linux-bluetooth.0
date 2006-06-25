Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 25 Jun 2006 16:32:12 +0200
From: =?iso-8859-1?q?G=F6tz_Issel?= <g.issel@fh-wolfenbuettel.de>
To: bluez-devel@lists.sourceforge.net
Message-id: <200606251632.12624.g.issel@fh-wolfenbuettel.de>
MIME-version: 1.0
Subject: [Bluez-devel] reading response on bluetooth socket
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

I would like a sample snipplet of code to get help on the following problem:

After having set up a rfcommm connection from my notebook to a mobile phone I 
need to get the response data from the mobile device. I can read from the 
socket using 'recv()' but if no data is there at thaht moment this will block 
the process or pause my program. What I need to do is get a signal on 'data 
available' on the socket for reading or a non blocking read. I heard there is 
a function 'select()' .. but it does not seem to work or I don't understand 
it. It needs to be as simple as possible.

This is what I have now:

// init + declare variables
	fd_set readFds;
	struct timeval timeout;
    	struct sockaddr_rc addr = { 0 };
   	int rfcomm_sock, status; 
	
// allocate a socket
   	 rfcomm_sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

// set the connection parameters (who to connect to)
    	addr.rc_family = AF_BLUETOOTH;
    	addr.rc_channel = (uint8_t) dest_channel;
    	str2ba( dest, &addr.rc_bdaddr );

// connect to server, here mobile phone
   	 status = connect(rfcomm_sock, (struct sockaddr *)&addr, sizeof(addr));

	timeout.tv_sec=5;
	timeout.tv_usec=0;	
	FD_ZERO(&readFds);
	FD_SET(rfcomm_socket, &readFds);
	if (select(rfcommsocket + 1, &readFds, NULL, NULL, &timeout) == 0) 
	{
		printf("timed out");
	}
	else
		printf("data ready for read");


Anyone done this  before? I have seen something like this in the source file 
'sdp.c' but somehow I am missing something.

Thanks for your help in advance.

Goetz




	 

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
