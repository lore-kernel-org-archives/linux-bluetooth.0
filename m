Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Olivier Dole <olivier.dole@palmsource.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 11 Dec 2006 15:58:22 +0100
Message-Id: <1165849102.5344.71.camel@ODole-Ubuntu>
Mime-Version: 1.0
Subject: [Bluez-devel] PAN profile BUG?
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

Hello,

I work on PAN profile and there is maybe a bug if we refer to the specs
(PAN profile v1.0).
I've run a PANU server with pand daemon on my Linux machine and I was
able to connect 2 different devices to this server. And according to the
specification (page 15):
        2.1.3 PANU-PANU
        In this scenario, a point to point connection between two PANUs
        allows direct communication between these two nodes only.

So the second connection should fail, isn't it ? I suppose (not test it)
that the same behavior occurs with GN or NAP role. I mean that you can
connect more than 7 peers to the server.

I have a look at pand source code and see that the changes require to
fix this behavior is not completly trivial. A solution may be to use 2
global variable: "max_connection" (which may be set to 1 or 7 if PANU or
GN/NAP role is run) and "connected" to know the number of currently
connected device to the server. Unfortunately fork() call prevent us
from correctly keeping up to date the second variable. So I would have
to replace fork() call by pthread_create() call to try to keep my 2nd
variable up to date. And this lead to many changes in do_listen()
function.
So regarding that, I have two questions:
- Can someone with more Bluetooth knowledge than me confirm that is a
bug ?
- Has anyone a better/simpler solution than me to fix this if that's
really a bug. I can do the fix but I'd like to choose the best solution
for everyone.

Regards,

Olivier DOLE


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
