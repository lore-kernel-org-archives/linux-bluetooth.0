Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 16 Jun 2007 06:21:52 -0700 (PDT)
From: Robert Schmidt <itsmy_emale@yahoo.com>
To: Bluez User <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <533660.67769.qm@web38512.mail.mud.yahoo.com>
Subject: [Bluez-users] HCI socket listen
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1803924238=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1803924238==
Content-Type: multipart/alternative; boundary="0-785081440-1182000112=:67769"
Content-Transfer-Encoding: 8bit

--0-785081440-1182000112=:67769
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

Can a HCI socket listen for connections like l2cap and rfcomm ?? In my case it throws followiing warning and does not listen:

GLib-WARNING **: giounix.c:400Error while getting flags for FD: Bad file descriptor (9)

In my program I do the following:

I Open and Bind the HCI socket (using hci_open_dev)and listen for connections.


thanks

robert.

       
---------------------------------
Moody friends. Drama queens. Your life? Nope! - their life, your story.
 Play Sims Stories at Yahoo! Games. 
--0-785081440-1182000112=:67769
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>Can a HCI socket listen for connections like l2cap and rfcomm ?? In my case it throws followiing warning and does not listen:<br><br>GLib-WARNING **: giounix.c:400Error while getting flags for FD: Bad file descriptor (9)<br><br>In my program I do the following:<br><br>I Open and Bind the HCI socket (using hci_open_dev)and listen for connections.<br><br><br>thanks<br><br>robert.<br><p>&#32;
      <hr size=1>Moody friends. Drama queens. Your life? Nope! - their life, your story.<br> <a href="http://us.rd.yahoo.com/evt=48224/*http://sims.yahoo.com/">Play Sims Stories at Yahoo! Games. </a>
--0-785081440-1182000112=:67769--


--===============1803924238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1803924238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1803924238==--
