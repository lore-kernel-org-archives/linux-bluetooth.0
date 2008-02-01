Return-Path: <cyrus@holtmann.org>
Message-ID: <8f5c4ad0802010514p6c52938fy173541c9600ea55f@mail.gmail.com>
Date: Fri, 1 Feb 2008 18:44:04 +0530
From: "george keane" <chemvell@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Infineon PBA31308
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1312061238=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1312061238==
Content-Type: multipart/alternative;
	boundary="----=_Part_24224_8941883.1201871644580"

------=_Part_24224_8941883.1201871644580
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

         I am using a Infineon PBA31308 module with a ARM board.I have cross
compiled the bluez-utils and bluez-libs for my platform.After I start the
hcid in the background,I call "hciattach ttyS1 any 115200",and when i do
hciconfig the output is
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN INIT RUNNING
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:4 acl:0 sco:0 commands:1 errors:0

and when I give "hciconfig hci0 up"
The output is
#Can't init device hci0: Connection timed out (110)

when we call hciattach with type as 'any' it doesn't do any device
initialization ,right?Does this module require  initialization
while doing hciattach??what are the commands to be passed to initialize
it??From the mailing list archives I found that people have got it up and
running...Can somebody help me to bring it up??

Thanks in advance...
Regards,
G.K.

------=_Part_24224_8941883.1201871644580
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am using a Infineon PBA31308 module with a ARM board.I have cross compiled the bluez-utils and bluez-libs for my platform.After I start the hcid in the background,I call &quot;hciattach ttyS1 any 115200&quot;,and when i do hciconfig the output is<br>
hci0:&nbsp;&nbsp; Type: UART<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN INIT RUNNING<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sco:0 events:0 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:4 acl:0 sco:0 commands:1 errors:0<br>
<br>and when I give &quot;hciconfig hci0 up&quot; <br>The output is&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>#Can&#39;t init device hci0: Connection timed out (110)<br><br>when we call hciattach with type as &#39;any&#39; it doesn&#39;t do any device&nbsp; initialization ,right?Does this module require&nbsp; initialization<br>
while doing hciattach??what are the commands to be passed to initialize it??From the mailing list archives I found that people have got it up and running...Can somebody help me to bring it up??<br><br>Thanks in advance...<br>
Regards,<br>G.K.<br>

------=_Part_24224_8941883.1201871644580--


--===============1312061238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1312061238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1312061238==--
