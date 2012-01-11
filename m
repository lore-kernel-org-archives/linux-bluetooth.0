Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 15:55:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/3] Fix not responding when driver_get_headers
 return 0
Message-ID: <20120111135551.GB27506@x220>
References: <1326288123-31807-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326288123-31807-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jan 11, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When calling driver_get_headers it may not be ready but after the backend
> respond the result can still be 0 which indicades no headers need to
> added and we can start sending the body.
> ---
>  src/obex.c |   40 ++++++++++++++++++----------------------
>  1 files changed, 18 insertions(+), 22 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
