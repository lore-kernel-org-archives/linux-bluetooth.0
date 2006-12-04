Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0612040036w43593c77xcb45bdef114ca95f@mail.gmail.com>
Date: Mon, 4 Dec 2006 09:36:41 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1165180510.19590.68.camel@localhost>
MIME-Version: 1.0
References: <b5dccebe0612031030v75c15bf6o688a5b198d6d6bb5@mail.gmail.com>
	<1165171236.19590.65.camel@localhost>
	<b5dccebe0612031122h4d49b82ehb26400eb1e350437@mail.gmail.com>
	<1165180510.19590.68.camel@localhost>
Subject: Re: [Bluez-users] Timeout for connections
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

Hi Marcel,

I ended up creating a little helper program that I run suid root that
sets the Page Timeout on startup of my application. I also use this
program to set the local name and try to force the inquiry mode to get
RSSI. I have a feeling that you won't like hearing about this at all
and you will probably take the opportunity to tell me I should use
D-BUS. Something which I'm thinking about more and more. The problem
with D-BUS is just that there is no Obex service available, and I
don't want half my application using D-BUS and the other half not. So
then I'm thinking more and more about writing a D-BUS Obex service.
But before I do that it would be nice to get some feedback on the
thoughts I have for that API. Where would be a good place to get that
feedback? This mailing list is certanly one place, but what more is
there?

-- Mikael

On 12/3/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mikael,
>
> > > > I would like to be able to set a timeout for service discoveries (and
> > > > eventually for rfcomm connections as well, but so far I've been
> > > > experimenting with service discoveries). For this I use non blocking
> > > > sockets by passing SDP_NON_BLOCKING to sdp_connect. Then I use select
> > > > with a timeout on the socket, and if it times out I call sdp_close.
> > > >
> > > > The problem is that after I have done this I can't use the bluetooth
> > > > chip for other connections for some time. Dumping the traffic with
> > > > hcidump, I saw that this is because even though the l2cap socket is
> > > > closed, the bluetooth chip is still doing the connection in the
> > > > background. For this connection to actually get canceled the chip
> > > > needs to be sent a HCI_Create_Connection_Cancel command, but it is not
> > > > sent when the socket is closed.
> > >
> > > use a 2.6.19 kernel and this command will be sent.
> > >
> >
> > Oh ok... Haven't had to build my own kernel before but I guess there
> > is a first time for everything... I'm using ubuntu and they say it
> > won't be available until next version in april... Problem is that
> > there are people who I can't tell "build the latest kernel" who relies
> > on the software I'm developing... what to do...
>
> there is a chance that Fedora Core will update their kernel to 2.6.19
> very soon. Otherwise you are out of luck.
>
> > Is there another way I can set a timeout for connections?
>
> No. Only the kernel can keep track of connections. If you try to do it
> by yourself in userspace you will break more than you fix. The reference
> count for the ACL link is tricky and only the kernel has all needed
> information to do it right.
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
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
