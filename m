Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:25:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 04/13] Bluetooth: Remove start discovery handling from
 hci_event.c
Message-ID: <20130430082531.GF777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> Since all mgmt start discovery command complete events are now handled
> in start_discovery_complete callback in mgmt.c, we can remove this
> handling from hci_event.c.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

However, it looks like after this patch you could have another one to
remove mgmt_start_discovery_failed from hci_core.h since it's only
needed inside mgmt.c. Or did I miss something?

Johan
