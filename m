Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Oct 2012 21:22:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ] core: Fix walking the list while removing elements
Message-ID: <20121004182223.GA22857@x220.P-661HNU-F1>
References: <1349370439-6345-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349370439-6345-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 04, 2012, Lucas De Marchi wrote:
> If we are walking a GSList and remove the element we are pointing to,
> the next iteration g_slist_next() will access previously freed
> memory.
> ---
>  src/device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
