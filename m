Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 12:29:09 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: zheng wu <wu.zheng@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fixing crash in irmc.c when vcard=0
Message-ID: <20110726092909.GB28891@dell>
References: <1310714442-14565-1-git-send-email-wu.zheng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310714442-14565-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 15, 2011, zheng wu wrote:
> When using sync profile, if getting the number of vcard is 0 in server,obexd will crash.
> The reason is that the null point is used in query_result of irmc.c.The patch is for fixing it.
> Signed-off-by: wu.zheng@intel.com  
> ---
>  plugins/irmc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

The patch itself seems ok to me, but you need to fix your git settings:

1. Don't use Signed-off-by (this is only used for kernel patches).
2. Format your commit message lines to max 72 characters
3. Fix your git author name (first letter capitalized, etc.)

Johan
