Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Oct 2015 09:59:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Kunio AKASHI <k_akashi@jaist.ac.jp>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hciconfig: Fix hci_close_dev
Message-ID: <20151027075931.GB23267@t440s.ger.corp.intel.com>
References: <1445899930-28915-1-git-send-email-k_akashi@jaist.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445899930-28915-1-git-send-email-k_akashi@jaist.ac.jp>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kunio,

On Tue, Oct 27, 2015, Kunio AKASHI wrote:
> It had been closed different file descriptor.
> When has two or more interfaces, hciconfig -a exit after cmd_class function.
> 
> Signed-off-by: Kunio AKASHI <k_akashi@jaist.ac.jp>
> ---
>  tools/hciconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks. Note that I had to manually remove the Signed-off-by
line since we don't use that for user space patches (only kernel ones).

Johan
