Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45AF6BFA.3050005@gmail.com>
Date: Thu, 18 Jan 2007 14:45:46 +0200
From: Mikko Saarnivala <msaarniv@gmail.com>
MIME-Version: 1.0
To: BLUEZ-USERS <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] rfcomm and receiving incoming connections
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


Hi,

I'm quite new to using the Bluez-stack and tools associated with it so I 
could use some help with a problem that I'm facing. This might be a 
trivial task to perform, but for some reason I haven't been able to make 
it work.

I have a PC which has a USB BT dongle (Linksys, works fine) and a 
separate device which when powered automatically tries to connect into 
which ever BT device within range and simply starts to send measurement 
data. I managed to accept the connection using kbluetoothd but I need to 
do the same thing without using the KDE specific stuff (Gnome 
applications are also out of the question).

Question: how do I set up the Bluez system so that
1) it is listening for incoming rfcomm connections from a specific BT 
interface (say hci0) without needing to define the BT address of the 
device that tries to connect
2) find out what is the BT address of the device that is trying to connect
3) enters PIN automatically for example from a file

I've been trying to follow some of the instructions from the web but 
they seem to be slightly off the mark when comparing to the stuff that 
I'm trying.

Help would be _very_ much appreciated and thanks in advance.

-- 
MjS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
