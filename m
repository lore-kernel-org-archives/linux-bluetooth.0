Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jan 2013 16:31:44 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 8/8] Bluetooth: Fix sending incorrect new_settings for
 mgmt_set_powered
Message-ID: <20130110183144.GB7700@joana>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
 <1357738180-4128-9-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357738180-4128-9-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-09 15:29:40 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The socket from which a mgmt_set_powered command was received should
> only receive the command response but no new_settings event.
> 
> The mgmt_powered() function which is used to handle the situation with
> the HCI_AUTO_OFF flag tries to check for a pending command to know which
> socket to skip the event for, but since the pending command hasn't been
> added this will not happen.
> 
> This patch fixes the issue by adding the pending command for the
> HCI_AUTO_OFF case and thereby ensures that mgmt_powered() will skip the
> right socket when sending the new_settings event, but still send the
> proper response to the socket where the command came from.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch has been applied, thanks.

	Gustavo
