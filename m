Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 22:06:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2] Fix unloading of adapter drivers
Message-ID: <20110310200609.GA6749@jh-x301>
References: <201103101516.30070.szymon.janc@tieto.com>
 <1299769834-11133-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299769834-11133-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 10, 2011, Szymon Janc wrote:
> Call driver remove callback only if corresponding probe succeed.
> ---
>  src/adapter.c |   47 +++++++++++++++++++++++++++++++----------------
>  1 files changed, 31 insertions(+), 16 deletions(-)

Pushed upstream. Thanks.

Johan
