Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050214114707.9429.qmail@web41104.mail.yahoo.com>
From: Sean Loh <blaze_wk@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Higher throughput with larger UDP packet size
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
Date: Mon, 14 Feb 2005 03:47:07 -0800 (PST)

Hi!!

I have established an IP network over the BlueZ stack
and have transmitted UDP packets at varying sizes. I
then  assessed the throughput using the different
datagram packets sizes. Why is it that the larger UDP
packets obtain higher throughputs than the smaller UDP
packets (eg. 60,000 bytes vs 5000 bytes)? Shouldn't
the smaller UDP packets obtain an overall higher
througput since less time is spent for segmentation
and reassembly?

Thanks a million 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
