Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44C89EEF.3060003@student.uib.no>
Date: Thu, 27 Jul 2006 13:09:35 +0200
From: =?ISO-8859-1?Q?St=E5le_Andreas_Kleppe?= <stale.kleppe@student.uib.no>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Enabling authentication and encryption in C
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I'm working on my master thesis about Bluetooth security, and are going =

to test the security and possibly implement some improvements. I program =

in C, and am currently trying to enable authentication and encryption =

through some function calls in hci_lib.h, namly hci_authenticate_link =

and hci_encrypt_link respectively. Below is a part of my code.

int main(void) {
    struct hci_conn_info_req *cr;
    struct sockaddr_rc resciever =3D { 0 };
    struct sockaddr_rc local =3D { 0 };
    uint16_t handle;
    int s, status, dd;

    char destination[17] =3D "00:09:DD:60:02:45";

    resciever.rc_family =3D AF_BLUETOOTH;
    resciever.rc_channel =3D (uint8_t) 1;
    str2ba( destination, &resciever.rc_bdaddr );

    local.rc_family =3D AF_BLUETOOTH;
    local.rc_channel =3D (uint8_t) 1;
    //lokal_addr.rc_bdaddr =3D *BDADDR_ANY;
    str2ba("00:14:A4:D4:0F:A1", &local.rc_bdaddr);
   =

    dd =3D hci_open_dev(hci_get_route(&local.rc_bdaddr));
    cr =3D (struct hci_conn_info_req*) malloc(sizeof(struct =

hci_conn_info_req));
    ioctl(dd, HCIGETCONNINFO, (unsigned long) cr);
    handle =3D cr->conn_info->handle;

    status =3D hci_authenticate_link(dd, handle, 0);
    printf("status: %d\n", status);
    status =3D hci_encrypt_link(dd, handle, (uint8_t)1, 0);
    printf("status: %d\n", status);
    ....
    .... }

Both calls always return -1, and things obviously aren't going as =

expected. I've managed to digg down through several function calls:
hci_authenticate_link -> hci_send_req -> hci_send_cmd -> writev.
writev returns -1 as well and sets the error code variable 'errno' to 77 =

(EBADFD, defined in asm/errno.h and means 'File descriptor in bad state').
I'm not sure what this means.
Thoughts?
Any help will be appreciated!

Regards

St=E5le



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
