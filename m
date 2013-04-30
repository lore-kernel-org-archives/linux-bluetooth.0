Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:36:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 08/13] Bluetooth: Remove stop discovery handling from
 hci_event.c
Message-ID: <20130430083621.GJ777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-9-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-9-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> Since all mgmt stop discovery command complete events are now handled
> in stop_discovery_complete callback in mgmt.c, we can remove this
> handling from hci_event.c.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

However, looks like you're missing a patch to remove
mgmt_stop_discovery_failed() from hci_core.h (since it seems it's now
only needed inside mgmt.c).

Johan
