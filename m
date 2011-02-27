Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Feb 2011 16:19:01 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: davem@davemloft.net, linville@tuxdriver.com,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix BT_L2CAP and BT_SCO in Kconfig
Message-ID: <20110227191901.GC2166@joana>
References: <20110226013639.GA2166@joana>
 <1298684485-3081-1-git-send-email-padovan@profusion.mobi>
 <AANLkTimuyx4ixPq5BexRHozebVpjry2k-2xskqVf79g1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimuyx4ixPq5BexRHozebVpjry2k-2xskqVf79g1@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vitaly,

* Vitaly Wool <vitalywool@gmail.com> [2011-02-26 18:52:44 +0100]:

> Hi Gustavo,
> 
> On Sat, Feb 26, 2011 at 2:41 AM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > If we want something "bool" built-in in something "tristate" it can't
> > "depend on" the tristate config option.
> >
> > Report by DaveM:
> >
> >   I give it 'y' just to make it happen, for both, and afterways no
> >   matter how many times I rerun "make oldconfig" I keep seeing things
> >   like this in my build:
> >
> > scripts/kconfig/conf --silentoldconfig Kconfig
> > include/config/auto.conf:986:warning: symbol value 'm' invalid for BT_SCO
> > include/config/auto.conf:3156:warning: symbol value 'm' invalid for BT_L2CAP
> >
> > Reported-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > ---
> >  net/bluetooth/Kconfig |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> > index c6f9c2f..6ae5ec5 100644
> > --- a/net/bluetooth/Kconfig
> > +++ b/net/bluetooth/Kconfig
> > @@ -31,9 +31,10 @@ menuconfig BT
> >          to Bluetooth kernel modules are provided in the BlueZ packages.  For
> >          more information, see <http://www.bluez.org/>.
> >
> > +if BT != n
> > +
> >  config BT_L2CAP
> >        bool "L2CAP protocol support"
> > -       depends on BT
> >        select CRC16
> >        help
> >          L2CAP (Logical Link Control and Adaptation Protocol) provides
> > @@ -42,11 +43,12 @@ config BT_L2CAP
> >
> >  config BT_SCO
> >        bool "SCO links support"
> > -       depends on BT
> >        help
> >          SCO link provides voice transport over Bluetooth.  SCO support is
> >          required for voice applications like Headset and Audio.
> >
> > +endif
> > +
> 
> Ugh, isn't it far cleaner to change initial dependencies to "depends
> on BT != n" ?

I just followed the same approach as net/ipv6/Kconfig and
net/mac80211/Kconfig. 

Dave, how do you prefer this?

-- 
Gustavo F. Padovan
http://profusion.mobi
