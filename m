Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel lista <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1127865130.15926.18.camel@panic>
Mime-Version: 1.0
Subject: [Bluez-devel] bluetooth filesystem integration
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 27 Sep 2005 16:52:10 -0700

Hi All,

Marcel and I have decided to include btfs into the bluez-utils. Btfs is
for integrating some kind of bluetooth services into the filesystem, so
you could mount an obexftp "share" into your local filesytem. The whole
idea is based on some work I did some time ago
(http://mulliner.org/bluetooth/btfs.php). The system will be based on
FUSE (Filesystem in Userspace).

So this post is basically to anounce btfs and to gether some ideas on
what you guys think is need and useful.

... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
If we aren't supposed to eat animals, why are they made of meat?



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
