Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0702190128n149fa456if5bc854aca1574a0@mail.gmail.com>
Date: Mon, 19 Feb 2007 14:58:06 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Help needed for setting up multiple connection using
	single bluetooth adapter
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1771815667=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1771815667==
Content-Type: multipart/alternative;
	boundary="----=_Part_19172_11037492.1171877286577"

------=_Part_19172_11037492.1171877286577
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,

   I have already posted few mails regarding before ,also tried different
things at my end  , but things didnt went anywhere. Now setting up and using
this feature has become a necessity for my project so i would be making more
effort from now on.

The first question that i have is  ---- What is the procedure for doing such
a thing , till now what i have tried can be summarized as below :-

i) Fork two different processes.

ii) For each process establish RFCOMM connection via socket call.

iii) For each RFCOMM port perform OBEX_PUSH by registering a custom
protocol.

The above method works fine for single process but when in multiply process
mode few unexpected things happen which are :-

i) Sometimes one process waits for the other to get completed.
ii) One of the processes errors out.

Also in previous mail u mentioned i should inquire whether my adapter
supports such a feature. I have a adapter that is bluetooth version 2
compliant , does that guarantee that it supports multiple connections and is
there some bluez query that can find out whether my adapter supports such
features.

Any help would be really appreciated.
Waiting for reply.

regards
siddhant

------=_Part_19172_11037492.1171877286577
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Marcel,<br><br>&nbsp;&nbsp; I have already posted few mails regarding before ,also tried different things at my end&nbsp; , but things didnt went anywhere. Now setting up and using this feature has become a necessity for my project so i would be making more effort from now on.
<br><br>The first question that i have is&nbsp; ---- What is the procedure for doing such a thing , till now what i have tried can be summarized as below :-
<br><br>i) Fork two different processes. <br><br>ii) For each process establish RFCOMM connection via socket call.<br><br>iii) For each RFCOMM port perform OBEX_PUSH by registering a custom protocol.<br><br>The above method works fine for single process but when in multiply process mode few unexpected things happen which are :-
<br><br>i) Sometimes one process waits for the other to get completed.<br>ii) One of the processes errors out.<br><br>Also in previous mail u mentioned i should inquire whether my adapter supports such a feature. I have a adapter that is bluetooth version 2 compliant , does that guarantee that it supports multiple connections and is there some bluez query that can find out whether my adapter supports such features.
<br><br>Any help would be really appreciated.<br>Waiting for reply.<br><br>regards<br>siddhant<br>

------=_Part_19172_11037492.1171877286577--


--===============1771815667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1771815667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1771815667==--
