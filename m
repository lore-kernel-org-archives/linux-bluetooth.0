Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 14:46:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vladimir Davydov <vladimir.davydov@promwad.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sergey Kovalev <sergey.kovalev@promwad.com>
Subject: Re: [PATCH] hciattach: Fix the timeout handling code
Message-ID: <20100630114629.GA5961@jh-x301>
References: <201006301441.25119.vladimir.davydov@promwad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201006301441.25119.vladimir.davydov@promwad.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vladimir,

On Wed, Jun 30, 2010, Vladimir Davydov wrote:
> From: Vladimir Davydov <vladimir.davydov@promwad.com>
> 
> The variable 'retries' should be defined as static, or it will be always 0.

The patch doesn't apply cleanly:

Applying: hciattach: Fix the timeout handling code
fatal: corrupt patch at line 13
Patch failed at 0001 hciattach: Fix the timeout handling code

Maybe you could try git send-email instead?

> Signed-off-by: Vladimir Davydov <vladimir.davydov@promwad.com>

We don't use Signed-off-by in the userspace part of BlueZ, so please leave it
away. Otherwise the patch looked fine.

Johan
