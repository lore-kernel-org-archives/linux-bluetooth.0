Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20040528141127.24199.qmail@web51304.mail.yahoo.com>
From: Aarti Kumar <akmr2000@yahoo.com>
Subject: RE: [Bluez-devel] BC Flag in HCI ACL Data PACket.
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085494294.9779.130.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 28 May 2004 07:11:27 -0700 (PDT)


Hi Marcel,
I am doing some performance relatedd work over
bluetooth and I need to use the BC (Broadcast Control)
Flag in HCI ACL Data packet. The packet format
specifies 12 bits of connection handle and 2 bits each
of Packet Boudary Flag and BC Flag. I set the BC flag
to a value before sending (that is in function
hci_send_acl in hci_core.c) and have changed the
receiver function hci_acldata_packet function (in
hci_core.c) to recognize the value. But somehow it
dosent work. I was looking through the code for hci
and bcsp layer but couldnt locate anything related to
Flag field embeded in connection handle value. Are you
aware of any function which checks the Flag value in
HCI ACL data packet header after hci_send_acl function
(at sender side)and before hci_acldata_function (at
receiver side). Or anyother way so that I can use the
BC flag field.

Thanking you.

Regards,
Aarti.





	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
