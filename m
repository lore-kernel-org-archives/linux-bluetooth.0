Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 12:03:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH] Bluetooth: Fix ADDRINUSE check in SCO sockets
Message-ID: <20120413090317.GB10234@x220.ger.corp.intel.com>
References: <1334244650-11174-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334244650-11174-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Apr 12, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> The ADDRINUSE error should be returned only when the SCO socket is being
> used as a server. This means it should be checked in sco_sock_listen()
> instead of in sco_sock_bind(), because in the later we can't know if it
> is a server or not.
> 
> This patch is required in order to use multiple SCO connections in the
> same Bluetooth adapter.
> 
> Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
> ---
>  net/bluetooth/sco.c |   49 ++++++++++++++++++++++++++++++-------------------
>  1 files changed, 30 insertions(+), 19 deletions(-)

In general the patch looks ok to me except for a few things regarding
the helper function:

> +static int __sco_is_addr_in_use(bdaddr_t *src)

I suppose bool makes more sense than int here. The naming sounds also a
bit awkward to me (otoh maybe this is a normal convention): I'd just
leave out the "_is_" part or at least move it after "addr" to make it
sound more like normal English.

Johan
