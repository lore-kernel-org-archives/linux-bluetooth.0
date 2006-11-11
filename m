Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4555A023.7030504@gmx.de>
Date: Sat, 11 Nov 2006 11:04:19 +0100
From: Sandro Weiser <sandro.weiser@gmx.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <454FC0AE.5090209@gmx.de>
	<1162855289.31808.95.camel@aeonflux.holtmann.net>
In-Reply-To: <1162855289.31808.95.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Timeout/Reconnect with encrypted connection
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

false alarm ;)

seems like I've forgotten to activate authorisation and encryption
support of the  host device. For some reason activating enc and auth in
hcid.conf is ignored. So I did it manually.

thx
Sandro

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
