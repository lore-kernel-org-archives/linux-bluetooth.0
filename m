Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 May 2012 10:57:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] bluetooth: Fix not setting port to 0 when
 listen fails
Message-ID: <20120516075749.GA26388@x220>
References: <1337098606-5710-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337098606-5710-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, May 15, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> With some only kernels auto assigning psm seem to fail, leaving the psm
> with wrong value:
> 
> obexd[2930]: plugins/bluetooth.c:start() listening on channel 9
> obexd[2930]: bluetooth: unable to listen in psm 65535
> obexd[2930]: plugins/bluetooth.c:start() listening on channel 10
> obexd[2930]: bluetooth: unable to listen in psm 65535
> ---
>  plugins/bluetooth.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Both patches have been applied. Thanks.

Johan
