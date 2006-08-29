Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <50269.157.193.214.17.1156867288.squirrel@www.ibcn.intec.ugent.be>
Date: Tue, 29 Aug 2006 18:01:28 +0200 (CEST)
From: "Dieter Verslype" <dieter.verslype@intec.ugent.be>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20060829180128_81240"
Subject: [Bluez-devel] Registering service / Getting data
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------=_20060829180128_81240
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello list,

I'm developing an application that should capture some data sent by a
bluetooth device.
The device is not discoverable, only comes up when it has some data to se=
nd.
It searches for devices with a certain PIN. When it can pair, it queries
the sdpd for
services meeting the Serial Port Profile (0x1101) and sends the data to
this service.

When I use hcidump, i can see the data pass, but I can't figure out how t=
o
get it in a C program.

I used http://people.csail.mit.edu/albert/bluez-intro/index.html as
reference to program in C.

When I register my service with the sdpd daemon, i don't know how to quer=
y
the sdpd. At least i don't see my service using sdptool. When I run the C
program, nothing happens, the app keeps listening for incoming
connections.

In attachment my hcidump and c-file.

Any tips would come in handy.


gr,

Dieter Verslype

PS: i'm pretty unexperienced when it comes to C programming.
------=_20060829180128_81240
Content-Type: text/plain; name="hcidump.txt"
Content-Disposition: attachment; filename="hcidump.txt"
Content-Transfer-Encoding: quoted-printable

=20
root@laptop:/home/dvrslype# hcidump -X -t
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
1156866276.073822 < HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 06 00                                    3....
1156866276.078498 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
1156866279.143001 > HCI Event: Inquiry Result (0x02) plen 15
  0000: 01 fb 9d d1 bc 16 00 02  02 00 04 02 52 e3 5c     ............R.\
1156866283.767258 > HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .
1156866576.080375 < HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 06 00                                    3....
1156866576.088970 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
1156866576.797853 > HCI Event: Inquiry Result (0x02) plen 15
  0000: 01 fb 9d d1 bc 16 00 02  02 00 04 02 52 9e 5c     ............R.\
1156866583.775727 > HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .
1156866619.667922 > HCI Event: Connect Request (0x04) plen 10
  0000: d0 6a 0d 96 a0 00 00 00  00 01                    .j........
1156866619.667968 < HCI Command: Accept Connection Request (0x01|0x0009) =
plen 7
  0000: d0 6a 0d 96 a0 00 01                              .j.....
1156866619.682923 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
1156866619.722915 > HCI Event: Link Key Request (0x17) plen 6
  0000: d0 6a 0d 96 a0 00                                 .j....
1156866619.741892 < HCI Command: Link Key Request Reply (0x01|0x000b) ple=
n 22
  0000: d0 6a 0d 96 a0 00 fb 0d  77 9e 11 2e 67 3d 03 31  .j......w...g=3D=
.1
  0010: fc 04 b7 97 f9 c3                                 ......
1156866619.771906 > HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 d0 6a 0d 96  a0 00                    .....j....
1156866620.003867 > HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 d0 6a 0d 96 a0  00 01 01                 .)..j......
1156866620.003912 < HCI Command: Write Link Policy Settings (0x02|0x000d)=
 plen 4
  0000: 29 00 0f 00                                       )...
1156866620.005877 > HCI Event: Page Scan Repetition Mode Change (0x20) pl=
en 7
  0000: d0 6a 0d 96 a0 00 01                              .j.....
1156866620.023866 > HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 29 00                                 ....).
1156866620.023905 < HCI Command: Change Connection Packet Type (0x01|0x00=
0f) plen 4
  0000: 29 00 18 cc                                       )...
1156866620.044861 > HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
1156866620.046867 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
1156866620.048863 > HCI Event: Connection Packet Type Changed (0x1d) plen=
 5
  0000: 00 29 00 18 cc                                    .)...
