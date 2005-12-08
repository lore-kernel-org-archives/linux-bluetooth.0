Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5324_17120695.1134004318831"
Subject: [Bluez-users] UART bluetooth chip problem
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
Date: Wed, 7 Dec 2005 17:11:58 -0800

------=_Part_5324_17120695.1134004318831
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, I am currently using a bluetooth chip by bluegiga (www.bluegiga.com),
called WRAP THOR 2022-1-B2B.
I set the configurations on the chip so that it is running at 115200 baud
rate. After, I tried doing the following:

# hcid
# hciattach -s 115200 /dev/ttyS1 any 115200 flow
# hciconfig
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN INIT RUNNING
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:4 acl:0 sco:0 commands:1 errors:0
# hciconfig hci0 up
Can't init device hci0: Connection timed out (145)

I checked and error code 145 indeed means Connection timed out on my header
files (errno.h).
What might be wrong?

Thanks a lot.

Cheers,

  Arthur

------=_Part_5324_17120695.1134004318831
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, I am currently using a bluetooth chip by bluegiga (<a href=3D"http://ww=
w.bluegiga.com">www.bluegiga.com</a>), called WRAP THOR 2022-1-B2B. <br>
I set the configurations on the chip so that it is running at 115200 baud r=
ate. After, I tried doing the following: <br>
<br>
# hcid<br>
# hciattach -s 115200 /dev/ttyS1 any 115200 flow<br>
# hciconfig<br>
hci0:&nbsp;&nbsp; Type: UART<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 AC=
L MTU: 0:0 SCO MTU: 0:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN INIT RUNNING<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0 =
errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:4 acl:0 sco:0 commands:=
1 errors:0<br>
# hciconfig hci0 up<br>
Can't init device hci0: Connection timed out (145)<br>
<br>
I checked and error code 145 indeed means Connection timed out on my header=
 files (errno.h). <br>
What might be wrong? <br>
<br>
Thanks a lot.<br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br>

------=_Part_5324_17120695.1134004318831--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
