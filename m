Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c17fe92b0703261559n452cef4apca8113b07980b7ef@mail.gmail.com>
Date: Tue, 27 Mar 2007 04:29:54 +0530
From: "suman karthik" <sumankarthik@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Obex File Transfer SPEED
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0758758594=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0758758594==
Content-Type: multipart/alternative;
	boundary="----=_Part_102328_21826324.1174949994278"

------=_Part_102328_21826324.1174949994278
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have noticed that different flavours of ObexPush on linux have a very low
data transfer rate (10kb/sec, billionton dongle, K750i phone), while
obexPush on windows with the same hardware is upto 4(40kb/sec) times higher.
        I have read somewhere that this is the problem of openObex MTU and
have made subsequent changes to the MTU but i dont see any difference in
speed no matter what MTU configuration i try. Any suggestions on how to
improve bluetooth filetransfer speed on linux?

-- 
-Suman
http://www.zerocaffe.in

------=_Part_102328_21826324.1174949994278
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have noticed that different flavours of ObexPush on linux have a very low data transfer rate (10kb/sec, billionton dongle, K750i phone), while obexPush on windows with the same hardware is upto 4(40kb/sec) times higher.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have read somewhere that this is the problem of openObex MTU and have made subsequent changes to the MTU but i dont see any difference in speed no matter what MTU configuration i try. Any suggestions on how to improve bluetooth filetransfer speed on linux?
<br clear="all"><br>-- <br>-Suman<br><a href="http://www.zerocaffe.in">http://www.zerocaffe.in</a>

------=_Part_102328_21826324.1174949994278--


--===============0758758594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0758758594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0758758594==--
