Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Apr 2010 22:51:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jos=E9?= Antonio Santos Cadenas
	<jcaden@libresoft.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bug in sdp_set_supp_features solved
Message-ID: <20100428195127.GA24058@jh-x301>
References: <201004281208.35923.jcaden@libresoft.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201004281208.35923.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 28, 2010, José Antonio Santos Cadenas wrote:
> From 567522ed4ac5912d967fef3017bf905591b5c24e Mon Sep 17 00:00:00 2001
> From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
> Date: Wed, 28 Apr 2010 12:02:31 +0200
> Subject: [PATCH] Bug in sdp_set_supp_features solved
> 
> When the data is a string or a sequence, it is not ok to dereference
> data->val because it is already a pointer.
> ---
>  lib/sdp.c |   33 +++++++++++++++++++++++++++++++--
>  1 files changed, 31 insertions(+), 2 deletions(-)

The patch has been pushed upstream with some minor changes. I had to
edit the commit message again (try "git am" on your mail yourself and
you'll see the difference to what got pushed upstream) and I named the
new variable lengths instead of sizes since the function it gets passed
to is called sdp_seq_alloc_with_length.

Since there's no code in the bluez tree that calls this
sdp_set_supp_features function do you perhaps have some simple code
snippet/use case that the fixed functionality could be tested with?

Johan
