Return-Path: <luto@kernel.org>
MIME-Version: 1.0
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 21 Jun 2016 10:43:40 -0700
Message-ID: <CALCETrVJzzKkRsSbgsUmVd_+ArKEgoRSVdG1tVp7CXzFoPyVgA@mail.gmail.com>
Subject: Doing crypto in small stack buffers (bluetooth vs vmalloc-stack
 crash, etc)
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>, Marcel Holtmann <marcel@holtmann.org>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

net/bluetooth/smp.c (in smp_e) wants to do AES-ECB on a 16-byte stack
buffer, which seems eminently reasonable to me.  It does it like this:

    sg_init_one(&sg, data, 16);

    skcipher_request_set_tfm(req, tfm);
    skcipher_request_set_callback(req, 0, NULL, NULL);
    skcipher_request_set_crypt(req, &sg, &sg, 16, NULL);

    err = crypto_skcipher_encrypt(req);
    skcipher_request_zero(req);
    if (err)
        BT_ERR("Encrypt data error %d", err);

I tried to figure out what exactly that does, and I got like in so
many layers of indirection that I mostly gave up.  But it appears to
map the stack address to a physical address, stick it in a
scatterlist, follow several function pointers, go through a bunch of
"scatterwalk" indirection, and call blkcipher_next_fast, which calls
blkcipher_map_src, which calls scatterwalk_map, which calls
kmap_atomic (!).  This is anything but fast.

I think this code has several serious problems:

 - It uses kmap_atomic to access a 16-byte stack buffer.  This is absurd.

 - It blows up if the stack is in vmalloc space, because you can't
virt_to_phys on the stack buffer in the first place.  (This is why I
care.)  And I really, really don't want to write sg_init_stack to
create a scatterlist that points to the stack, although such a thing
could be done if absolutely necessary.

 - It's very, very compllicated and it does something very, very
simple (call aes_encrypt on a plain old u8 *).

Oh yeah, it sets CRYPTO_ALG_ASYNC, too.  I can't even figure out what
that does because the actual handling of that flag is so many layers
deep.

Is there a straightforward way that bluetooth and, potentially, other
drivers can just do synchronous crypto in a small buffer specified by
its virtual address?  The actual cryptography part of the crypto code
already works this way, but I can't find an API for it.

--Andy
