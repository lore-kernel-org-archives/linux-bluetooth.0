Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: radoa <cat@pobox.sk>
Message-ID: <loom.20041029T203002-259@post.gmane.org>
References: <loom.20041029T194010-621@post.gmane.org> <1099073484.6912.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: hci event bug for Nokia 7650
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Oct 2004 18:47:28 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Radoa,
> 
> > I was trying create L2CAP socket and make connection to Nokia 7650 phone, 
> > but L2CAP always timeouted after about 40 seconds. I started debugging and 
I 
> > discovered that bluez kernel during establishing L2CAP connection drops 
event 
> > packet 0x1B (Max Slots Change) from 7650 phone, so then after timeout 7650 
> > phone send Disconnection Complete (0x05) event. I debugged this in function 
> > hci_event_packet(). Is this bug, or is it something wrong with phone stack, 
or 
> > is somethig wrong with stack, if bug, what should I send for rejecting 
command, 
> > or better how respond for command? I need establish connection using L2CAP 
> > sockets.
> 
> about what Linux kernel version are we talking? What kind of L2CAP
> socket do you try to open?
> 
> Regards
> 
> Marcel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> 

Kernel version is 2.6.9 with Bluetooth kernel patch 2.6.9-mh2.
Here is code (dst address is changed):

int test_connect() 
{
  struct sockaddr_l2 sa;
  int fd, ret;
  bdaddr_t *dst = {{0, 1, 2, 3, 4, 5}};

  // success
  fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

  sa.l2_family = AF_BLUETOOTH;
  sa.l2_psm = htobs(SDP_PSM);               // 0x0001
  sa.l2_bdaddr = *dst; 

  // this will fail
  ret = connect(fd, (struct sockaddr *)&sa, sizeof(sa));

  return ret;
}

best regards

radoa





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
