Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-users@lists.sourceforge.net
Cc: victor.shcherbatyuk@tomtom.com
Message-ID: <Pine.LNX.4.44.0503250940070.12685-100000@antilope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] PPP & Smartphones
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
Date: Fri, 25 Mar 2005 09:51:35 +0100 (MET)

Does anyone have experience running PPP through DUN profile of a Windows 
Mobile smartphone? The problem I encountered is that when PPP connection 
is up and running and the phone receives an incoming call it sends RING 
over the RFCOMM channel used by PPP and if you pick up and then hang up it 
also sends NO CARRIER over the same channel. I have feeling this $%^&s up 
PPP deamon, cause after this it does not work anymore, it also does not detect any problems, so you have to kill it. Worse than that, after 
killing pppd, the phone remains in some weird state where it ignores any AT's 
sent to it, so needs to be rebooted...
I had this with Qtek's and Motorola's, the problem with weird state after 
killing pppd was solved for motorola's by using modem and crtscts in 
ppp options, but it changed nothing for Qtek's.

Is sending RING and NO CARRIER over RFCOMM used by PPP (when ppp is 
active) is a part of protocol?

Thanks.

Kind regards,
         Victor.

-- 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
