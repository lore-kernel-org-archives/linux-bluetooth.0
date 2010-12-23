Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 21:09:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix spurious DeviceDisappeared signals after name
 resolution
Message-ID: <20101223190941.GA26887@jh-x301>
References: <1293125965-11782-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293125965-11782-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Dec 23, 2010, Anderson Lizardo wrote:
> update_oor_devices() was being called twice, first after a inquiry, then
> after name resolution. This caused the just found devices to be always
> reported as "disappeared" after name resolution.
> ---
>  src/adapter.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Thanks. Pushed upstream.

Johan
