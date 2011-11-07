Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 17:38:04 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Periodic Inquiry and Discovery
Message-ID: <20111107193804.GD3707@joana>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
 <1320427013-5684-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320427013-5684-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-11-04 14:16:53 -0300]:

> By using periodic inquiry command we're not able to detect correctly
> when the controller has started inquiry.
> 
> Today we have this workaround in inquiry result event handler
> to set the HCI_INQUIRY flag when it sees the first inquiry result
> event. This workaround isn't enough because the device may be
> performing an inquiry but the HCI_INQUIRY flag is not set. For
> instance, if there is no device in range, no inquiry result event
> is generated, consequently, the HCI_INQUIRY flags isn't set when
> it should so.
> 
> We rely on HCI_INQUIRY flag to implement the discovery procedure
> properly. So, as we aren't able to clear/set the HCI_INQUIRY flag
> in a reliable manner, periodic inquiry events shouldn't change
> the HCI_INQUIRY flag.
> 
> Thus, due to that issue and in order to keep compatibility with
> userspace, periodic inquiry events shouldn't send mgmt discovering
> events.
> 
> In future, we might track if periodic inquiry is enabled or not.
> By tracking this state we'll be able to do some improvements in
> Discovery such as failing MGMT_OP_START_DISCOVERY command in case
> periodic inquiry is on. We can also send no mgmt_device_found
> event if periodic inquiry is on.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |   43 +++++++++++--------------------------------
>  1 files changed, 11 insertions(+), 32 deletions(-)

The three patches were applied, thanks.

	Gustavo
