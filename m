Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Ronan Naughton" <wadgienaughton@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY10-F1216PYzDabig00010bb6@hotmail.com>
Subject: [Bluez-users] bluez pan problem
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
Date: Mon, 08 Mar 2004 15:51:18 +0000

Hi all,
I am having a problem with setting up a bluez pan between three machines and 
i don't know what I'm doing wrong.

I set one node ( say B )the GN to listen

                                           pand --listen --master --role GN


I then connect  the other two nodes ( A & C )

                                          pand --connect  mac_addr_of_master


I then assign an ip address to A, C and then the master B:

                                           ifconfig bnep0 10.0.0.1
                                           ifconfig bnep0 10.0.0.3
                                           ifconfig bnep0 10.0.0.2


Then for some reason:
The first pc (10.0.0.1) can ping the other PANU and the GN
The second pc (10.0.0.3) cannot ping the other PANU or the GN
The GN (10.0.0.2 ) can only ping the second pc (10.0.0.3)

Why on earth is this happening. Ip forwarding is turned on on all machines. 
I have no idea why it won't work-please help!!!!!!!!
Regards,
Ronan.

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
