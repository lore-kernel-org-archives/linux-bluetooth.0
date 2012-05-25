Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 10:42:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/6] AVCTP: Fix setting wrong transaction id
 expected for responses
Message-ID: <20120525074256.GB13680@x220>
References: <1337865771-11777-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337865771-11777-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 24, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The id were incremented after being set to the request so it is always
> +1 of the actual transaction.
> ---
>  audio/avctp.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Patches 1-3 have been applied. For the rest I'm waiting for a v2 based
on the comments that they received.

Johan
