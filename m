Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Sep 2012 17:02:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gatt: Fix reading Service Changed CCC
Message-ID: <20120906140243.GA15938@x220.P-661HNU-F1>
References: <1346922908-16016-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346922908-16016-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Sep 06, 2012, Andrzej Kaczmarek wrote:
> Find Information Request is only sent when there are no more attributes
> following Service Changed Value (incorrect) and thus will never find CCC.
> ---
>  profiles/gatt/gas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
