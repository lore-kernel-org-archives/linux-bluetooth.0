Return-Path: <cyrus@holtmann.org>
Message-ID: <4820674A.1030404@ticino.com>
Date: Tue, 06 May 2008 16:12:26 +0200
From: 98132 <98132@ticino.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] problem with hcitool scan
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1475396927=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1475396927==
Content-Type: multipart/alternative;
	boundary="------------030809080404030908050407"

This is a multi-part message in MIME format.
--------------030809080404030908050407
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello, i've a problem with hcitool

software versions:

kernel:  2.6.22-14-generic
bluez:   bluez-utils  3.19-0ubuntu3           

when i use /hcitool scan/ i have the following result:

first device (mobile phone) (3 try with hcitool scan)
/00:12:*52*:3D:38:B5  n/a      /--> correct/
00:12:*D2*:3D:38:B5 n/a       /--> wrong/
00:12:D2:3D:38:*B4 *n/a      /--> wrong
/
/second device (mobile phone) (5 try with hcitool scan)/
*00:1E:4C*:E2:F1:5C xxx     /--> correct
/00:1E*:7C*:E2:F1:5C xxx      /--> wrong
/00:1E:*4C*:*F2*:F1:5C xxx     /--> wrong
/*C0:9F:CC*:E2:F1:5C xxx    /--> wrong//
/*00:96:4C*:E2:F1:5C xxx    /--> wrong//
/
/the devices are only two but the address are different.
if i try to ping (l2ping), only the first address is correct.
Can you explain me what is wrong?
thanks!

signo






--------------030809080404030908050407
Content-Type: text/html; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
Hello, i've a problem with hcitool<br>
<br>
software versions:<br>
<br>
kernel:  2.6.22-14-generic<br>
bluez:   bluez-utils  3.19-0ubuntu3            <br>
<br>
when i use <i>hcitool scan</i> i have the following result:<br>
<br>
first device (mobile phone) (3 try with hcitool scan)<br>
<i>00:12:<b>52</b>:3D:38:B5  n/a      </i>--&gt; correct<i><br>
00:12:<b>D2</b>:3D:38:B5 n/a       </i>--&gt; wrong<i><br>
00:12:D2:3D:38:<b>B4 </b>n/a      </i>--&gt; wrong<br>
<i><br>
</i>second device (mobile phone) (5 try with hcitool scan)<i><br>
<b>00:1E:4C</b>:E2:F1:5C xxx     </i>--&gt; correct<br>
<i>00:1E<b>:7C</b>:E2:F1:5C xxx      </i>--&gt; wrong<br>
<i>00:1E:<b>4C</b>:<b>F2</b>:F1:5C xxx     </i>--&gt; wrong<br>
<i><b>C0:9F:CC</b>:E2:F1:5C xxx    </i>--&gt; wrong<i></i><br>
<i><b>00:96:4C</b>:E2:F1:5C xxx    </i>--&gt; wrong<i></i><br>
<i><br>
</i>the devices are only two but the address are different.<br>
if i try to ping (l2ping), only the first address is correct.<br>
Can you explain me what is wrong?<br>
thanks!<br>
<br>
signo<br>
<br>
<br>
<br>
<br>
<br>
</body>
</html>

--------------030809080404030908050407--


--===============1475396927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1475396927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1475396927==--
