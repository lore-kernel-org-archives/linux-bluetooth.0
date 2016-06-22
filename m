Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160622004214.GA27134@gondor.apana.org.au>
References: <CALCETrVJzzKkRsSbgsUmVd_+ArKEgoRSVdG1tVp7CXzFoPyVgA@mail.gmail.com>
 <20160622004214.GA27134@gondor.apana.org.au>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 21 Jun 2016 17:52:23 -0700
Message-ID: <CALCETrUnzasc+c5Dxmw+g6U07dTNU4RF0ug1bHj8j2en+7Xj1A@mail.gmail.com>
Subject: Re: Doing crypto in small stack buffers (bluetooth vs vmalloc-stack
 crash, etc)
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andy Lutomirski <luto@kernel.org>, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>, Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 21, 2016 at 5:42 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Jun 21, 2016 at 10:43:40AM -0700, Andy Lutomirski wrote:
>>
>> Is there a straightforward way that bluetooth and, potentially, other
>> drivers can just do synchronous crypto in a small buffer specified by
>> its virtual address?  The actual cryptography part of the crypto code
>> already works this way, but I can't find an API for it.
>
> Yes, single block users should use crypto_cipher_encrypt_one, an
> example would be drivers/md/dm-crypt.c.
>

Aha!  I expected something like that to exist, but I couldn't find it.
I'll change the two offenders I've found so far to use it.

--Andy
