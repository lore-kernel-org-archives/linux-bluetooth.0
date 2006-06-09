Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <fe0a97c20606090546w4e53ca48o61f338c44708283@mail.gmail.com>
Date: Fri, 9 Jun 2006 18:16:02 +0530
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Limit on the rfcomm socket buffer
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0169679269=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0169679269==
Content-Type: multipart/alternative;
	boundary="----=_Part_1976_4194237.1149857162590"

------=_Part_1976_4194237.1149857162590
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I think that the rfcomm sockets can't take as large as 1024 bytes unlike
TCP/IP (it gets stuck and I get this "Resource temporarily unavailbale"
error incase I wanna reuse it) .... I know its the SOCKET_STREAM thing , but
I want to know is there any limit on the socket buffer???


regards
Soumya

------=_Part_1976_4194237.1149857162590
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br>I think that the rfcomm sockets can't take as large as 1024 bytes unlike TCP/IP (it gets stuck and I get this &quot;Resource temporarily unavailbale&quot; error incase I wanna reuse it) .... I know its the SOCKET_STREAM thing , but I want to know is there any limit on the socket buffer???
<br><br><br>regards<br>Soumya<br>

------=_Part_1976_4194237.1149857162590--


--===============0169679269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0169679269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0169679269==--
