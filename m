Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
From: DVornheder@t-online.de
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1ArCh7-0SGjjc0@cmpmail09.bbul.t-online.de>
Subject: [Bluez-users] Problem with connection between two pc using bluetooth
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
Date: Thu, 12 Feb 2004 09:59:37 +0100


Hi !

I try to get a connection between two pc using bluetooth.

My hardware: AVM Fritz AP-X ISDN and two AVM BlueFritz USB Sticks.

At the first pc i start pand --search and get a connection to AP-X
without any problems.

At the second pc i start pand --search but the connection fails:

Feb 11 18:44:03 pclap hcid[1290]: link_key_request
(sba=00:04:0E:85:B2:C0, dba=0
0:04:0E:85:35:15)                                                       
       
Feb 11 18:44:03 pclap hcid[1290]: link_key_notify
(sba=00:04:0E:85:B2:C0)       
Feb 11 18:44:03 pclap hcid[1290]: Replacing link key 00:04:0E:85:B2:C0
00:04:0E:
85:35:15                                                                
       
Feb 11 18:44:03 pclap kernel: Bluetooth: Found 1 CAPI controller(s) on
device 00
:04:0E:85:35:15                                                         
       
Feb 11 18:44:03 pclap kernel: kcapi: Controller 1: 00:04:0E:85:35:15
attached   
Feb 11 18:44:03 pclap kernel: kcapi: card 1 "00:04:0E:85:35:15" ready.  
       
Feb 11 18:44:03 pclap kernel: kcapi: notify up contr 1                  
       
Feb 11 18:44:03 pclap kernel: Bluetooth: BNEP (Ethernet Emulation) ver
1.0      
Feb 11 18:44:03 pclap kernel: Bluetooth: BNEP filters: protocol
multicast       
Feb 11 18:44:03 pclap pand[3561]: PAN daemon ver 1.1                    
       
Feb 11 18:44:03 pclap pand[3561]: Inquiring                             
       
Feb 11 18:44:03 pclap pand[3561]: Searching for NAP on 00:04:0E:85:2E:9A
       
Feb 11 18:44:43 pclap pand[3561]: Failed to connect to the SDP server.
Connectio
n timed out(110)                                                        
       
Feb 11 18:44:43 pclap pand[3561]: Searching for NAP on 00:04:0E:85:35:15
       
Feb 11 18:45:23 pclap pand[3561]: Failed to connect to the SDP server.
Connectio
n timed out(110)                                                        
       

Dirk




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
