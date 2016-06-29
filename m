Return-Path: <netdev-owner@vger.kernel.org>
Date: 29 Jun 2016 08:10:24 -0400
Message-ID: <20160629121024.2497.qmail@ns.sciencehorizons.net>
From: "George Spelvin" <linux@sciencehorizons.net>
To: herbert@gondor.apana.org.au, linux@sciencehorizons.net
Subject: Re: Doing crypto in small stack buffers (bluetooth vs vmalloc-stack crash, etc)
Cc: linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org,
	luto@amacapital.net, netdev@vger.kernel.org
In-Reply-To: <20160629022049.GA23390@gondor.apana.org.au>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> Also not mentioned in the documentation is that some algorithms *do*
>> have different implementations depending on key size.  SHA-2 is the
>> classic example.

> What do you mean by that? SHA has no keying at all.

In this case, the analagous property is hash size.  Sorry, I thought
that was so obvious I didn't need to say it.

Specifically, SHA2-256 (and -224) and SHA2-512 (and -384) are separate
algorithms with similar structures but deparate implementations.
