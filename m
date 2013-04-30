Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 11:24:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 03/13] Bluetooth: Update start_discovery to use HCI
 request
Message-ID: <20130430082419.GE777@x220.ger.corp.intel.com>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-4-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-4-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> This patch modifies the start_discovery function so it uses the HCI
> request framework.
> 
> We build the HCI request according to the discovery type (add inquiry
> or LE scan HCI commands) and run the HCI request. We also register
> the start_discovery_complete callback which handles mgmt command
> complete events for this command. This way, we move all start_
> discovery mgmt handling code spread in hci_event.c to a single place
> in mgmt.c.
> 
> This patch also merges the LE-only and interleaved discovery type
> cases since these cases are pretty much the same now.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 9 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
