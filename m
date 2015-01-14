Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jan 2015 10:03:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use %llu for printing duration details of
 selftests
Message-ID: <20150114080321.GC19106@t440s.P-661HNU-F1>
References: <1421132988-19922-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421132988-19922-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 12, 2015, Marcel Holtmann wrote:
> The duration variable for the selftests is unsigned long long and with
> that use %llu instead of %lld when printing the results.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/selftest.c | 2 +-
>  net/bluetooth/smp.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-hext. Thanks.

Johan
