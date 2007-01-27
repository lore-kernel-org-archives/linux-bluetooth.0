Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9555d9ef0701271011x1be2b3a6l15642142312d971d@mail.gmail.com>
Date: Sat, 27 Jan 2007 20:11:41 +0200
From: "=?ISO-8859-1?Q?yunus_=F6zen?=" <saltukbugrahan@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] fedora core 6 and bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0244910878=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0244910878==
Content-Type: multipart/alternative;
	boundary="----=_Part_48941_20603296.1169921501238"

------=_Part_48941_20603296.1169921501238
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I have a fedora core 6 installed laptop. My "uname -r" output is
here :"2.6.18-1.2798.fc6".

I have tried to write some program with these includes :
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

When I try to compile it by gcc I see these error messages :
bluez01.c:5:33: error: bluetooth/bluetooth.h: No such file or directory
bluez01.c:6:27: error: bluetooth/hci.h: No such file or directory
bluez01.c:7:31: error: bluetooth/hci_lib.h: No such file or directory

What can I do now?

Thanks,
Saltuk.

------=_Part_48941_20603296.1169921501238
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I have a fedora core 6 installed laptop. My &quot;uname -r&quot; output is <br>here :&quot;2.6.18-1.2798.fc6&quot;.<br><br>I have tried to write some program with these includes : <br>#include &lt;stdio.h&gt;
<br>#include &lt;stdlib.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;sys/socket.h&gt;<br>#include &lt;bluetooth/bluetooth.h&gt;<br>#include &lt;bluetooth/hci.h&gt;<br>#include &lt;bluetooth/hci_lib.h&gt;<br><br>When I try to compile it by gcc I see these error messages :
<br>bluez01.c:5:33: error: bluetooth/bluetooth.h: No such file or directory<br>bluez01.c:6:27: error: bluetooth/hci.h: No such file or directory<br>bluez01.c:7:31: error: bluetooth/hci_lib.h: No such file or directory<br>
<br>What can I do now?<br><br>Thanks,<br>Saltuk.<br>

------=_Part_48941_20603296.1169921501238--


--===============0244910878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0244910878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0244910878==--
