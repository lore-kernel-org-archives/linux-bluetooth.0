Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jun 2014 10:07:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: vikrampal <vikram.pal@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com
Subject: Re: [PATCH ] Fixed memory issues to avoid potential crash
Message-ID: <20140613070701.GA18475@t440s.lan>
References: <1402479150-27774-1-git-send-email-vikram.pal@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402479150-27774-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Wed, Jun 11, 2014, vikrampal wrote:
> Signed-off-by: vikrampal <vikram.pal@samsung.com>

We don't use Signed-off-by for user space patches so please remove this.
Also, add an "sdp: " prefix to the commit summary, use the consistent
form of the opening verb, i.e. "Fix" instead of "Fixed" and please
provide some short explanation in the commit message body as well.
You'll also need to fix up your git author information to be of the
format "Firstname Lastname <email>" (right now you just have "vikrampal"
as your name).

> ---
>  src/sdp-xml.c       | 16 +++++++++++++++-
>  src/sdpd-database.c |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)

Besides the mentioned cosmetic things the patch looks quite good.

Johan
