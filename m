Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jan 2012 16:21:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 1/6] lib: Add Key Size information to the
 security information
Message-ID: <20120124142105.GA1307@x220>
References: <1327413443-26375-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327413443-26375-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Jan 24, 2012, Vinicius Costa Gomes wrote:
> Since some time the kernel has the capability to return the length of
> the key that was used to encrypt the link.
> 
> This patch exposes that field to userspace so more applications can take
> decisions based on this information.
> ---
>  lib/bluetooth.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

All six patches have been applied. Thanks.

Johan
