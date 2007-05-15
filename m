Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6669365c0705150801g1868b3c4v40c59eba01e6e832@mail.gmail.com>
Date: Tue, 15 May 2007 15:01:09 +0000
From: "Daniel Ribeiro" <drwyrm@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] BCM2035 on UART at speeds higher than 230400
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0554340765=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0554340765==
Content-Type: multipart/alternative;
	boundary="----=_Part_2909_16183326.1179241269301"

------=_Part_2909_16183326.1179241269301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all.

I am working on bluetooth support for the Motorola EZX platform (a780/e680
phones) and i am unable to hciattach bcm2035 at baud rates higher than
230400.

I reverse engineered the original firmware and found that it uses a
different argument to the hci command that sets the baud rate when setting
460800 and 921600, i have changed hciattach.c and it works at full speed for
me now.

What i want to know is if anyone is using this chip at rates higher than
230400 before submiting my patch, so it doesnt break anyone else work.
Currently i know that the EZX platform and most Palm handhelds use this chip
on the UART port. My patch works for EZX and i am waiting feedback from the
hackndev guys about the palms.

My patch also adds support for setting the bdaddr on chip init, otherwise
this chip gets 00:00:00:00:00:00.

Thank you in advance.

-- 
EOF

Daniel Ribeiro

------=_Part_2909_16183326.1179241269301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all.<br><br>I am working on bluetooth support for the Motorola EZX platform (a780/e680 phones) and i am unable to hciattach bcm2035 at baud rates higher than 230400.<br><br>I reverse engineered the original firmware and found that it uses a different argument to the hci command that sets the baud rate when setting 460800 and 921600, i have changed 
hciattach.c and it works at full speed for me now.<br><br>What i want to know is if anyone is using this chip at rates higher than 230400 before submiting my patch, so it doesnt break anyone else work. Currently i know that the EZX platform and most Palm handhelds use this chip on the UART port. My patch works for EZX and i am waiting feedback from the hackndev guys about the palms.
<br><br>My patch also adds support for setting the bdaddr on chip init, otherwise this chip gets 00:00:00:00:00:00.<br><br>Thank you in advance.<br clear="all"><br>-- <br>EOF<br><br>Daniel Ribeiro

------=_Part_2909_16183326.1179241269301--


--===============0554340765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0554340765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0554340765==--
