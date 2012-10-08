Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Oct 2012 15:39:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, Szymon Janc <szymon@janc.net.pl>
Subject: Re: [PATCH] event: Remove not used btd_event_remote_class
Message-ID: <20121008133905.GA15834@x220.example.org>
References: <1349698288-15112-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349698288-15112-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 08, 2012, Szymon Janc wrote:
> This was used in hciops only. With mgmt interface remote CoD is
> received in EIR from Device Found/Connected events.
> 
> ---
>  src/event.c |   22 ----------------------
>  src/event.h |    1 -
>  2 files changed, 23 deletions(-)

Applied. Thanks.

Johan
