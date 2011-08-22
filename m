Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 11:15:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Adamek <adamek.kuba@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix encoding of empty unicode headers
Message-ID: <20110822081526.GC11306@dell>
References: <1313327785-7767-1-git-send-email-adamek.kuba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313327785-7767-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Sun, Aug 14, 2011, Jakub Adamek wrote:
> According to IrOBEX:
> "An empty Name header is defined as a Name header of length 3 (one
> byte opcode + two byte length)."
> 
> The current code encodes an empty header with 5 bytes, including two
> bytes of null-terminator.
> 
> This patch assumes that this definition of emptyness applies to all
> unicode headers, not just the name header.
> ---
>  gobex/gobex-header.c     |   11 ++++++++-
>  unit/test-gobex-header.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
