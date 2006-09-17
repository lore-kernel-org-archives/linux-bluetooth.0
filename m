Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 17 Sep 2006 17:25:58 -0300
From: Horacio =?iso-8859-1?Q?J=2E_Pe=F1a?= <horape@compendium.com.ar>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060917202558.GG21347@compendium.com.ar>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Subject: [Bluez-devel] bluetooth dies when trying to use 2 sco links
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


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Attached you'll find the code for a test program that makes a call using
the hands-free profile connected to a cell phone and when the call is
answered it generates echo (so the person who answers the phone will
hear himself)

Running just one instance of it with just one phone, it works great.
When I try to run two instances, each connected to a different phone, it
works for a few seconds and then all the SCO data stops flowing (hcidump
shows nothing) The bluetooth dongle I'm using has a led indicating it's
working. That led gets off permanently and the phones display an
indication saying something like "bluebooth connection lost"

After that, trying to do an hcitool scan dies with:

Scanning ...
Inquiry failed: Connection timed out

On http://www.compendium.net.ar/2sco.hcidump.bz2 you can find an hcidump
of the tests.

The dongle i'm using is:

Bus 001 Device 004: ID 4851:1103

horape@nb:~$ hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0E:A1:00:54:19 ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x32e LMP Ver: 1.1 (0x1) LMP Subver: 0x=
32e
        Manufacturer: Cambridge Silicon Radio (10)
horape@nb:~$ hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0E:A1:00:54:19 ACL MTU: 192:8 SCO MTU: 64:8
        Build 814
horape@nb:~$ hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:0E:A1:00:54:19 ACL MTU: 192:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packe=
ts>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO>

Kernel is:

Linux nb 2.6.17 #4 SMP PREEMPT Wed May 10 13:53:45 CEST 2006 i686 GNU/Linux

Default with KNOPPIX 5.0.1 2006-06-01

I'm working on a toshiba satellite P105-S6024.

The phones i'm using are sony ericsson z520a. The code assumes rfcomm chann=
el 3 is
hands free profile (line 50) and call indicator 10 is callsetup (line 67)

Is somebody able to help? Is there more info I could provide to help in the=
 search
for a solution?

I'm looking forward to have 7 phones connected to a PC, making calls all
at once almost 24/7. Should I try with 7 dongles, one for each phone?
Would that work better?

Thanks!
					HoraPe
---
Horacio J. Pe=F1a
horape@compendium.com.ar
horape@uninet.edu

--ZPt4rx8FFjLCG7dd
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="handsfree-echo.c"

#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sco.h>
#include <fcntl.h>
#include <assert.h>

int fd;

void send_line(char* line)
{
  write(fd, line, strlen(line));
  write(fd, "\xd", 1);
  fprintf(stderr, "send_line:<%s>\n", line);
}

const char* get_line()
{
  static char buf[1024];
  char *bufit=buf;
  while (read(fd, bufit, 1)==1 && *bufit!='\xd') {
    if (*bufit=='\xa')
      bufit = buf;
    else
      bufit++;
    }
  *bufit = '\x0';
  fprintf(stderr, "get_line:<%s>\n", buf);
  return buf;
}

int main(int argc, char *argv[])
{
  if (argc!=3) {
    fprintf(stderr, "argc!=3\n");
    return 1;
  }
  
  fd = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
  if (fd<0) {
    perror("socket error");
    return 1;
  }
  struct sockaddr_rc addr;
  memset(&addr, 0, sizeof(addr));
  addr.rc_family = AF_BLUETOOTH;
  str2ba(argv[1], &addr.rc_bdaddr);
  addr.rc_channel = 3;
  if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("connect error");
    return 1;
  }
  send_line("AT+BRSF=22");
  while (strncmp(get_line(),"OK",2)!=0);
  send_line("AT+CIND=?");
  while (strncmp(get_line(),"OK",2)!=0);
  send_line("AT+CIND?");
  while (strncmp(get_line(),"OK",2)!=0);
  send_line("AT+CMER=3,0,0,1");
  while (strncmp(get_line(),"OK",2)!=0);

  char dialcmd[1024];
  sprintf(dialcmd, "ATD%s;", argv[2]);
  send_line(dialcmd);
  while (strcmp(get_line(),"+CIEV: 10,3")!=0);
  fprintf(stderr, "alerting! connecting SCO\n");
  
  int scofd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
  if (scofd<0) {
    perror("scofd socket");
    return 1;
  }
  struct sockaddr_sco scoaddr;
  memset(&scoaddr, 0, sizeof(scoaddr));
  scoaddr.sco_family = AF_BLUETOOTH;
  str2ba(argv[1], &scoaddr.sco_bdaddr);
  if (connect(scofd, (struct sockaddr *)&scoaddr, sizeof(scoaddr))<0) {
    perror ("scofd connect");
    return 1;
  }

  char scobuf[100][48];
  int scoit=0;
  while (1) {
    while (read(scofd, scobuf[scoit], 48) == 48) {
      scoit = (scoit+1)%(sizeof(scobuf)/sizeof(scobuf[0]));
      write(scofd, scobuf[scoit], 48);
    }
  }
  return 0;
}

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--ZPt4rx8FFjLCG7dd--
