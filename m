Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Aug 2011 13:01:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 obexd] Use 'nice abort' when canceling outgoing OPP
 transer
Message-ID: <20110809100148.GB19242@dell>
References: <1312882866-14011-1-git-send-email-radoslawjablonski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312882866-14011-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Aug 09, 2011, Radoslaw Jablonski wrote:
> Previously client was suddenly disconnecting to cancel
> outgoing OPP transfer. Now ABORT command will be sent
> before disconnecting with server in that scenario.
> 
> This change is required to pass TC_CLIENT_OPH_BV_27_I PTS
> test case (not mandatory for qualification).
> ---
>  gwobex/obex-xfer.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
