Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 29 Oct 2006 16:49:18 +0000
From: Paul LeoNerd Evans <leonerd-bluez@leonerd.org.uk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061029164917.GA8692@cel.leo>
References: <20061022194012.1819f3d9@morgul.earth>
MIME-Version: 1.0
In-Reply-To: <20061022194012.1819f3d9@morgul.earth>
Subject: Re: [Bluez-users] first message
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0655086567=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0655086567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2006 at 07:40:12PM +0200, Frank Dietrich wrote:
> If have a mobile with bluetooth and want to use it for an
> internet connection. I'm sure it doesn't work because I miss the
> bluetooth basics. ;-)

I do the following on debian/testing to get ppp to talk to my Nokia
6310:

/etc/bluetooth/rfcomm.conf contains:

rfcomm0 {
        bind yes;
        device 00:11:22:33:44:55;
        channel 1;
        comment "Bluetooth connection to Nokia 6310i";
}

For GRPS I then do put this in /etc/ppp/peers/gprs:

debug
noauth
usepeerdns
/dev/rfcomm0 115200
115200
local
crtscts
# Debug - For some reason GPRS seems to time out after 2 minutes. Maybe
# the Orange servers don't reply echos? We'll turn
lcp-echo-failure 0
lcp-echo-interval 0
defaultroute
noipdefault
connect '/usr/sbin/chat -f /etc/ppp/chat-gprs -r /dev/console'

My chat-gprs then contains:

TIMEOUT         5
ECHO            ON
ABORT           '\nBUSY\n'
ABORT           '\nERROR\r'
ABORT           '\nNO ANSWER\r'
ABORT           '\nNO CARRIER\r'
ABORT           '\nNO DIALTONE\r'
ABORT           '\nRINGING\r\n\r\nRINGING\r'
# send the init string
''              \rAT
TIMEOUT         12
# set up GPRS mode and settings
OK              ATE1
OK              'AT+cgdcont=3D1,"IP","orangeinternet"'
# dial the access number
OK              ATD*99***1#
CONNECT         ""


And all should work :)

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFRNuNqRXzCRLr5iQRAiHSAKCbn8b32dIrNlrJzr727a0nPG74PgCdH+Of
NHYEVuBqhQWuHJnW3c0H0mw=
=fUoa
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


--===============0655086567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0655086567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0655086567==--
