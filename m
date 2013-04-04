Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 21:16:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: yegorslists@googlemail.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] hciattach: fix firmware path
Message-ID: <20130404181616.GA10386@x220.ger.corp.intel.com>
References: <1364395749-20156-1-git-send-email-yegorslists@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364395749-20156-1-git-send-email-yegorslists@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yegor,

On Wed, Mar 27, 2013, yegorslists@googlemail.com wrote:
> Change firmware path to /lib/firmware/ti-connectivity/ to be
> conform with linux-firmware folder structure. All wl1xxx firmware
> resides in ti-connectivity. See linux-firmware repository
> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
> for reference.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  tools/hciattach_ti.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied (after removing the signed-off-by line which we don't use).
Thanks.

Johan
