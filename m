Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Garreau <xavier@xgarreau.org>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200310281437.01092.xavier@xgarreau.org>
Subject: [Bluez-devel] Wrong errno
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 28 Oct 2003 14:37:01 +0100

Hi,

I'm currently developping an application with bluez. I wrote a little cod=
e to=20
test the alarm behaviour with bluez sockets code.

The connect and read (or recv) get interrupted but errno is set to ESPIPE=
 (29)=20
instead of EINTR (4). Does any one of you guys know why i'm getting this=20
illegal seek operation errno ?

Regards,

my sample code is below :

#include <signal.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/l2cap.h>
#include <sys/ioctl.h>
#include <errno.h>

extern int errno;

void alarm_handler(int sig) {
=09printf ("IN alarm_handler\n");
}

int get_socket(char* watch_addr) {
=09int s;
=09struct sockaddr_l2 addr;
=09bdaddr_t bdaddr;


=09if ((s =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) {
=09=09perror("Can't create socket ");
=09=09return 0;
=09}

=09bacpy(&bdaddr, BDADDR_ANY);
=09memset(&addr, 0, sizeof(addr));
=09addr.l2_family =3D AF_BLUETOOTH;
=09addr.l2_bdaddr =3D bdaddr;
=09addr.l2_psm =3D htobs(0XCC33);

        if (bind(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
=09=09perror("Can't bind socket ");
=09=09return 0;
        }

=09baswap(&addr.l2_bdaddr, strtoba(watch_addr));
        if (connect(s, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
=09=09perror("Can't connect ");
=09=09printf ("errno : %d\n", errno);
=09=09return 0;
        }
=09return s;
}

char* attends_data(int s) {
=09int i;
=09int encore =3D 0;
=09char buff[256];

=09encore =3D read(s, buff, 256);
=09if (encore =3D=3D -1 || errno) {
=09=09perror("Echec lors de la lecture");
=09=09return NULL;
=09}
=09return NULL;
}


int main (void) {
=09int aSocket;

=09signal (SIGALRM, alarm_handler);
=09siginterrupt (SIGALRM, 1);

=09alarm(20);
=09printf ("Connexion ! \n");
=09aSocket =3D get_socket ("00:04:76:f1:6c:f9");

=09if (aSocket) {
=09=09printf ("Connect=E9 ! \n");
=09=09alarm(5);
=09=09printf ("Lecture ! \n");
=09=09if (!attends_data (aSocket)) {
=09=09=09printf ("errno : %d\n", errno);
=09=09} else {
=09=09=09printf ("OK !\n");
=09=09=09alarm(0);
=09=09}
=09=09shutdown (aSocket, 2);
=09}
=09close (aSocket);
}

--=20
Xavier Garreau
http://www.xgarreau.org



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
