Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jun 2010 11:30:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gateway_server_remove should unref audio_adapter
Message-ID: <20100604083043.GB2714@jh-x301>
References: <1275639598-22048-1-git-send-email-yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275639598-22048-1-git-send-email-yanhai.zhu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jun 04, 2010, Zhu Yanhai wrote:
> gateway_server_remove should unrefer the adapter, not refer it.
> 
> Signed-off-by: Zhu Yanhai <yanhai.zhu@linux.intel.com>

We don't use Signed-off-by in userspace BlueZ. I fixed it manually for
you this time. Also try to start the summary line with "Fix ..." for any
bugfixes (take a look at the upstream git how I changed it). With those
commit message changes the patch has now been pushed upstream.

Johan
