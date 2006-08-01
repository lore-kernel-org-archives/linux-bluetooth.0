Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44CF31ED.8000405@freemail.hu>
Date: Tue, 01 Aug 2006 12:50:21 +0200
From: Mate Soos <msoos@freemail.hu>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20060801001207.GA5092@as.arizona.edu>
	<1154398819.4982.63.camel@aeonflux.holtmann.net>
In-Reply-To: <1154398819.4982.63.camel@aeonflux.holtmann.net>
Subject: [Bluez-users] Problem developing bluetooth program
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi!

I have been having problems developing a bluetooth program of mine. The
problem, simply put: I open an RFCOMM socket with socket(), bind(),
connect(), and whatever I do, the connect() will fail with Invalid
Argument. I have now made this *extremely simple* program, and I am
having the same damn problem:

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <iostream>
#include <errno.h>
#include <string.h>
#include <sys/socket.h>

int main() {
    int s;
    int channel=3D40;
    char addr[40],addr2[40];
    strcpy(addr,"00:11:67:39:05:0F");
    strcpy(addr2,"00:11:67:39:36:BB");


    std::cerr << "RfcommSocket::connectToHost from " << addr2 << " to
addr: "<< addr << "," << channel << std::endl;
    sockaddr_rc rem_addr, loc_addr;

    if( (s =3D ::socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0 ) {
        std::cerr << "Can't create socket" << strerror(errno) << errno
<< std::endl;
        return -1;
    }

    memset(&loc_addr, 0, sizeof(loc_addr));
    loc_addr.rc_family =3D AF_BLUETOOTH;
    str2ba(addr2,&loc_addr.rc_bdaddr);
    if (bind(s, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0 ) {
        std::cerr  << "Can't bind socket"<<  strerror(errno) << errno <<
std::endl;
        return -1;
    }

    memset(&rem_addr, 0, sizeof(rem_addr));
    rem_addr.rc_family =3D AF_BLUETOOTH;
    str2ba(addr,&rem_addr.rc_bdaddr);
    rem_addr.rc_channel =3D channel;
    if(::connect(s, (struct sockaddr *)&rem_addr, sizeof(rem_addr)) < 0 ){
            std::cerr << "Can't connect." << strerror(errno) << errno <<
std::endl;
            close(s);
            return -1;
    }
    std::cerr << "Connected." << std::endl;
return 0;
}

Output of program:

RfcommSocket::connectToHost from 00:11:67:39:36:BB to addr:
00:11:67:39:05:0F,40
Can't connect.Invalid argument22

Output of hciconf -a:

hci0:   Type: USB
        BD Address: 00:11:67:39:36:BB ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN INQUIRY
        RX bytes:418 acl:0 sco:0 events:22 errors:0
        TX bytes:339 acl:0 sco:0 commands:22 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'masodik'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver:
0x1fe
        Manufacturer: Integrated System Solution Corp. (57)

hci1:   Type: USB
        BD Address: 00:11:67:39:05:0F ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:13012 acl:110 sco:0 events:356 errors:0
        TX bytes:5061 acl:110 sco:0 commands:102 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'elso'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver:
0x1fe
        Manufacturer: Integrated System Solution Corp. (57)


I have *really* read through all the revelant details, I have been
reading the libbluetooth sourcecode nonstop(!), I have copy-pasted
several examples, no luck. It always gives me this stupid error, and I
am totally fed up with it. I have been getting it for the past 1.5
weeks, and I work 4 hours per day on this. Any ideas?

I really appreciate all help,

M=E1t=E9 So=F3s

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
