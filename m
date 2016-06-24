Return-Path: <linux-crypto-owner@vger.kernel.org>
Date: Fri, 24 Jun 2016 07:36:44 +0100
From: Salvatore Benedetto <salvatore.benedetto@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, fengguang.wu@intel.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [cryptodev:master 79/79] (.text+0x330de0): multiple definition
 of `ecdh_shared_secret'
Message-ID: <20160624063644.GA21443@localhost>
References: <201606240302.rtIGIxRf%fengguang.wu@intel.com>
 <20160624060649.GA21165@localhost>
 <20160624061012.GA16850@gondor.apana.org.au>
 <20160624062316.GA16985@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160624062316.GA16985@gondor.apana.org.au>
Sender: linux-crypto-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 24, 2016 at 07:23:16AM +0100, Herbert Xu wrote:
> On Fri, Jun 24, 2016 at 02:10:12PM +0800, Herbert Xu wrote:
> > On Fri, Jun 24, 2016 at 07:06:49AM +0100, Salvatore Benedetto wrote:
> > >
> > > can you squash the following patch?
> > 
> > No, please prune anything that we don't use from ecc.c.
> 
> I take that back.  I see it's actually coming from bluetooth.
> 
> How about moving ecc.c to lib so that it's shared between the
> two?

The patch was based on the current tree. I just pulled.
There is not point in moving to lib because bluetooth is
about to be converted to kpp. 
That patch I believe will go up the bluetooth tree, so
my suggestion is to simply accept that I fail to properly
name that symbol.

Renaming the symbol in net/bluetooth/ecc which I think will conflict
with the patch where I remove it completely which, again, I believe
will go up the BT tree.

Thanks,
Salvatore

> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
