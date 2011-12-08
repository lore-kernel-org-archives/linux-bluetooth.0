Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 14:23:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btio: Fix byte order conversion when getting L2CAP CID
Message-ID: <20111208122340.GA7281@x220>
References: <1323086085-26024-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323086085-26024-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Mon, Dec 05, 2011, Santiago Carot-Nemesio wrote:
> The L2CAP CID is passed and received in little endian byte order
> through the socket interface so a conversion is in place before
> passing it onwards.
> ---
>  btio/btio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
