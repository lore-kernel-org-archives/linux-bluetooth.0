Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 5 Apr 2007 15:32:26 +0530
Message-ID: <008c01c77769$838ff6b0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <4614C6B7.9040008@free2move.net>
Subject: Re: [Bluez-devel] How to set packet-type and role from source-code?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Markus ,

> If I connect multiple SCO connections from my embedded platform, will
the packet-types dynamically adjust when I add a second and even third
SCO connection? This is why I though I had to specifically set
packet-type to HV1... Could you (or someone that feel for it) just
confirm my thoughts? ;)

First of all you can have only one HV1 SCO link at a time. If you want
three, use HV3. This is because an HV1 packet carries only 10 bytes of
data. Thus in order to have a 64 Kbps HV1 link, SCO packets will have to
be sent every second slot (Tsco = 2) => there is no room for another SCO
link. 64 Kbps HV1 SCO link will cover 100% bluetooth bandwidth. Whereas
HV3 packet carries 30 bytes of data => you can maintain (theoretically
atleast) 3 SCO Links.

Best Regards,

Mayank


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
