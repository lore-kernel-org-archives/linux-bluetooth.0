Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 11:15:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Implement cancel primary discovery session
Message-ID: <20101216091526.GA4322@jh-x301>
References: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Dec 15, 2010, Claudio Takahasi wrote:
> Extend bt_cancel_discovery function to cancel an ongoing Discover
> All Primary Services procedure.
> ---
>  src/device.c      |   11 +++----
>  src/glib-helper.c |   73 ++++++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 63 insertions(+), 21 deletions(-)

Thanks. This patch has been pushed upstream.

Johan
