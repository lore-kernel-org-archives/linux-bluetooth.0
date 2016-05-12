Return-Path: <salvatore.benedetto@intel.com>
From: "Benedetto, Salvatore" <salvatore.benedetto@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"gustavo@padovan.org" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "Benedetto, Salvatore"
	<salvatore.benedetto@intel.com>
Subject: RE: [PATCH v2] Bluetooth: convert smp and selftest to crypto kpp API
Date: Thu, 12 May 2016 20:28:45 +0000
Message-ID: <309B30E91F5E2846B79BD9AA9711D03190263A@IRSMSX102.ger.corp.intel.com>
References: <1462831206-2947-1-git-send-email-salvatore.benedetto@intel.com>
 <20160512180455.GA4802@t440s.P-661HNU-F1>
In-Reply-To: <20160512180455.GA4802@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> -----Original Message-----
> From: linux-crypto-owner@vger.kernel.org [mailto:linux-crypto-
> owner@vger.kernel.org] On Behalf Of Johan Hedberg
> Sent: Thursday, May 12, 2016 7:05 PM
> To: Benedetto, Salvatore <salvatore.benedetto@intel.com>
> Cc: herbert@gondor.apana.org.au; gustavo@padovan.org; linux-
> bluetooth@vger.kernel.org; linux-crypto@vger.kernel.org;
> marcel@holtmann.org
> Subject: Re: [PATCH v2] Bluetooth: convert smp and selftest to crypto kpp
> API
>=20
> Hi Salvatore,
>=20
> On Mon, May 09, 2016, Salvatore Benedetto wrote:
> >  * Convert both smp and selftest to crypto kpp API
> >  * Remove module ecc as not more required
> >  * Add ecdh_helper functions for wrapping kpp async calls
> >
> > This patch has been tested *only* with selftest, which is called on
> > module loading. smp-tester passes all tests but the first one, which
> > often times out. Same behavior is observed without this patch though.
> >
> > This patch is based on https://patchwork.kernel.org/patch/9050061/
> >
> > Signed-off-by: Salvatore Benedetto <salvatore.benedetto@intel.com>
> > ---
> >  net/bluetooth/Makefile      |   2 +-
> >  net/bluetooth/ecc.c         | 816 ------------------------------------=
--------
> >  net/bluetooth/ecc.h         |  54 ---
> >  net/bluetooth/ecdh_helper.c | 204 +++++++++++
> > net/bluetooth/ecdh_helper.h |  32 ++
> >  net/bluetooth/selftest.c    |   6 +-
> >  net/bluetooth/smp.c         |   8 +-
> >  7 files changed, 244 insertions(+), 878 deletions(-)  delete mode
> > 100644 net/bluetooth/ecc.c  delete mode 100644 net/bluetooth/ecc.h
> > create mode 100644 net/bluetooth/ecdh_helper.c  create mode 100644
> > net/bluetooth/ecdh_helper.h
>=20
> I tried this together with your kpp patches and I was able to successfull=
y pair,
> so from that perspective we're fine and I have no objections for those
> patches being merged.
>=20
> There are a couple of things to improve with this patch however:
>=20
> The first issue is that you're missing a 'select CRYPTO_ECDH' in
> net/bluetooth/Kconfig. Without this you'll end up creating a kernel that
> either doesn't build or a module that doesn't load.
>=20

Right the module won't load. I'll fix this.

> > +#ifndef __ECDH_HELPER_H
> > +#define __ECDH_HELPER_H
>=20
> Please leave out these include guards for internal headers. We try to avo=
id
> them there to force keeping the dependency chains simple. I realize you
> might have copied this from smp.h (which is the only internal header I co=
uld
> see having this) so that might need fixing in a separate patch.
>=20

Actually I didn't pay much attention to this as I always use them.
I'll remove it.

> > +bool compute_ecdh_shared_secret(const u8 pub_a[64], const u8
> priv_b[32],
> > +				u8 secret[32]);
> > +bool generate_ecdh_key_pair(u8 public_key[64], u8 private_key[32]);
>=20
> Could you try to come up with some shorter names than these since they
> cause the line lengths to go past 80 chars. In fact, can't you just keep =
the
> same names as our ecc.c was using. I don't think those names are taken by
> your new kpp code?

They actually are used internally by the ecc module I reworked.
I'll rename them to compute_ecdh_secret() and generate_ecdh_keys() which
fixes the 80 chars per line issue.

I'll send a v3.

Thanks for reviewing.

Regards,
Salvatore=20
