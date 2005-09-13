Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1126640851.2890.8.camel@panic>
Mime-Version: 1.0
Subject: [Bluez-devel] FYI: obex server with support for put/get obexftp
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
Date: Tue, 13 Sep 2005 21:47:31 +0200

maybe some of you are interested ...

sobexsrv - or the scripting OBEX server
        
is a Linux OBEX server with support for OPUSH put/get and OBEXFTP. The
server is currently Bluetooth only and build ontop of openobex and BlueZ
(of course).
        
The server handles only the basic OBEX operations and calls an external
executable for all the application-logic (like OBEXFTP). The basic
script included in the package can do OPUSH put/get and OBEXFTP. 
        
The code is in early development so watch out for bugs!
        
Download it here http://www.mulliner.org/bluetooth/sobexsrv-0.1.tar.gz

... Collin

--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
All programmers are optimists --Frederick P. Brooks, Jr.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
