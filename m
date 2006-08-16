Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44E2D81C.7090201@ipb.pt>
Date: Wed, 16 Aug 2006 09:32:28 +0100
From: Rui Pedro Lopes <rlopes@ipb.pt>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44E1187E.6030401@mackintoshweb.com>	<20060815012354.GB15576@refinery.twat.com.ar>	<44E1EAB3.8000308@mackintoshweb.com>
	<20060815223317.GJ15576@refinery.twat.com.ar>
In-Reply-To: <20060815223317.GJ15576@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Totally confused
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I forgot to mention what is happening in syslog:

Aug 16 09:30:06 tash hcid[8833]: Bluetooth HCI daemon
Aug 16 09:30:06 tash sdpd[8835]: Bluetooth SDP daemon
Aug 16 09:30:06 tash hidd[8837]: Bluetooth HID daemon
Aug 16 09:30:06 tash hcid[8833]: Register path:/org/bluez fallback:1
Aug 16 09:30:06 tash hcid[8833]: Device hci0 has been added
Aug 16 09:30:06 tash hcid[8833]: Starting security manager 0
Aug 16 09:30:06 tash hcid[8833]: Can't write inquiry mode for hci0:
Input/output error (5)
Aug 16 09:30:06 tash hcid[8833]: Register path:/org/bluez/hci0 fallback:0
Aug 16 09:30:48 tash hcid[8833]: pin_code_request
(sba=00:03:7A:0A:D9:D9, dba=00:0D:44:43:B7:01)
Aug 16 09:30:48 tash hcid[8833]: call_passkey_agent(): no agent registered


Apparently, there is something missing when the pin code is requested...

Any thoughts?

/rp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4tgcAhGrHSs5PNIRAkbrAJ4kT0+K9hbAzFzGULiiWeJn1r6B5wCglRZX
LwKsmhfZjET3zvjD3Sx9X2g=
=xjrI
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
