Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Zbyszek <dzidoz@poczta.fm>
To: mailing list <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=ISO-8859-2
Message-Id: <20040228173402.ECDBD1EC7AB@front.interia.pl>
Subject: [Bluez-users] Problem with l2test
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 28 Feb 2004 18:34:02 +0100

Hi all

I have problem. This is my part of the simple program.
=20
#include <netinet/in.h>
#include <arpa/inet.h>
#include <resolv.h>
#include <netdb.h>
#include <sys/socket.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/l2cap.h>
//Domyslne
bdaddr_t bdaddr;
int main()
{
    struct sockaddr_l2 addr;
    char buf[2048];
    char str[18];
    char *adres=3D"00:10:60:A5:F4:4C";
    int s,i;
    uint8_t id;

    if (( s=3Dsocket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
    {
=09perror("Can't create socket !!!");
=09exit(1);
    }
}

Exactly at this moment error appears.
Even when I try start the program "l2test" I see communique
l2test[4045]: Can't create socket. No such file or directory(2)
So I'm asking you, could you tell me where did I make mistake?

regards
Zbyszek


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
