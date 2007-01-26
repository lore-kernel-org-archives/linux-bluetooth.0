Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2e9fc96f0701252321k59b0320cld9eef725a6cc06ac@mail.gmail.com>
Date: Fri, 26 Jan 2007 12:51:17 +0530
From: "Prabhu nath" <gprabhunath@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Obex File Transfers between Nokia and BlueZ
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0621895603=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0621895603==
Content-Type: multipart/alternative;
	boundary="----=_Part_125581_18906108.1169796077858"

------=_Part_125581_18906108.1169796077858
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear All,
           This is the 2nd time I am posting the question with more
experiments and more logs.
           Has anyone tried obex file transfers between Nokia and BlueZ.
I tried with following Nokia series. In all of these I was not able to Push
a file from the Cell Phone to my Computer with BlueZ. I can push/pull a file
from BlueZ to Cell Phone
Nokia 6260
Nokia 6681
Nokia N80
Nokia E61
Nokia N93.

On the contrary, Object Push works well with MotoQ.

Here is the configuration of BlueZ :
                   http://brochevarevarura.googlepages.com/bluezconf

Logs of Obj. Push from Nokia to BlueZ :
                   http://brochevarevarura.googlepages.com/N93_to_BlueZ.htm

Logs of Obj. Push from MotoQ to BlueZ :
                  http://brochevarevarura.googlepages.com/MotoQ_to_BlueZ.htm
Observation :
              In case of MotoQ, L2CAP is connection is getting disconnected
after SDP
              negotiation and again reconnecting for the Obex file
transfer.
              whereas In case of Nokia, L2CAP connection is not getting
disconnected after SDP
              Negotiation.

This comparision is based on Observation, but I am not aware of rationale
behind this behaviour.

If anyone has successfully tried out Object Push from Nokia, can you please
get me the configuration and the operation.
Appreciate your help in fishing out the problem.

Thanks,
Prabhu

------=_Part_125581_18906108.1169796077858
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Dear All,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This is the 2nd time I am posting the question with more experiments and more logs.&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Has anyone tried obex file transfers between Nokia and BlueZ. <br>I tried with following Nokia series. In all of these I was not able to Push a file from the Cell Phone to my Computer with BlueZ. I can push/pull a file from BlueZ to Cell Phone
<br>Nokia 6260<br>Nokia 6681 <br>Nokia N80<br>Nokia E61 <br>Nokia N93. </div>
<p>On the contrary, Object Push works well with MotoQ. </p>
<p>Here is the configuration of BlueZ : <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://brochevarevarura.googlepages.com/bluezconf">http://brochevarevarura.googlepages.com/bluezconf</a></p>
<p>Logs of Obj. Push from Nokia to BlueZ : <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://brochevarevarura.googlepages.com/N93_to_BlueZ.htm">http://brochevarevarura.googlepages.com/N93_to_BlueZ.htm</a></p>
<p>Logs of Obj. Push from MotoQ to BlueZ : <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://brochevarevarura.googlepages.com/MotoQ_to_BlueZ.htm">http://brochevarevarura.googlepages.com/MotoQ_to_BlueZ.htm</a></p>
<div>Observation : <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In case of MotoQ, L2CAP is connection is getting disconnected after SDP&nbsp;&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; negotiation and again reconnecting for the Obex file transfer.&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; whereas In case of Nokia, L2CAP connection is not getting disconnected after SDP </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Negotiation. </div>
<div>&nbsp;</div>
<div>This comparision is&nbsp;based on Observation, but I am not aware of rationale behind this behaviour.</div>
<p>If anyone has successfully tried out Object Push from Nokia, can you please get me the configuration and the operation.<br>Appreciate your help in fishing out the problem.</p>
<p>Thanks,<br>Prabhu</p>

------=_Part_125581_18906108.1169796077858--


--===============0621895603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0621895603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0621895603==--
