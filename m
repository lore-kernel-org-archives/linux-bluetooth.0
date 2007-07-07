Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0707070612k74197fc2i411ce8bec2de2087@mail.gmail.com>
Date: Sat, 7 Jul 2007 18:42:43 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] performing more than one sdp inquiry at same time buy
	using more than one dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1438916663=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1438916663==
Content-Type: multipart/alternative;
	boundary="----=_Part_125507_9025388.1183813963944"

------=_Part_125507_9025388.1183813963944
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,


I have written an application that uses multiple dongles. One dongle
performs continuous serach for the devices and other dongles perform sdp
inquiry on the searched devices. The observation that i have can be written
as below:-

i) When performing sdp inquiry and device search at same time (although
using different dongles about which i am very sure).... call for sdp_connect
fail very often.

ii) When i do the same thing one by one that is first performing search then
doing sdp inquiry ( at this time hci inquiry is not running) the rate of
sdp_connect is very high.

The way i want my the application to work is the setup in (i) . Please can u
tell me what is causing failure of sdp_connect in i and if this behavior is
unexpected then  how can i debug the issue my self.


regards
siddhant

------=_Part_125507_9025388.1183813963944
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br>I have written an application that uses multiple dongles. One dongle performs continuous serach for the devices and other dongles perform sdp inquiry on the searched devices. The observation that i have can be written as below:-
<br><br>i) When performing sdp inquiry and device search at same time (although using different dongles about which i am very sure).... call for sdp_connect fail very often.<br><br>ii) When i do the same thing one by one that is first performing search then doing sdp inquiry ( at this time hci inquiry is not running) the rate of sdp_connect is very high.
<br><br>The way i want my the application to work is the setup in (i) . Please can u tell me what is causing failure of sdp_connect in i and if this behavior is unexpected then&nbsp; how can i debug the issue my self.<br><br><br>
regards<br>siddhant<br><br><br>

------=_Part_125507_9025388.1183813963944--


--===============1438916663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1438916663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1438916663==--
