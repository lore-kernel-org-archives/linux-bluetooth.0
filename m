Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 12:07:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/client: Fix crash in tab completion
Message-ID: <20131030100718.GA19488@x220.p-661hnu-f1>
References: <1383125472-6813-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383125472-6813-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Wed, Oct 30, 2013, Jerzy Kasenberg wrote:
> When user pressed tab on third or later argument when
> first two did not make sense tool crashed.
> Now method is checked for NULL before accessing help field.
> ---
> First version was doing to much (crash was gone but so was
> completion when completion function was not provided, just help
> string)
> 
>  android/client/tabcompletion.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
