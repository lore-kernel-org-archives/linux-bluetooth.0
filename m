Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000901c53e1a$d8e07e30$0201a8c0@NBVICTOR>
From: "Victor Shcherbatyuk" <victor@win.tue.nl>
To: <bluez-devel@lists.sourceforge.net>
References: <42582BE5.2050407@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0006_01C53E2B.9C518070"
Subject: [Bluez-devel] RFCOMM non-blocking support
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
Date: Mon, 11 Apr 2005 00:15:47 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C53E2B.9C518070
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

Hi Marcel,

This was already discussed a year ago:
question:
http://sourceforge.net/mailarchive/message.php?msg_id=8643791
reply:
http://sourceforge.net/mailarchive/message.php?msg_id=8643793

I have exactly the same problem, I guess.

Instead of EINPROGRESS non-blocking connect() returns EAGAIN (Resource 
temporarily unavailable). The rest seem to be OK (see the source). Select 
waits till the connection is established or an error occurs (at least as it 
looks from hcidump log).

Regards,
      Victor. 

------=_NextPart_000_0006_01C53E2B.9C518070
Content-Type: application/octet-stream;
	name="bluetest.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bluetest.c"

#include <stdio.h>=0A=
#include <errno.h>=0A=
#include <unistd.h>=0A=
#include <fcntl.h>=0A=
#include <sys/socket.h>=0A=
=0A=
#include <bluetooth/bluetooth.h>=0A=
#include <bluetooth/hci.h>=0A=
#include <bluetooth/hci_lib.h>=0A=
#include <bluetooth/rfcomm.h>=0A=
=0A=
int btopen( const char* addr, int chan )=0A=
{=0A=
	struct sockaddr_rc remote_addr, local_addr;=0A=
	bdaddr_t bdaddr;=0A=
	int s, r;=0A=
=0A=
	str2ba(addr, &bdaddr);=0A=
	if ((s =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {=0A=
		perror("socket()");=0A=
		return -1;=0A=
	}=0A=
=0A=
	memset(&local_addr, 0, sizeof(local_addr));=0A=
	local_addr.rc_family =3D AF_BLUETOOTH;=0A=
	bacpy(&local_addr.rc_bdaddr, BDADDR_ANY);=0A=
	if (bind(s, (struct sockaddr *)&local_addr, sizeof(local_addr)) < 0) {=0A=
		perror("bind()");=0A=
		close(s);=0A=
		return -1;=0A=
	}=0A=
=0A=
	if ( fcntl( s, F_SETFL, fcntl( s, F_GETFL ) | O_NONBLOCK ) < 0 )=0A=
		perror("fcntl()");=0A=
=0A=
	memset(&remote_addr, 0, sizeof(remote_addr));=0A=
	remote_addr.rc_family =3D AF_BLUETOOTH;=0A=
	bacpy(&remote_addr.rc_bdaddr, &bdaddr);=0A=
	remote_addr.rc_channel =3D chan;=0A=
	if ( r =3D connect(s, (struct sockaddr *)&remote_addr, =
sizeof(remote_addr)) < 0)=0A=
		perror("connect()");=0A=
	=0A=
	//here returns -1 with EAGAIN (11) =3D Resource temporarily unavailable=0A=
	//EINPROGRESS is expected???=0A=
=0A=
	return s;=0A=
}=0A=
=0A=
int main( int argc, char** argv )=0A=
{=0A=
	int fd, r;=0A=
	fd_set wfds;=0A=
	socklen_t optlen;=0A=
=0A=
	if ( argc < 3 )=0A=
	{=0A=
		printf("Use: bluetalk <address> <channel>\n");=0A=
		exit( 1 );=0A=
	}=0A=
	printf("Opening socket...\n");	=0A=
	if ( ( fd =3D btopen( argv[1], atoi( argv[2] ) ) ) < 0 )=0A=
		exit(1);=0A=
=0A=
	printf("Waiting for open completion...\n");=0A=
	r =3D select(fd + 1, NULL, &wfds, NULL, &tv);=0A=
	if (r<0){=0A=
		perror("select()");=0A=
		close(fd);=0A=
		exit(1);=0A=
	}=0A=
	else=0A=
		printf("success\n");=0A=
=0A=
	//check if connect() succeded=0A=
	getsockopt(fd, SOL_SOCKET, SO_ERROR, (void*)&r, &optlen);	=0A=
	//here  r=3D0 in case of success or r=3Derrno otherwise=0A=
	printf("len=3D%d, r=3D%d\n", optlen, r);=0A=
=0A=
	printf("Closing socket...\n");=0A=
	close( fd );=0A=
=0A=
	return 0;=0A=
}=0A=

------=_NextPart_000_0006_01C53E2B.9C518070--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
