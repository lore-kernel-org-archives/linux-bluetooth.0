Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 May 2011 22:14:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix btio.c compilation warning
Message-ID: <20110505191451.GA15874@jh-x301>
References: <y>
 <4dc2f2a9.f0c7ec0a.7feb.654f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4dc2f2a9.f0c7ec0a.7feb.654f@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 05, 2011, anderson.briglia@openbossa.org wrote:
> This patch fixes a compilation warning regarding btio/btio.c. Actually
> this warning seems a false positive by Ubuntu Natty GCC version. A new
> bug on Ubuntu bug system was opened but if you do not want to wait until
> it is analyzed, just apply this minor fix.
> 
> btio/btio.c: In function 'bt_io_get':
> btio/btio.c:803:11: warning: 'flushable' may be used uninitialized in
> this function
> ---
>  btio/btio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
