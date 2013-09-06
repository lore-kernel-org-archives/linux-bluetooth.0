Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Sep 2013 13:38:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hog: ignore UHID-setup events and document why
Message-ID: <20130906103806.GA4139@x220.p-661hnu-f1>
References: <1378123089-3980-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378123089-3980-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Mon, Sep 02, 2013, David Herrmann wrote:
> The UHID_{START,STOP,OPEN,CLOSE} events should be ignored by us to avoid
> triggering the warn(). It is safe to do that. Add few comments that
> explain why we don't have to handle these.
> ---
>  profiles/input/hog.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
