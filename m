Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Ronan Naughton" <wadgienaughton@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY10-F29zjmbgGHk7s000090c8@hotmail.com>
Subject: [Bluez-users] Setting up a bluetooth network
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
Date: Tue, 02 Mar 2004 12:11:22 +0000

Hi,
I am having some trouble. I want to set up a little bluetooth LAN say 
between 4 computers with bluetooth dongles and a pda. I don't know which to 
use PAN or LAN access profile and I am having trouble setting up both. 
Someone told me that when your using pan, its not really the same as setting 
up a network but more like a communication means for all your personal 
devices.

Also is LAN acces profile just for say accesing a LAN rather than setting up 
a LAN. All the LAN how-to's show how to set up a PPP connection between ur 
pc and your phone, and that is even causing me trouble. It trys to make a 
PPP over rfcomm but fails to connect.

When I tried setting up a PAN between three computers ( I am using Red Hat9 
and the blueZ package for this ) both computers can ping the master but 
cannot ping each other and the master can only ping one pc, even though it 
seems that the connection is there and the pc's are beside each other.
I assigned the master by un-commenting the config file ( at lm accept, 
master ).

The thing is that I need to run an ad hoc network (AODV) accross this "LAN" 
and some of the pc's will be out of range with other but have to communicate 
using neighbouring nodes.
I read some where that LAN access profile does not support ad-hoc networks.

If anyone can help at all it would be greatly appreciated as i am in dire 
straits. All the how-to's don't seem to be helping.
Thanks,
Wadgie.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
