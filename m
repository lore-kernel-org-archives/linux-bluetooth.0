Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jonathan McDowell <noodles@earth.li>
To: David@vitrant.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: Fwd: [Bluez-users] bluez and billionton pcbtc1
Message-ID: <20050330094703.GE20882@earth.li>
References: <b5c638dc05032815321b2739c5@mail.gmail.com> <1112075117.9016.60.camel@pegasus> <b5c638dc05032907582bf771dc@mail.gmail.com> <200503292303.38682.pavouk@pavouk.org> <b5c638dc05032914296f02255e@mail.gmail.com> <20050329223648.GR20882@earth.li> <b5c638dc05032914567e36f215@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b5c638dc05032914567e36f215@mail.gmail.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 30 Mar 2005 10:47:03 +0100

On Tue, Mar 29, 2005 at 05:56:57PM -0500, David Vitrant wrote:
> mind you i have no idea what i'm doing.
> 
> it's this kernel 2.6.8.1-3-386 will the patch you sent me work also
> for below 2.6.11 ?

I've no idea if it will apply, but I imagine you'll need it to get
anywhere as otherwise the driver won't be able to do high enough baud
rates to talk to the card.

You'll need to get the source to the kernel you're using, apply the
patch, recompile it, install it and then try the setserial and hciattach
commands.

> On Tue, 29 Mar 2005 23:36:48 +0100, Jonathan McDowell <noodles@earth.li> wrote:
> > On Tue, Mar 29, 2005 at 05:29:57PM -0500, David Vitrant wrote:
> > > hey.. i was referred to your post on your CF billionton card.. seems
> > > to have much of the same info asm ine (i attached the other posts ..
> > > do you have anymore insights.. i used your instructions
> > >
> > > but when i did the hciattach it gave me this error bcsp timed out..
> > >
> > > thanks.. i could certainly use the help
> > 
> > What kernel version? Have you applied the patch at:
> > 
> > http://www.summet.com/x31/8250_patch_CFcard.txt
> > 
> > if it's 2.6? I haven't had any luck with 2.4.20 (as on my Zaurus) yet.
> > 
> > > On Tue, 29 Mar 2005 23:03:38 +0200, Pavel Ruzicka <pavouk@pavouk.org> wrote:
> > > > Hello,
> > > >
> > > > before few days 17.3.2005 writes Jonathan McDowell message about
> > > > success with Billionton card with identical ID:
> > > >   product info: "Compact Flash", "Bluetooth Card", "", ""
> > > >   manfid: 0x0279, 0x950b
> > > >
> > > > He suggests these commands:
> > > > setserial /dev/ttyS0 baud_base 912600
> > > > hciattach -s 912600 /dev/ttyS0 bcsp
> > > >
> > > > (His baudrate is probably wrong. 921600 instead 912600 can be).
> > > > But his mail have many additional informations.
> > > > Please look at archive of mailing-list and search for message with subject:
> > > > "Billionton(?) CF card - success".
> > > >
> > > > >   manfid 0x0279, 0x950b
> > > > >   funcid serial_port [post]
> > > > >   serial_interface
> > > > >     uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
> > > > >   vers_1 7.1, "PCMCIA", "Bluetooth Card", "", ""

J.

-- 
] http://www.earth.li/~noodles/ []     noodles is used in pad thai     [
]  PGP/GPG Key @ the.earth.li   []                                     [
] via keyserver, web or email.  []                                     [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
