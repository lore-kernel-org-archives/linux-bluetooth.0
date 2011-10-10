Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Oct 2011 12:35:18 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Martin Xu <martin.xu@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add Unknow after LEMeta Event
Message-ID: <20111010093518.GA25204@fusion.localdomain>
References: <1318238517-4702-1-git-send-email-martin.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318238517-4702-1-git-send-email-martin.xu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Mon, Oct 10, 2011, Martin Xu wrote:
> According to Core_v4.0
> LE Meta Event Event Code is 0x3E, While Physical Link Complete Event Code is 0x40
> So add Unknow after LEMeta Event
> ---
>  parser/hci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Thanks. Applied after I cleaned up your commit message a little.

Johan
