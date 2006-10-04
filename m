Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Per Thomas Jahr <perja@extern.uio.no>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 04 Oct 2006 22:00:40 +0200
Message-Id: <1159992040.19347.29.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Problems with security block
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

Hi, 

(I hope this is the correct list to post questions like this to).

I'm programming a Java server that listens for incoming bluetooth
connections. This server runs on Fedora 4 with the avetana library as
the layer between Java and bluez. For the client, I use a Sony Ericsson
K800i with a small application written in Java Micro Edition.

Most things works fine, except for the second connection attempt from my
client to the server. For this attempt, I always get the message
"security block" in the client and the connection attempt fails. The
only way to connect again is to restart my server. Using hcidump shows
that there is far less information exchanged in the second attempt than
in the first.

Does anyone know what happens? It seems like bluez keeps information
about known devices or handle devices that have connected differently.
If so, can I somehow get bluez to forget about already connected
devices?

The documentation [1] says this about the error I'm getting:

SECURITY_BLOCK:
"Indicates the connection failed because the security settings on the
local device or the remote device were incompatible with the request."

Thanks
Per Thomas Jahr


[1]
http://java.sun.com/javame/reference/apis/jsr082/javax/bluetooth/BluetoothConnectionException.html


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
