Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jul 2011 10:43:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 12/12] Address remote initiated disconnection
Message-ID: <20110727074341.GB24540@dell>
References: <1309987464-10255-1-git-send-email-claudio.takahasi@openbossa.org>
 <1311193513-19720-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311193513-19720-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Jul 20, 2011, Claudio Takahasi wrote:
> Local initiated disconnection will be triggered when the last GAttrib
> reference is dropped. For remote initiated disconnection it is necessary
> to track the socket HUP registering disconnection GAttrib callback.
> ---
>  src/device.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

These last three patches in this set have now also been pushed upstream.

Johan
