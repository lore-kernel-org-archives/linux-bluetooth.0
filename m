Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050209123431.60154.qmail@web41110.mail.yahoo.com>
From: Sean Loh <blaze_wk@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Bluetooth 2.0 EDR new SCO and ACL packets
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
Date: Wed, 9 Feb 2005 04:34:31 -0800 (PST)

Hi,

I am intending to write applications to take advantage
of the new Bluetooth 2.0 EDR throughput. I have got a
couple of questions that I can't seem to find through
the mailing list.

1. Since there are new packets with the new Bluetooth
spec, will we just have to type in the command through
hcitool to use the new packets (eg. hcitool -i hci0
-cpt <Target Bluetooth Address> <New ACL packet
acronym>?

2. I seem a bit confused about the usage of the 'PAN'
profile with the new Bluetooth spec. How does the
BlueZ 'PAN' take advantage of the new throughputs?
Will we just have to modify the packets like 'question
1' via hcitool and immediately all IP applications
over Bluetooth will take advantage of the new
throughputs? Or does the BlueZ 'pan' itself behave
differently upon Bluetooth 2.0 EDR?

Lastly, thanks for the help once again!! BlueZ as
always is organised greatlky and promptly!!


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
