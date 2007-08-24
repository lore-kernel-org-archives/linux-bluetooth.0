Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5920d1e0708240809k8f00ec6h5a28dd1463c742d7@mail.gmail.com>
Date: Fri, 24 Aug 2007 17:09:04 +0200
From: "Hamid MENOUAR" <menouar@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1187967599.15402.183.camel@violet>
MIME-Version: 1.0
References: <BAY122-F23EB2BD61028C16F758A23FFD50@phx.gbl>
	<1187957880.15402.157.camel@violet>
	<d5920d1e0708240706t22fd0f73p29220630ed9a7644@mail.gmail.com>
	<1187965621.15402.179.camel@violet>
	<d5920d1e0708240747g7199080at71c3350b641563e1@mail.gmail.com>
	<1187967599.15402.183.camel@violet>
Subject: Re: [Bluez-users] Can't connect RFCOMM
	socket:Resourcetemporarilyunavailable
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

You're right, it was that the problem. I started hcid and now
everything is working well.

Thank you very much Marcel,
Hamid

On 8/24/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hamid,
>
> > Oups! sorry, here is the output then:
> >
> > [root@localhost ~]# hcidump -X -V
> > HCI sniffer - Bluetooth packet analyzer ver 1.18
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Create Connection (0x01|0x0005) plen 13
> >     bdaddr 00:0D:18:60:14:8E ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > > HCI Event: Command Status (0x0f) plen 4
> >     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > > HCI Event: Connect Complete (0x03) plen 11
> >     status 0x00 handle 12 bdaddr 00:0D:18:60:14:8E type ACL encrypt 0x00
> > < ACL data: handle 12 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 3 scid 0x0040
> > < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> >     handle 12 policy 0x0f
> >     Link policy: RSWITCH HOLD SNIFF PARK
> > > HCI Event: Command Complete (0x0e) plen 6
> >     Write Link Policy Settings (0x02|0x000d) ncmd 1
> >     status 0x00 handle 12
> > > HCI Event: Max Slots Change (0x1b) plen 3
> >   0000: 0c 00 05                                          ...
> > > ACL data: handle 12 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 1 status 2
> >       Connection pending - Authorization pending
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 12
> > > HCI Event: PIN Code Request (0x16) plen 6
> >     bdaddr 00:0D:18:60:14:8E
> > > ACL data: handle 12 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 3 status 0
> >       Connection refused - security block
> > > HCI Event: Disconn Complete (0x05) plen 4
> >     status 0x00 handle 12 reason 0x13
> >     Reason: Remote User Teminated Connection
>
> you don't have hcid running and so no PIN code handling at. So you can't
> access the device. As simple as that.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
