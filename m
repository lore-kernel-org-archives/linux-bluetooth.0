Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 15:43:01 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Increment reference counter when a io_watcher is
 added
Message-ID: <20101122144301.GC2303@jh-x301>
References: <1290413446-5391-1-git-send-email-sancane@gmail.com>
 <1290413266-3949-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290413266-3949-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Mon, Nov 22, 2010, Jose Antonio Santos Cadenas wrote:
> Also a destroy function is added in order to avoid memory leaks
> ---
>  health/mcap.c |   28 +++++++++++++++++++---------
>  1 files changed, 19 insertions(+), 9 deletions(-)

The patch content itself is fine but you need to fix the commit message.
Now you have half of the info in the summary and half in the message
body (both halves being equaly relevant). The summary line should be a
summary of the whole patch (in this case it could be e.g. "Fix MDL
reference counting for IO watchers") and the body should contain the
details. So please reformulate, resend, and pay more attention to this
kind of things in the future. Thanks :)

Johan
