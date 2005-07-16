Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20b987f50507160932183ef50f@mail.gmail.com>
From: Dirk Vanden Boer <dirk.vdb@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] At commands not available
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
Date: Sat, 16 Jul 2005 18:32:06 +0200

Hi,
I'm trying to send AT commands to my mobile phone using an rfcomm
connection. The connection seems to work because I can exectute some
commands (like manufacturer name). But a whole bunch of commands are
not available (eg. battery charge: "AT+CBC\r" returns ERROR). I can
run the AT* command which lists the available commands but a lot of
common commands are not in the list. Could it be that there is
something wrong with my connection?

Minimilistic testing code:
//necessary includes
#include ...

#define BTADDR "00:0E:07:2D:85:C7"
#define CHANNEL 4
#define BUFSIZE 1024

using namespace std;
string ATCommand(int sock, string atcmd);

int main()
{
=09int sock;
=09struct sockaddr_rc laddr, raddr;
=09struct hci_dev_info di;
=09=09
=09if(hci_devinfo(0, &di) < 0) {
=09=09perror("HCI device info failed"); exit(1);
=09}
=09
=09laddr.rc_family =3D AF_BLUETOOTH;
=09laddr.rc_bdaddr =3D di.bdaddr;
=09laddr.rc_channel =3D 0;
=09
=09raddr.rc_family =3D AF_BLUETOOTH;
=09str2ba(BTADDR,&raddr.rc_bdaddr);
=09raddr.rc_channel =3D htobs(CHANNEL);
=09
=09if((sock =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
=09=09perror("socket"); exit(1);
=09}
=09if(bind(sock, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
=09=09perror("bind"); exit(1);
=09}
=09if(connect(sock, (struct sockaddr *)&raddr, sizeof(raddr)) < 0) {
=09=09perror("connect"); exit(1);
=09}
=09
=09cout << "Response:\n" << ATCommand(sock, "AT+CBC\r");
=09
=09close (sock);
=09return 0;
}

string ATCommand(int sock, string atcmd)
{
=09char buf[BUFSIZE];
=09int nbytes;
=09string response =3D "";
=09
=09if(send(sock, atcmd.c_str(), atcmd.length(), 0) =3D=3D -1){
=09=09perror("send"); exit(1);
=09}
=09
=09for(;;)
=09{
=09=09if((nbytes =3D recv(sock, buf, sizeof (buf), 0)) > 0)
=09=09{
=09=09=09response.append(buf);
=09=09=09if (strstr(buf, "\r\nOK") !=3D NULL)
=09=09=09=09break;
=09=09=09if (strstr(buf, "\r\nERROR") !=3D NULL)
=09=09=09=09break;
=09=09}
=09}
=09return response;
}

results in:
AT+CBC
ERROR

Did I forget something that activates the extra commands?

Thanks in advance,
Dirk


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
