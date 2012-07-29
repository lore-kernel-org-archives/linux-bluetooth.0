Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jul 2012 17:04:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 1/2] btio: Replace g_set_error by ERROR_FAILED
 macro
Message-ID: <20120729150448.GB19214@x220>
References: <1343311869-5179-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343311869-5179-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Jul 26, 2012, Claudio Takahasi wrote:
> This patch replaces the calls of g_set_error function by the local
> defined macro "ERROR_FAILED".
> ---
>  btio/btio.c |   19 +++++++------------
>  1 files changed, 7 insertions(+), 12 deletions(-)

Both patches have been applied. Thanks.

Johan
