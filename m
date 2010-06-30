Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 17:39:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vladimir Davydov <vladimir.davydov@promwad.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sergey Kovalev <sergey.kovalev@promwad.com>
Subject: Re: [PATCH] hciattach: Fix the timeout handling code
Message-ID: <20100630143906.GA9724@jh-x301>
References: <1277904079-10360-1-git-send-email-vladimir.davydov@promwad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277904079-10360-1-git-send-email-vladimir.davydov@promwad.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 30, 2010, Vladimir Davydov wrote:
> The variable 'retries' should be defined as static, or it will be always
> 0.
> ---
>  tools/hciattach.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Thanks. The patch is now upstream.

Johan
