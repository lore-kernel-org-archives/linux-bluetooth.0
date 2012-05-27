Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 May 2012 22:37:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Tom Gundersen <teg@jklm.no>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] udev: remove deprecated function
Message-ID: <20120527193741.GB31160@x220.P-661HNU-F1>
References: <1338073677-27983-1-git-send-email-teg@jklm.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338073677-27983-1-git-send-email-teg@jklm.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Sun, May 27, 2012, Tom Gundersen wrote:
> This function has in the past returned "/sys" unconditionally. As of udev-183 it
> is gone, so just replace it with the string.
> ---
>  tools/hid2hci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (after reformatting the commit message to have max 72 character
lines). Thanks.

Johan