1156866620.052861 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
1156866620.052909 < ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
1156866620.062859 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.072858 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
1156866620.072898 < ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
1156866620.072907 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
1156866620.094857 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.096855 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.104851 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
1156866620.131848 > ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
1156866620.132971 < ACL data: handle 41 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SS Rsp: tid 0x1 len 0xd
          count 2
          handles 0x10000 0x10002
          cont 00
1156866620.138845 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.166845 > ACL data: handle 41 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10000
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
1156866620.168067 < ACL data: handle 41 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1b > >
          cont 00
1156866620.193837 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.245829 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
1156866620.245880 < ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
1156866620.271825 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.279824 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 325
1156866620.279861 < ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
1156866620.279870 < ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
1156866620.302819 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.304817 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.312818 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 325
1156866620.315827 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
1156866620.315867 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
1156866620.340811 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.368807 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 54 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 0
1156866620.368857 < ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 54 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 7
1156866620.395806 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.422801 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 54 pf 1 ilen 0 fcs 0x6e
1156866620.423519 < HCI Command: Authentication Requested (0x01|0x0011) p=
len 2
  0000: 29 00                                             ).
1156866620.446798 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 11 04                                       ....
1156866620.518783 > HCI Event: Auth Complete (0x06) plen 3
  0000: 00 29 00                                          .).
1156866620.518825 < HCI Command: Set Connection Encryption (0x01|0x0013) =
plen 3
  0000: 29 00 01                                          )..
1156866620.532780 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
1156866620.534782 > HCI Event: Encrypt Change (0x08) plen 4
  0000: 00 29 00 01                                       .)..
1156866620.534825 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 54 pf 1 ilen 0 fcs 0xa5
1156866620.534839 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 54 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1156866620.541060 < HCI Command: Remote Name Request (0x01|0x0019) plen 1=
0
  0000: d0 6a 0d 96 a0 00 02 00  00 00                    .j........
1156866620.549779 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
1156866620.554779 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.556780 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866620.583779 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 54 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1156866620.584782 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 54 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
1156866620.584823 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 54 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
1156866620.584838 < ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 54 pf 1 ilen 0 fcs 0xb5 credits 33
1156866620.595777 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 02 00                                    .)...
1156866620.596778 > ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 54 pf 1 ilen 0 fcs 0x6f credits 6
1156866620.618770 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1156866620.618818 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1156866620.635775 > HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 d0 6a 0d 96 a0 00 31  34 31 35 30 35 30 38 30  ..j....14150508=
0
  0010: 30 30 37 31 20 20 00 00  00 00 00 00 00 00 00 00  0071  .........=
.
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ...............=
.
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
1156866620.637766 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
###HERE's DATA I HAVE TO CAPTURE
###VVVVVVVVVVVVVVVVVVVVVVVVVVVVV
1156866620.733754 > ACL data: handle 41 flags 0x02 dlen 82
    L2CAP(d): cid 0x0041 len 78 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 54 pf 0 ilen 74 fcs 0x73
      0000: 02 00 0e 00 00 00 41 01  00 d6 07 08 1c 08 35 16  ......A....=
...5.
      0010: d6 07 08 1d 0f 34 1b d0  6a 0d 96 a0 00 7a 2d 5d  .....4..j..=
..z-]
      0020: 3a 0a 00 35 30 35 30 38  30 30 30 37 31 20 20 00  :..50508000=
71  .
      0030: 00 00 00 00 00 00 00 00  00 d9 00 11 53 54 2c 2b  ...........=
.ST,+
      0040: 30 30 31 2e 31 30 6b 67  0d 0a                    001.10kg..
1156866630.920104 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 54 pf 1 ilen 0 fcs 0x8f
1156866630.920157 < ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 54 pf 1 ilen 0 fcs 0xa5
1156866630.964096 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
1156866630.990090 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
1156866630.990131 < ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
1156866634.904460 > HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 08                                       .)..
------=_20060829180128_81240
Content-Type: text/x-csrc; name="rfcomm-server.c"
Content-Disposition: attachment; filename="rfcomm-server.c"
Content-Transfer-Encoding: quoted-printable

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>

