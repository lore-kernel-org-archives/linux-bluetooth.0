Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Sep 2013 18:42:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 8/8] Bluetooth: Add new mgmt_set_advertising command
Message-ID: <20130924154250.GA16073@x220.p-661hnu-f1>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
 <1380031363-1266-9-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380031363-1266-9-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 24, 2013, johan.hedberg@gmail.com wrote:
> This patch adds a new mgmt command for enabling and disabling
> LE advertising.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |  2 +
>  net/bluetooth/mgmt.c         | 99 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 100 insertions(+), 1 deletion(-)

Apologies for this really short commit message. I was going to fill this
in before sending but seems I forgot. I'll fix this for the next
revision but I'll first wait at least for some feedback before that.

Johan
