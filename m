Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <4E28CEA517A795438B120F62D182A8C9236CD8@I2KM11-UKBR.domain1.systemhost.net>
From: <graeme.n.brown@bt.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RFCOMM Socket Question
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 14 Oct 2005 14:36:56 +0100


Hi

If I'm trying to program in BlueZ accepting connections on an =
rfcosocket, can I specify
a port value which will allow me to accept incoming RFCOMM connections =
on any RFCOMM
channel (a wild-card channel specification) ? If so, how do I set the=20

/* RFCOMM socket address */
struct sockaddr_rc {
	sa_family_t	rc_family;
	bdaddr_t	rc_bdaddr;
	uint8_t		rc_channel;
};


sockaddr_rc.rc_channel to do this before I call bind ?

E.g.

        int listenfd, cliSocket ;
        sockaddr_rc addr, raddr ;
        socklen_t optlen;

	listenfd =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
	if (listenfd < 0) {
	  printf(Can't create socket: %s (%d)\n", strerror(errno), errno);
          exit(1);
	}

	/* Bind to local address */
	addr.rc_family =3D AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, BDADDR_ANY);
	addr.rc_channel =3D  /* XXX <-- Can I specify a wild-card RFCPMM =
Channel here ? How ?  XXXX */

	if (bind(listenfd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
	   printf( "Can't bind socket: %s (%d)\n", strerror(errno), errno);
	   close(listenfd);
	   exit(1);
	}

        memset(&raddr, 0, sizeof(raddr));
	optlen =3D sizeof(raddr);
	cliSocket =3D accept(listenfd, (struct sockaddr *) &raddr, &optlen);
	 =20
	if (cliSocket < 0) {
	     printf(buff, "Accept failed: %s (%d)\n", strerror(errno), errno);
             close(listenfd) ;
             exit(1);
        }

        /** Use new connection on cliSocket ......   **/


Thanks

Graeme Brown

	=09
	  =20
       =20


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
