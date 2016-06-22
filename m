Return-Path: <herbert@gondor.apana.org.au>
Date: Wed, 22 Jun 2016 08:42:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Doing crypto in small stack buffers (bluetooth vs vmalloc-stack
 crash, etc)
Message-ID: <20160622004214.GA27134@gondor.apana.org.au>
References: <CALCETrVJzzKkRsSbgsUmVd_+ArKEgoRSVdG1tVp7CXzFoPyVgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrVJzzKkRsSbgsUmVd_+ArKEgoRSVdG1tVp7CXzFoPyVgA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 21, 2016 at 10:43:40AM -0700, Andy Lutomirski wrote:
>
> Is there a straightforward way that bluetooth and, potentially, other
> drivers can just do synchronous crypto in a small buffer specified by
> its virtual address?  The actual cryptography part of the crypto code
> already works this way, but I can't find an API for it.

Yes, single block users should use crypto_cipher_encrypt_one, an
example would be drivers/md/dm-crypt.c.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
