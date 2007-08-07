Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 07 Aug 2007 12:20:06 +0100
From: Stephen Keegan <stephen.keegan@ucd.ie>
In-reply-to: <mailman.159099.1186455104.21973.bluez-devel@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Message-id: <46B85566.1000100@ucd.ie>
MIME-version: 1.0
References: <mailman.159099.1186455104.21973.bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel]  rfcomm connection using multiple dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1236365181=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1236365181==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_3Xyk+HBWbClCU+v52Ho8wA)"

This is a multi-part message in MIME format.

--Boundary_(ID_3Xyk+HBWbClCU+v52Ho8wA)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

hi-Can anybody offer some sort of solution for this? if somebody could,
I could offer some sort of reward. regards. S.



*[Bluez-devel] rfcomm connection using multiple dongles*
From: Stephen Keegan <stephen.keegan@uc...> - 2007-08-02 16:58
Hi,

I'd really appreciate some help on a problem I'm having. I've tried to
solve it myself but have been unable to do so for quite some time.
Basically, I want to create an rfcomm connection to a remote device
using 2 different dongles (at different times). My local devices are
shown here:

root@3[src]# hciconfig
hci0: Type: USB
BD Address: 00:0A:3A:66:62:57 ACL MTU: 1017:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:12081 acl:204 sco:0 events:308 errors:0
TX bytes:4672 acl:204 sco:0 commands:125 errors:0

hci1: Type: USB
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

./test 00:0A:3A:66:63:31 6

and

./test 00:0A:3A:66:62:57 6

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


 

--Boundary_(ID_3Xyk+HBWbClCU+v52Ho8wA)
Content-type: text/html; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
hi-Can anybody offer some sort of solution for this? if somebody could,
I could offer some sort of reward. regards. S.<br>
<br>
<br>
<br>
<table width="100%">
  <tbody>
    <tr>
      <td bgcolor="#dddddd" nowrap="nowrap">
      <div class="forum">
      <div><b>[Bluez-devel] rfcomm connection using multiple dongles<!-- google_ad_section_end --></b></div>
      <small>From: Stephen Keegan <a class="moz-txt-link-rfc2396E" href="mailto:stephen.keegan@uc...">&lt;stephen.keegan@uc...&gt;</a> -
2007-08-02 16:58</small> </div>
      </td>
    </tr>
    <tr>
      <td><!-- google_ad_section_start --> Hi,<br>
      <br>
I'd really appreciate some help on a problem I'm having. I've tried to<br>
solve it myself but have been unable to do so for quite some time.<br>
Basically, I want to create an rfcomm connection to a remote device<br>
using 2 different dongles (at different times). My local devices are<br>
shown here:<br>
      <br>
root@3[src]# hciconfig<br>
hci0: Type: USB<br>
BD Address: 00:0A:3A:66:62:57 ACL MTU: 1017:8 SCO MTU: 64:8<br>
UP RUNNING PSCAN ISCAN<br>
RX bytes:12081 acl:204 sco:0 events:308 errors:0<br>
TX bytes:4672 acl:204 sco:0 commands:125 errors:0<br>
      <br>
hci1: Type: USB<br>
BD Address: 00:0A:3A:66:63:31 ACL MTU: 1017:8 SCO MTU: 64:8<br>
UP RUNNING PSCAN ISCAN<br>
RX bytes:2535 acl:28 sco:0 events:77 errors:0<br>
TX bytes:1044 acl:28 sco:0 commands:41 errors:0<br>
      <br>
      <br>
Here is the code I am using:<br>
      <br>
      <br>
****************************************************************************************************************<br>
#include &lt;errno.h&gt;<br>
#include &lt;netinet/in.h&gt;<br>
#include &lt;arpa/inet.h&gt;<br>
#include &lt;sys/socket.h&gt;<br>
#include &lt;bluetooth/bluetooth.h&gt;<br>
#include &lt;bluetooth/rfcomm.h&gt;<br>
#include &lt;bluetooth/hci.h&gt;<br>
#include &lt;bluetooth/hci_lib.h&gt;<br>
#include &lt;stdio.h&gt;<br>
#include &lt;stdlib.h&gt;<br>
#include &lt;unistd.h&gt;<br>
#include &lt;sys/ioctl.h&gt;<br>
      <br>
