Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Feb 2012 12:40:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v3 0/2] Transfer cancelation
Message-ID: <20120227104029.GA4327@x220>
References: <1330336476-13454-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330336476-13454-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Feb 27, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> This patch series proposes several fixes regarding the cancelation of
> transfers.
> 
> This third version includes some minor refactoring of patches v2 5/8
> and 7/8, following the reviews from Johan.
> 
> Mikel Astiz (2):
>   client: terminate queued transfers properly
>   client: fix canceling queued transfers
> 
>  client/session.c  |   30 ++++++++++++++++++++++++++----
>  client/transfer.c |   12 ++++++++----
>  2 files changed, 34 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
