Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 15:44:03 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't force DISCOVERY_STOPPED state in
 inquiry_cache_flush
Message-ID: <20120302234403.GB31665@x220.ice.intel.com>
References: <1330636797-16171-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330636797-16171-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Mar 01, 2012, Andre Guedes wrote:
> We are not supposed to force DISCOVERY_STOPPED in inquiry_cache_flush
> because we may break the discovery state machine. For instance,
> during interleaved discovery, when we are about to start inquiry,
> the state machine forcibly goes to DISCOVERY_STOPPED while it
> should stay in DISCOVERY_FINDING state.
> 
> This problem results in unexpected behaviors such as sending two
> mgmt_discovering events to userspace (when only one event is
> expected) and Stop Discovery failures.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c |    1 -
>  1 file changed, 1 deletion(-)

The patch has been applied to my tree now. Thanks.

Johan
