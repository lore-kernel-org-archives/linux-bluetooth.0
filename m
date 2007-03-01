Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ddea76ce0703010629y4930307chdbd0a6e366ca5ad9@mail.gmail.com>
Date: Thu, 1 Mar 2007 14:29:09 +0000
From: "Meenakshi Seeballack" <meena2010@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Help: missing Bluetooth header file
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0103958324=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0103958324==
Content-Type: multipart/alternative;
	boundary="----=_Part_14279_26782118.1172759349101"

------=_Part_14279_26782118.1172759349101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I am new to the linux world and I have installed Eclipse, with CDT.
I am running the simplescan code off this website
http://people.csail.mit.edu/albert/bluez-intro/c401.html and I am getting
these errors:
simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or directory
simplescan.c:7:27: error: bluetooth/hci.h: No such file or directory
simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory
simplescan.c: In function 'main':
simplescan.c:12: error: 'inquiry_info' undeclared (first use in this
function)
simplescan.c:12: error: (Each undeclared identifier is reported only once
simplescan.c:12: error: for each function it appears in.)
simplescan.c:12: error: 'ii' undeclared (first use in this function)
simplescan.c:28: error: 'IREQ_CACHE_FLUSH' undeclared (first use in this
function)
simplescan.c:29: error: expected expression before ')' token
simplescan.c:36: warning: incompatible implicit declaration of built-in
function 'memset'
simplescan.c:39: warning: incompatible implicit declaration of built-in
function 'strcpy'
simplescan.c:46:2: warning: no newline at end of file

I can see these header files:
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci_core.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/rfcomm.h
/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/sco.h

Where is the hci_lib.h header file? Can anyone please assist me?
Meena

------=_Part_14279_26782118.1172759349101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>I am new to the linux world and I have installed Eclipse, with CDT.<br>I am running the simplescan code off this website <a href="http://people.csail.mit.edu/albert/bluez-intro/c401.html">http://people.csail.mit.edu/albert/bluez-intro/c401.html
</a> and I am getting these errors:<br><span style="font-weight: bold;">simplescan.c:6:33: error: bluetooth/bluetooth.h: No such file or directory</span><br style="font-weight: bold;"><span style="font-weight: bold;">simplescan.c
:7:27: error: bluetooth/hci.h: No such file or directory</span><br style="font-weight: bold;"><span style="font-weight: bold;">simplescan.c:8:31: error: bluetooth/hci_lib.h: No such file or directory</span><br>simplescan.c
: In function 'main':<br>simplescan.c:12: error: 'inquiry_info' undeclared (first use in this function)<br>simplescan.c:12: error: (Each undeclared identifier is reported only once<br>simplescan.c:12: error: for each function it appears in.)
<br>simplescan.c:12: error: 'ii' undeclared (first use in this function)<br>simplescan.c:28: error: 'IREQ_CACHE_FLUSH' undeclared (first use in this function)<br>simplescan.c:29: error: expected expression before ')' token
<br>simplescan.c:36: warning: incompatible implicit declaration of built-in function 'memset'<br>simplescan.c:39: warning: incompatible implicit declaration of built-in function 'strcpy'<br>simplescan.c:46:2: warning: no newline at end of file
<br><br>I can see these header files:<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/bluetooth.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/hci.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686
/include/net/bluetooth/hci_core.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/l2cap.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686/include/net/bluetooth/rfcomm.h<br>/usr/src/kernels/2.6.19-1.2911.fc6-i686
/include/net/bluetooth/sco.h<br><br>Where is the hci_lib.h header file? Can anyone please assist me?<br>Meena<br><br><br><br><br><br><br><br>

------=_Part_14279_26782118.1172759349101--


--===============0103958324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0103958324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0103958324==--
