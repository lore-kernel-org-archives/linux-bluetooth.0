Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY135-F39B9DECCEB581ABD12509B8710@phx.gbl>
From: "Vincent Yau" <v_yau3@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Fri, 16 Mar 2007 18:17:43 +0000
Mime-Version: 1.0
Subject: [Bluez-users] friendly name in pin exchange
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi:

I have a pin helper script that does pin exchange in my Bluez stack.
The pin script detects incoming arguments and then hands out a pin 
accordingly.

I am working with a device that the manufacturer says has a friendly name 
that is 20+ characters long.  But incoming arguments, as I can see from the 
pin script, has only the bluetooth address of this remote device.  I am 
looking at the Bluez D-Bus API but I do not see anything appropriate that I 
can call during pin exchange to fetch information like the friendly name.  
Is there another way to retrieve additional info about this device?   This 
device is master and not discoverable so I have to wait for it to connect to 
my host.

Thanks for any pointer.

--V



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
