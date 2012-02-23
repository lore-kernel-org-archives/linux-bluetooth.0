Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Feb 2012 16:54:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set DISCOVERY_STOPPED if controller resets
Message-ID: <20120223145449.GA8783@x220>
References: <1329520360-16874-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329520360-16874-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Feb 17, 2012, Andre Guedes wrote:
> If controller is reset during the discovery procedure, Start
> Discovery command stops working. This can be easily reproduced
> by running "hciconfig hci0 reset" while discovering devices,
> for instance.
> 
> We should force discovery state to DISCOVERY_STOPPED in case we
> receive a reset command complete event. Otherwise we may stuck
> in one of the active discovery states (DISCOVERY_INQUIRY,
> DISCOVERY_LE_SCAN and DISCOVERY_RESOLVING) and subsequent Start
> Discovery commands will simply fail.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied (after manual fixes to match the latest tree). Thanks.

Johan
