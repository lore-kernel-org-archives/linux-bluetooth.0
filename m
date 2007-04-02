Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b621074b0704020400r2e1500d5u4972031e010a05e5@mail.gmail.com>
Date: Mon, 2 Apr 2007 16:30:17 +0530
From: "Tushar Paturde" <tusharpaturde@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Usage of fcntl for non blocking mode...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1247211352=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1247211352==
Content-Type: multipart/alternative;
	boundary="----=_Part_101122_26190942.1175511617091"

------=_Part_101122_26190942.1175511617091
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I'm getting some problem while using Bluez hci function calls. The pseudo
code is as under:

...
devId = hci_devid(addr);
sock = hci_open_dev(devId);
...
fcntl(sock, F_SETFL, O_NONBLOCK); /** whats the problem ??? */
...
hci_read_local_name(sock, size, name, 0)
....


If I comment call to fcntl()  , I get correct name of device by using
hci_read_local_name() function.
But if the call is made to fcntl(),  subsequent  calls of hci_* function
does not work properly. In fact hci_read_local_name()  returns  null name.
Any idea what is the problem with usage of  fcntl() this way ?

Regards,

Tushar Paturde

------=_Part_101122_26190942.1175511617091
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I&#39;m getting some problem while using Bluez hci function calls. The pseudo code is as under:<br><br>...<br>devId = hci_devid(addr);<br>sock = hci_open_dev(devId);<br>...<br clear="all"><span style="background-color: rgb(204, 255, 255);">
fcntl(sock, F_SETFL, O_NONBLOCK); /** whats the problem ??? */</span><br>...<br>hci_read_local_name(sock, size, name, 0)<br>....<br><br><br>If I comment call to fcntl()&nbsp; , I get correct name of device by using hci_read_local_name() function. 
<br>But if the call is made to fcntl(),&nbsp; subsequent&nbsp; calls of hci_* function does not work properly. In fact hci_read_local_name()&nbsp; returns&nbsp; null name.&nbsp; <br>Any idea what is the problem with usage of&nbsp; fcntl() this way ?<br>
<br> Regards,<br>&nbsp;<br>Tushar Paturde

------=_Part_101122_26190942.1175511617091--


--===============1247211352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1247211352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1247211352==--
