Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 11:29:01 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH 01/10] Bluetooth: Use #include <linux/uaccess.h>
 instead of <asm/uaccess.h>
Message-ID: <20110217142901.GC10543@joana>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
 <1297948601-12723-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297948601-12723-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-02-17 14:16:32 +0100]:

> As warned by checkpatch.pl, use #include <linux/uaccess.h> instead of
> <asm/uaccess.h>.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
