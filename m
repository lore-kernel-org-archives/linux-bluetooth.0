Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5f30e2610608031549x70d290edi33d9ae67a873ad03@mail.gmail.com>
Date: Thu, 3 Aug 2006 17:49:58 -0500
From: "Jeff Wilson" <jazzbotley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1154649927.3905.79.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <5f30e2610608021526g5083268mad6565d7c13877f9@mail.gmail.com>
	<1154600985.3905.58.camel@aeonflux.holtmann.net>
	<5f30e2610608031017w1d65e4dakb9f2ef2144670f5a@mail.gmail.com>
	<5f30e2610608031445qf67c5e8p12ea39b8be27077@mail.gmail.com>
	<1154649927.3905.79.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] nonblocking socket
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

No, I'm not directly creating HCI connections.  I use
socket(...,BTPROTO_RFCOMM) and then use that fd with read()/write()

On a hunch, I rebuilt my bluez-lib from the 2.25 tgz, re-installed,
then restarted hcid, sdpd, etc.  I can now use sdptool without error.

I guess libbluetooth got corrupted by a power-interruption reset?

Thanks for the feedback.  Sorry for the noise.

        Best regards,
          Jeff

On 8/3/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jeff,
>
> > Never mind on the example program, no need to create one, I can
> > reproduce the problem with sdptool v2.25:
> >
> > `sdptool browse <remote-addr>`
> >
> > Failed to connect to SDP server on <remote-addr>: Operation already in progress
> >
> > local hcidump -X -V
> >
> > HCI sniffer - Bluetooth packet analyzer ver 1.30
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Create Connection (0x01|0x0005) plen 13
> >     bdaddr remote-addr ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > > HCI Event: Command Status (0x0f) plen 4
> >     Create Connection (0x01|0x0005) status 0x0b ncmd 1
> >     Error: ACL Connection Already Exists
>
> can you test it with latest 2.6.17-mh5 kernel?
>
> This error indicates that an ACL already exists. Are you playing with
> HCI connection creation from userspace? If you do so, then don't.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
