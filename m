Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Apr 2011 10:49:10 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add temporary workaround to skip wrong OMTU for basic
 rate
Message-ID: <20110409174910.GD26311@jh-x301>
References: <1302197508-893-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302197508-893-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Apr 07, 2011, Claudio Takahasi wrote:
> This patch is required until MTU kernel patch is not integrated. Kernel
> is returning zero for basic rate OMTU.
> ---
>  attrib/gattrib.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream with a minor tweak to the commit message: this can't
really be considered so temporary if there are kernels out there that
return the wrong value. In that case we'll need to keep the workaround
for quite some time.

Johan
