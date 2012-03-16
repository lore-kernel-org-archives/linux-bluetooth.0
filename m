Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:06:15 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Don't allow to set invalid value to
 DeviceID source
Message-ID: <20120316150615.GB19444@joana>
References: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
 <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2012-03-16 16:02:57 +0100]:

> Reply with MGMT_STATUS_INVALID_PARAMS when userspace is trying to set
> source with out-of-scope value.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

This one should go to bluetooth.git first.

Acked-by: Gustavo Padovan <gustavo@padovan.org>

	Gustavo
