Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 27 Jun 2011 15:13:56 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-bluetooth@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Marcel Holtmann <marcel@holtmann.org>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH -next] bluetooth: uses crypto interfaces, select CRYPTO
Message-ID: <20110627181355.GA5964@joana>
References: <20110622163651.7ebc407c.sfr@canb.auug.org.au>
 <20110622100811.258091ff.randy.dunlap@oracle.com>
 <20110627110308.dc64e3a7.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110627110308.dc64e3a7.randy.dunlap@oracle.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Randy Dunlap <randy.dunlap@oracle.com> [2011-06-27 11:03:08 -0700]:

> On Wed, 22 Jun 2011 10:08:11 -0700 Randy Dunlap wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> ping.  still need this patch in linux-next....
> 
> 
> > Recent changes to hci_core.c use crypto interfaces, so select CRYPTO
> > to make sure that those interfaces are present.
> > 
> > Fixes these build errors when CRYPTO is not enabled:
> > 
> > net/built-in.o: In function `hci_register_dev':
> > (.text+0x4cf86): undefined reference to `crypto_alloc_base'
> > net/built-in.o: In function `hci_unregister_dev':
> > (.text+0x4f912): undefined reference to `crypto_destroy_tfm'
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > ---
> >  net/bluetooth/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)

Applied. Thanks.

	Gustavo
