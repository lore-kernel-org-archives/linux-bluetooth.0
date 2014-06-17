Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jun 2014 12:15:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/l2test: Fix setopts and getopts functions
Message-ID: <20140617091524.GA30044@t440s.lan>
References: <1402957797-515-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402957797-515-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Jun 17, 2014, Lukasz Rymanowski wrote:
> Level SOL_L2CAP with optname L2CAP_OPTIONS is supported only for BR/EDR
> Since bdaddr_type is set to BDADDR_BREDR by default, there is no sense
> to check also CID.
> 
> This fix le connect which now fails when trying to connect ATT CID on LE
> transport.
> ---
>  tools/l2test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
