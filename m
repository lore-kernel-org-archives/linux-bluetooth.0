Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40570F3F.90607@identisys.de>
From: Thomas Eller <te@identisys.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Question regarding rfcomm-timeout
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
Date: Tue, 16 Mar 2004 15:29:19 +0100

Hello, there !

I'm using the rfcomm executable from bluez-utils to connect to a 
bluetooth device. It looks like this:

rfcomm connect 0 xx:xx:xx:xx:xx:xx 1

If the remote device is not present the rfcomm-connect ends with a 
timeout after ~20s with the error-message: "Can't connect..... ...Host 
is down."

Where can i push this 20s-timeout down to a lower value ???

I see in the source-code that a socket-connection is made, so possibly 
there may be a parameter that can be configured through the 
proc-filesystem ?!?


Regards,

Tom

-- 
---------------------------

Thomas Eller
te@identisys.de



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
