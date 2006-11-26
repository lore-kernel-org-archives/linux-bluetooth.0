Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d66c3bdf0611251658t6051e1cev487a98786d3671d9@mail.gmail.com>
Date: Sat, 25 Nov 2006 16:58:20 -0800
From: "Uichin (Eugene) Lee" <netssenger@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] periodic inquiry mode.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear All,

I have a real quick question on a periodic inquiry mode defined in
Bluetooth spec. as of 1.1 standard. It's also called a symmetric
discovery procedure and we could initiate this by feeding feed min and
max values for inquiry intervals as well as # of inquiries to be
performed. However, it's only defined in HCI and I realized that it's
pretty tough to use it in the application layer (since we're using a
high level programming using sockets). We recently wrote a paper on
P2P file sharing using bluetooth and there, we used application layer
emulation for this periodic inquiry mode; specifically, we used
HCI_inquiry to discover nodes, but we simply used a socket to listen
to a port to make a node available for discovery (i.e., implicitly in
inquiry/page scan mode). Is there any better way that we could
actually exploit this, yet exploiting high-level programming features
of Bluez?

Thank you.

-- 
Uichin (Eugene) Lee
Ph.D. Student UCLA CS Dept.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
