Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 1 Sep 2007 04:58:36 -0700 (PDT)
From: Sohel <itsmy_emale@yahoo.com>
To: Bluez User <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <542242.82032.qm@web38513.mail.mud.yahoo.com>
Subject: [Bluez-users] problem with class 1 EDR devices
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1480799297=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1480799297==
Content-Type: multipart/alternative; boundary="0-1800745214-1188647916=:82032"
Content-Transfer-Encoding: 8bit

--0-1800745214-1188647916=:82032
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I have two USB sticks manufactured by CSR. They are class 1 EDR with LMP version 2.0. When I tried to use l2ping command, I get the following output:

Ping: xx:xx:xx:xx:xx from xx:xx:xx:xx:xx:xx (data size 44) ...
no response from xx:xx:xx:xx:xx:xx id 0
no response from xx:xx:xx:xx:xx:xx id 1
no response from xx:xx:xx:xx:xx:xx id 2
Recv failed: Connection timed out

hci0:   Type: USB
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1857 acl:20 sco:0 events:71 errors:0
        TX bytes:1077 acl:25 sco:0 commands:30 errors:0

hci1:   Type: USB
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:717 acl:8 sco:0 events:44 errors:0
        TX bytes:507 acl:8 sco:0 commands:23 errors:0

It works fine for class 2 devices. Are class 1 devices with EDR supported by Bluez as hcidump shows that they are unable to connect to each other .

thanks 

sohel


       
---------------------------------
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us.
--0-1800745214-1188647916=:82032
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I have two USB sticks manufactured by CSR. They are class 1 EDR with LMP version 2.0. When I tried to use l2ping command, I get the following output:<br><br>Ping: xx:xx:xx:xx:xx from xx:xx:xx:xx:xx:xx (data size 44) ...<br>no response from xx:xx:xx:xx:xx:xx id 0<br>no response from xx:xx:xx:xx:xx:xx id 1<br>no response from xx:xx:xx:xx:xx:xx id 2<br>Recv failed: Connection timed out<br><br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1857 acl:20 sco:0 events:71 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:1077 acl:25 sco:0 commands:30 errors:0<br><br>hci1:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 384:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING
 PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:717 acl:8 sco:0 events:44 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:507 acl:8 sco:0 commands:23 errors:0<br><br>It works fine for class 2 devices. Are class 1 devices with EDR supported by Bluez as hcidump shows that they are unable to connect to each other .<br><br>thanks <br><br>sohel<br><br><p>&#32;
      <hr size=1>Fussy? Opinionated? Impossible to please? Perfect.  <a href="http://us.rd.yahoo.com/evt=48516/*http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 ">Join Yahoo!'s user panel</a> and lay it on us.

--0-1800745214-1188647916=:82032--


--===============1480799297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1480799297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1480799297==--
