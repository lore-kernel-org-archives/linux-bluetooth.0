Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: maca02@atlas.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problems pairing with Nokia 3650
In-Reply-To: <002801c37bbf$60443a80$0201a8c0@zazoumobile>
Message-ID: <Pine.LNX.4.55.0309172102430.9571@maca.fortech.cz>
References: <73d8c3bd2463806fbd0544eec8b00c2b@www1.mail.volny.cz>
 <Pine.LNX.4.55.0309152052130.4567@maca.fortech.cz> <002801c37bbf$60443a80$0201a8c0@zazoumobile>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 17 Sep 2003 21:04:08 +0200 (CEST)

> Coming back to your problem, try to launch sdpd but don't advert any service
> and let us know .

How to run the sdpd without adverting any service?


On Mon, 15 Sep 2003, Xavier GARREAU wrote:

> > > HCI Event: Connect Request(0x04) plen 10
> > < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> > > HCI Event: Command Status(0x0f) plen 4
> > > HCI Event: Connect Complete(0x03) plen 11
> > > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> > < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> > > HCI Event: Command Status(0x0f) plen 4
> > > HCI Event: Connection Packet Type Changed(0x1d) plen 5
> > > ACL data: handle 0x0029 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 1 scid 0x0045
> > < ACL data: handle 0x0029 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0045 result 2
> > status 0 > HCI Event: Number of Completed Packets(0x13) plen 5
> > > HCI Event: Max Slots Change(0x1b) plen 3
> > > HCI Event: Disconn Complete(0x05) plen 4
>
> This behaviour is strange but, it seems that your phones are trying to
> establish a sdp connection (connection request psm 1 over L2CAP). Your
> device answers "no" to it (dcid=0 and result=2) so the sdp connection fails
> and so goes the pairing.
>
> To what i know, pairing should not be done this way. First a key request
> should occur and you have to answer with a pin code request reply. Then,
> only when the pairing is ok the remote device should browse your sdp server.
>
> I build some apps dealing with bluetooth and a home made minimal windows
> stack with the sony ericsson P800 which does it this way. That's hopeful,
> since i haven't had the time to code sdp till now...
>
> Coming back to your problem, try to launch sdpd but don't advert any service
> and let us know ...
>
> BR,
> Xavier Garreau
>
>
>
>
>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
