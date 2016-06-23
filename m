Return-Path: <herbert@gondor.apana.org.au>
Date: Thu, 23 Jun 2016 11:37:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Doing crypto in small stack buffers (bluetooth vs vmalloc-stack
 crash, etc)
Message-ID: <20160623033758.GA7819@gondor.apana.org.au>
References: <CALCETrVJzzKkRsSbgsUmVd_+ArKEgoRSVdG1tVp7CXzFoPyVgA@mail.gmail.com>
 <20160622004214.GA27134@gondor.apana.org.au>
 <CALCETrUnzasc+c5Dxmw+g6U07dTNU4RF0ug1bHj8j2en+7Xj1A@mail.gmail.com>
 <CALCETrUWyNz91WO6O3dNb+YELeZy5q4+oTo6dLRR67P2WvBB8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUWyNz91WO6O3dNb+YELeZy5q4+oTo6dLRR67P2WvBB8g@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 22, 2016 at 02:48:24PM -0700, Andy Lutomirski wrote:
>
> Before I do this, can you explain what the difference is between
> crypto_cipher and crypto_skcipher?  net/bluetooth/smp.c currently uses
> crypto_alloc_skcipher, which you added in:

crypto_cipher operates on a single block.  crypto_skcipher uses
modes of operations and works on multiple blocks.
> 
> commit 71af2f6bb22a4bf42663e10f1d8913d4967ed07f
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Sun Jan 24 21:18:30 2016 +0800
> 
>     Bluetooth: Use skcipher and hash
> 
> Am I just supposed to replace "skcipher" with "cipher" everywhere?

If you're operating on one block only then you should use cipher,
otherwise skcipher would be the appropriate choice.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
