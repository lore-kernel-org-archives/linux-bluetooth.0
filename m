Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de4657604112307276221ff99@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] throughput query
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
Date: Tue, 23 Nov 2004 20:57:23 +0530

hi marcel,
I am using anycom bt dongles. i set up a bt connection with pan/bnep.
i use i-perf to measure the throughput ..and i get abt 620kbps. I then
change to DH5 packet and measure the throughput.....and it is abt
300kbps.  Is this because of asymmetric and symmetric channels
respectively.
logically,use of  DM packets gives a lower througput compared to DH packets. 

How is that hcitool is able to set the packet type in a connection?
Isn't there some sort of communication with the LM and baseband??
Similarly, can't i change the transmit power level???

thanks and regards,
manjunath


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
