Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Oct 2014 17:56:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: basile@opensource.dyc.edu
Cc: linux-bluetooth@vger.kernel.org, blueness@gentoo.org,
	pacho@gentoo.org
Subject: Re: [PATCH] emulator/serial.c: use posix_openpt() instead of getpt()
Message-ID: <20141007145621.GB10391@t440s.P-661HNU-F1>
References: <1412433102-12904-1-git-send-email-basile@opensource.dyc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412433102-12904-1-git-send-email-basile@opensource.dyc.edu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anthony,

On Sat, Oct 04, 2014, basile@opensource.dyc.edu wrote:
> From: "Anthony G. Basile" <basile@opensource.dyc.edu>
> 
> getpt(3) is glibc-specific and is not provided in musl and possibly
> other libc's. Instead, we use use posix_openpt(3) which is equivalent
> and portable.
> 
> Signed-off-by: Anthony G. Basile <basile@opensource.dyc.edu>
> ---
>  emulator/serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks. I first had to remove the Signed-off-by line though
since we don't don't use that convention for user space patches.

Johan
