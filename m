Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 15:17:52 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix strict aliasing issue
Message-ID: <20110323131752.GD7124@jh-x301>
References: <1300882277-24960-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300882277-24960-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Mar 23, 2011, Rafal Michalski wrote:
> This patch changes type of "pending" flag to uint32_t type.
> Pointer to this flag is passed to hci_clear_bit function as void * and
> then casted to uint32_t * again. Previously unsigned long type made some
> unexpected performance which occured after violating strict aliasing
> rule. This patch fixes this problem and this solution is much easier than
> solution of changing types of many object (from uint32_t to unsigned long,
> including changing type for castng in hci_*_bit function family), which
> is overcomplicated. Also, not all objects can be changed, like
> hci_dev_info struct, since it is violating compatibility rules between
> kernel and user spaces.
> ---
>  plugins/hciops.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks. The patch has been pushed upstream after I did some heavy
cleanup on the commit message for it to be more readable :)

Johan
