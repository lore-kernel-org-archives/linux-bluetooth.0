Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:34:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 07/13] Bluetooth: Update stop_discovery to use HCI
 request
Message-ID: <20130430083456.GI777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-8-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-8-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> This patch modifies the stop_discovery function so it uses the HCI
> request framework.
> 
> The HCI request is built according to the current discovery state
> (inquiry, LE scanning or name resolving) and a complete callback is
> register to handle the command complete event for the stop discovery
> command. This way, we move all stop_discovery mgmt handling code
> spread in hci_event.c to a single place in mgmt.c.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 7 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
