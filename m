Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 02 Aug 2007 17:57:47 +0100
From: Stephen Keegan <stephen.keegan@ucd.ie>
To: bluez-devel@lists.sourceforge.net
Message-id: <46B20D0B.7000106@ucd.ie>
MIME-version: 1.0
Subject: [Bluez-devel] rfcomm connection using multiple dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I'd really appreciate some help on a problem I'm having. I've tried to
solve it myself but have been unable to do so for quite some time.
Basically, I want to create an rfcomm connection to a remote device
using 2 different dongles (at different times). My local devices are
shown here:

root@3[src]# hciconfig
hci0:   Type: USB
        BD Address: 00:0A:3A:66:62:57 ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:12081 acl:204 sco:0 events:308 errors:0
        TX bytes:4672 acl:204 sco:0 commands:125 errors:0

hci1:   Type: USB
        BD Address: 00:0A:3A:66:63:31 ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2535 acl:28 sco:0 events:77 errors:0
        TX bytes:1044 acl:28 sco:0 commands:41 errors:0


Here is the code I am using:

****************************************************************************************************************
#include <errno.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ioctl.h>

int main(int argc, char* argv[])
{
   bdaddr_t m_bdaddrDongle;
   char thedongle[20];
   strcpy(thedongle,argv[1]);

   if(argc != 3)
   {
       printf("%s <mac_address> <channel>\n\n", argv[0]);
       return 1;
   }

   int dev_id = hci_devid( thedongle );
   struct hci_dev_info m_DevInfo;
   int dd = hci_open_dev(dev_id);
   if (dd < 0)
   {
       printf("Error opening bluetooth device\n");
   }


   m_DevInfo.dev_id = dev_id;
   if (ioctl(dd, HCIGETDEVINFO, (void*) &m_DevInfo))
   {
       printf("Error opening bluetooth device\n");
       hci_close_dev(dd);
       return 1;
   }
   char addr[18];
   ba2str(&m_DevInfo.bdaddr, addr);
   printf("Attached to BT adapter: %s\t%s\n", m_DevInfo.name, addr);
  
   bacpy(&m_bdaddrDongle, &m_DevInfo.bdaddr);
   struct sockaddr_rc laddr, raddr;
   laddr.rc_family = AF_BLUETOOTH;
   bacpy(&laddr.rc_bdaddr, &m_bdaddrDongle);
   laddr.rc_channel = 0;

   char remote_bdaddr[20] = "08:00:17:1B:13:DE";
   printf("Remote Mac address: %s\n", remote_bdaddr);

   raddr.rc_family = AF_BLUETOOTH;
   str2ba(remote_bdaddr, &raddr.rc_bdaddr);
   raddr.rc_channel = atoi(argv[2]);
   printf("Channel: %d\n", raddr.rc_channel);

int m_CommHandle;
if ((m_CommHandle = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
{
printf("Can't create RFCOMM socketi\n");
return 1;
}

int r, e = 0;
errno = 0;
while ((r = connect(m_CommHandle, (struct sockaddr *)&raddr,
sizeof(raddr))) == -1)
{
e = errno;
if (e != EBUSY)
break;
errno = e = 0;
usleep(500000);
}
printf("r=%d; errno=%d; result=%s\n", r, e, strerror(e));

   return r != 0;
}

****************************************************************************************************************

So then, I attempt to run the code with each of my dongles using the
following commands:

./test  00:0A:3A:66:63:31  6 

and

./test  00:0A:3A:66:62:57  6 

When I run the code, the connection is detected by the remote
device(08:00:17:1B:13:DE) and the connection is created successfully.
The problem is that each time I run the code, the first dongle (hci0) is
used by the bluetooth stack. (That dongle starts flashing). Why is this?
I believe that it is due to a problem with the command:

    while ((r = connect(m_CommHandle, (struct sockaddr *)&raddr,
sizeof(raddr))) == -1)

I think that I may need to specify which dongle (hc0 or hci1) should be
used in this command.

If anybody could advise on a solution, I would be very grateful.

regards,

Stephen.








-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