sdp_session_t* register_service();

int main(int argc, char **argv)
{
    //register service in SDPd
    sdp_session_t* session =3D register_service();

    struct sockaddr_rc loc_addr =3D { 0 }, rem_addr =3D { 0 };
    char buf[1024] =3D { 0 };
    int s, client, bytes_read;
    int opt =3D sizeof(rem_addr);

    // allocate socket
    s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // bind socket to port 1 of the first available=20
    // local bluetooth adapter
    loc_addr.rc_family =3D AF_BLUETOOTH;
    loc_addr.rc_bdaddr =3D *BDADDR_ANY;
    loc_addr.rc_channel =3D (uint8_t) 1;
    bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

    // put socket into listening mode
    listen(s, 1);

    // accept one connection
    client =3D accept(s, (struct sockaddr *)&rem_addr, &opt);

    ba2str( &rem_addr.rc_bdaddr, buf );
    fprintf(stderr, "accepted connection from %s\n", buf);
    memset(buf, 0, sizeof(buf));

    // read data from the client
    bytes_read =3D read(client, buf, sizeof(buf));
    if( bytes_read > 0 ) {
        printf("received [%s]\n", buf);
    }

    // close connection
    close(client);
    close(s);
    sdp_close(session);
    return 0;
}

sdp_session_t* register_service() {
    uint32_t service_uuid_int[] =3D { 0, 0, 0, 0x1101 };
    uint8_t rfcomm_channel =3D 11;
    const char *service_name =3D "Healt Monitor Service";
    const char *service_dsc =3D "Captures Bluetooth packages and stores i=
n SQL_DB";
    const char *service_prov =3D "IBCN-Niko";

    uuid_t root_uuid, l2cap_uuid, rfcomm_uuid, svc_uuid;
    sdp_list_t *l2cap_list =3D 0,
               *rfcomm_list =3D 0,
               *root_list =3D 0,
               *proto_list =3D 0,
               *access_proto_list =3D 0;
    sdp_data_t *channel =3D 0, *psm =3D 0;

    sdp_record_t *record =3D sdp_record_alloc();

    // set the general service ID
    sdp_uuid128_create( &svc_uuid, &service_uuid_int );
    sdp_set_service_id( record, svc_uuid );

    // make the service record publicly browsable
    sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
    root_list =3D sdp_list_append(0, &root_uuid);
    sdp_set_browse_groups( record, root_list );

    // set l2cap information
    sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
    l2cap_list =3D sdp_list_append( 0, &l2cap_uuid );
    proto_list =3D sdp_list_append( 0, l2cap_list );

    // set rfcomm information
    sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
    channel =3D sdp_data_alloc(SDP_UINT8, &rfcomm_channel);
    rfcomm_list =3D sdp_list_append( 0, &rfcomm_uuid );
    sdp_list_append( rfcomm_list, channel );
    sdp_list_append( proto_list, rfcomm_list );

    // attach protocol information to service record
    access_proto_list =3D sdp_list_append( 0, proto_list );
    sdp_set_access_protos( record, access_proto_list );

    // set the name, provider, and description
    sdp_set_info_attr(record, service_name, service_prov, service_dsc);
	   int err =3D 0;
    sdp_session_t *session =3D 0;

    // connect to the local SDP server, register the service record, and=20
    // disconnect
    session =3D sdp_connect( BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BUSY =
);
    err =3D sdp_record_register(session, record, 0);

    // cleanup
    sdp_data_free( channel );
    sdp_list_free( l2cap_list, 0 );
    sdp_list_free( rfcomm_list, 0 );
    sdp_list_free( root_list, 0 );
    sdp_list_free( access_proto_list, 0 );
    return session;
}

------=_20060829180128_81240
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_20060829180128_81240
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_20060829180128_81240--
