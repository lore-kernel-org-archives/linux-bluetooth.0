Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4173F86A.3050801@uni-paderborn.de>
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Piconet Routing
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 18 Oct 2004 19:07:54 +0200

Hello!

Since Bluetooth uses Time Division Duplex, a slave is not allowed to 
talk to another slave in the same Piconet. The logical consequence must 
be that the data is routed over the master. I've used l2test to check if 
l2cap does this kind of routing automatically. It doesn't but rather 
creates a new, direct acl link to the remote slave device (scatternet). 
I don't know how it is with rfcomm, but I suppose it's the same. My 
question: Is there any automatic Piconet Routing inside BlueZ or does 
one have to implement it by oneself?

Regards
Stefan



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
