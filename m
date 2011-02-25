Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Feb 2011 12:57:23 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Move index to common header in management interface
Message-ID: <20110225155723.GE19437@jh-x301>
References: <1298554607-2527-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298554607-2527-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Feb 24, 2011, Szymon Janc wrote:
> Match changes introduced in mgmt interface after moving controller
> index to common header.
> ---
>  lib/mgmt.h        |   43 +---------
>  plugins/mgmtops.c |  243 +++++++++++++++++++----------------------------------
>  2 files changed, 90 insertions(+), 196 deletions(-)

Pushed upstream. Thanks.

Now let's try to get the kernel patches to bluetooth-next-2.6 asap. I'll
base all my future work on top of them.

Johan
