Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: David Abrahams <dave@boost-consulting.com>
Date: Thu, 05 Jul 2007 20:02:12 -0400
Message-ID: <87ir8ytn5n.fsf@grogan.peloton>
Mime-Version: 1.0
Subject: [Bluez-users] hidd connection to mouse interferes with headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


I am using a bluetooth mouse (logitech) and headset (plantronics) with
Ubuntu Feisty.

Without connecting the mouse, I can use the headset with Skype and get
reasonably good sound quality.

However, if I connect to my BT mouse with

  sudo hidd --connect <btaddr>

and try to use Skype again, I get horrible distortion, from "choppy
sound" to "white noise"

If I then

  sudo killall /usr/bin/hidd

sound in Skype goes back to normal.

Actually I have

  HIDD_ENABLED=1
  HIDD_OPTIONS="--connect 00:07:61:35:FE:A9 --master --server"

in my /etc/default/bluetooth, so all I need to do is turn my mouse
*on* to get this effect.

Does anyone have an idea how to cure (or even debug) this problem?

TIA,

-- 
Dave Abrahams
Boost Consulting
http://www.boost-consulting.com

The Astoria Seminar ==> http://www.astoriaseminar.com


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
