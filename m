Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 15:53:09 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Use memcpy for network to host order function on BE
 hosts
Message-ID: <20110217185309.GA19484@jh-x301>
References: <1297964368-23733-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297964368-23733-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Feb 17, 2011, Claudio Takahasi wrote:
> Harmless change replacing "for" by "memcpy". Note that this change
> is inside the block reserved to big endian functions.
> ---
>  lib/sdp.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
