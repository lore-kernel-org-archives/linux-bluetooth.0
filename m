Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <9307f5f20601131532i76e02cdatce5a0dba011b2a6b@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sendto give invalid argument
In-Reply-To: <BAY103-W384F0CD67A81C73CE7167F7260@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <BAY103-W384F0CD67A81C73CE7167F7260@phx.gbl>
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
Date: Sat, 14 Jan 2006 00:32:07 +0100

I didn't look very carefully at your code, but the first thing I
noticed is how you create the socket, I wrote a C++ wrapper over bluez
a while ago and it has a class for L2Cap connections, the constructor
goes this way:

L2CapSocket::L2CapSocket()
:=09Socket( PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP )
{}

and it worked great for me, so maybe you should pass different
parameters to the socket(...); call.

regards,
Paul


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
