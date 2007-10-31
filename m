Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <a8e1da0710292006u7082d22bo1da87fefe23a7222@mail.gmail.com>
References: <47268999.8010700@storm.ca>
	<a8e1da0710292006u7082d22bo1da87fefe23a7222@mail.gmail.com>
Date: Wed, 31 Oct 2007 17:22:15 +0100
Message-Id: <1193847735.32459.45.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Problems using bluetooth keyboard with
	Nokia	N800...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Dave,

> > < ACL data: handle 44 flags 0x02 dlen 12
> >     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 44 packets 1
> > > ACL data: handle 44 flags 0x02 dlen 12
> >     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > < ACL data: handle 44 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 17 scid 0x0040
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 44 packets 1
> > > ACL data: handle 44 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> >       Connection successful
> > < ACL data: handle 44 flags 0x02 dlen 16
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> >       MTU 48
> > > ACL data: handle 44 flags 0x02 dlen 16
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> >       MTU 48
> > < ACL data: handle 44 flags 0x02 dlen 18
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
> >       Success
> >       MTU 48
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 44 packets 1
> > > ACL data: handle 44 flags 0x02 dlen 18
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
> >       MTU 128
> > < ACL data: handle 44 flags 0x02 dlen 16
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
> >       MTU 48
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 44 packets 1
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 44 packets 1
> > > ACL data: handle 44 flags 0x02 dlen 18
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
> >       MTU 128
> > < ACL data: handle 44 flags 0x02 dlen 12
> >     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 44 packets 1
> > > ACL data: handle 44 flags 0x02 dlen 12
> >     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > < HCI Command: Disconnect (0x01|0x0006) plen 3
> >     handle 44 reason 0x13
> >     Reason: Remote User Terminated Connection
> > > HCI Event: Command Status (0x0f) plen 4
> >     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > > HCI Event: Disconn Complete (0x05) plen 4
> >     status 0x00 handle 44 reason 0x16
> >     Reason: Connection Terminated by Local Host
> >
> Modify the head file :
> /usr/include/bluetooth/hidp.h:
> #define HIDP_DEFAULT_MTU 128
> 
> Then rebuild the hidd. This is a hardcode change, just have a try.

this looks like a bug in the keyboards firmware. The minimum MTU of 48
must be accepted and then use segmentation and reassembly within the
protocol. However if that works, we can change the default MTU value.
Looking at the bluez-utils-3.22 input service source, I just see that we
disabled the MTU requirement code completely for now. So use
bluez-utils-3.22 and use the input service.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
