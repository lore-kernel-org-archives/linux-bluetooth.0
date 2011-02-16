Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 16:04:50 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] telephony-maemo6: fix not cleaning up network status
 on exit
Message-ID: <20110216190450.GD21777@jh-x301>
References: <1297867103-7310-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297867103-7310-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Feb 16, 2011, Luiz Augusto von Dentz wrote:
> This may cause indicators to not be reported correctly when adapter is
> reset.
> ---
>  audio/telephony-maemo6.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

This patch has also been pushed upstream, thanks.

Johan