int main(int argc, char* argv[])<br>
{<br>
bdaddr_t m_bdaddrDongle;<br>
char thedongle[20];<br>
strcpy(thedongle,argv[1]);<br>
      <br>
if(argc != 3)<br>
{<br>
printf("%s &lt;mac_address&gt; &lt;channel&gt;\n\n", argv[0]);<br>
return 1;<br>
}<br>
      <br>
int dev_id = hci_devid( thedongle );<br>
struct hci_dev_info m_DevInfo;<br>
int dd = hci_open_dev(dev_id);<br>
if (dd &lt; 0)<br>
{<br>
printf("Error opening bluetooth device\n");<br>
}<br>
      <br>
      <br>
m_DevInfo.dev_id = dev_id;<br>
if (ioctl(dd, HCIGETDEVINFO, (void*) &amp;m_DevInfo))<br>
{<br>
printf("Error opening bluetooth device\n");<br>
hci_close_dev(dd);<br>
return 1;<br>
}<br>
char addr[18];<br>
ba2str(&amp;m_DevInfo.bdaddr, addr);<br>
printf("Attached to BT adapter: %s\t%s\n", m_DevInfo.name, addr);<br>
      <br>
bacpy(&amp;m_bdaddrDongle, &amp;m_DevInfo.bdaddr);<br>
struct sockaddr_rc laddr, raddr;<br>
laddr.rc_family = AF_BLUETOOTH;<br>
bacpy(&amp;laddr.rc_bdaddr, &amp;m_bdaddrDongle);<br>
laddr.rc_channel = 0;<br>
      <br>
char remote_bdaddr[20] = "08:00:17:1B:13:DE";<br>
printf("Remote Mac address: %s\n", remote_bdaddr);<br>
      <br>
raddr.rc_family = AF_BLUETOOTH;<br>
str2ba(remote_bdaddr, &amp;raddr.rc_bdaddr);<br>
raddr.rc_channel = atoi(argv[2]);<br>
printf("Channel: %d\n", raddr.rc_channel);<br>
      <br>
int m_CommHandle;<br>
if ((m_CommHandle = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM))
&lt; 0)<br>
{<br>
printf("Can't create RFCOMM socketi\n");<br>
return 1;<br>
}<br>
      <br>
int r, e = 0;<br>
errno = 0;<br>
while ((r = connect(m_CommHandle, (struct sockaddr *)&amp;raddr,<br>
sizeof(raddr))) == -1)<br>
{<br>
e = errno;<br>
if (e != EBUSY)<br>
break;<br>
errno = e = 0;<br>
usleep(500000);<br>
}<br>
printf("r=%d; errno=%d; result=%s\n", r, e, strerror(e));<br>
      <br>
return r != 0;<br>
}<br>
      <br>
      <br>
****************************************************************************************************************<br>
      <br>
So then, I attempt to run the code with each of my dongles using the<br>
following commands:<br>
      <br>
./test 00:0A:3A:66:63:31 6 <br>
      <br>
and<br>
      <br>
./test 00:0A:3A:66:62:57 6 <br>
      <br>
When I run the code, the connection is detected by the remote<br>
device(08:00:17:1B:13:DE) and the connection is created successfully.<br>
The problem is that each time I run the code, the first dongle (hci0) is<br>
used by the bluetooth stack. (That dongle starts flashing). Why is this?<br>
I believe that it is due to a problem with the command:<br>
      <br>
while ((r = connect(m_CommHandle, (struct sockaddr *)&amp;raddr,<br>
sizeof(raddr))) == -1)<br>
      <br>
I think that I may need to specify which dongle (hc0 or hci1) should be<br>
used in this command.<br>
      <br>
If anybody could advise on a solution, I would be very grateful.<br>
      <br>
regards,<br>
      <br>
Stephen.<!-- google_ad_section_end --> </td>
    </tr>
  </tbody>
</table>
<br>
&nbsp; <br>
</body>
</html>

--Boundary_(ID_3Xyk+HBWbClCU+v52Ho8wA)--


--===============1236365181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1236365181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1236365181==--
