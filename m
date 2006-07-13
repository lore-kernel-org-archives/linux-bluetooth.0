Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 13 Jul 2006 08:52:59 +0200
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E88@eumonex01.palmsource.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Alsa plugin for A2DP daemon
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> Terrific work !! :-)

Thank you :D your work with sco is great too! Wish I had seen it before! I'=
m gonna use your ctl plugin as a startup base.

> Just a tip: maybe you could use UNIX sockets to remove TCP burden.

I thought about it, but at the moment, I knew very well internet sockets an=
d not at all unix sockets... This has not changed yet!
In the end, I like the fact it works accross computers. So if it must be do=
ne, it will certainly be configurable.
I read the main TCP task is a checksum calculation and I can still afford i=
t.

Fr=E9d=E9ric


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
