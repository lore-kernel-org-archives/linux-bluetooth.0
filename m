Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Dec 2013 11:54:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sixaxis: Fix device detection
Message-ID: <20131213095424.GA18447@x220.p-661hnu-f1>
References: <1386864988.1982.45.camel@nuvo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386864988.1982.45.camel@nuvo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Dec 12, 2013, Bastien Nocera wrote:
> After searching past the end of the structure, the loop sometimes
> found matches in the daemon's address space...
> 
> This fixes the loop to end after the elements have been exhausted.
> ---
>  plugins/sixaxis.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
