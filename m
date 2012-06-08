Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jun 2012 04:20:44 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add support for encryption key refresh
Message-ID: <20120608072044.GF1546@joana>
References: <1339052318-11423-1-git-send-email-johan.hedberg@gmail.com>
 <1339052318-11423-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339052318-11423-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-06-07 14:58:38 +0800]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> With LE/SMP the completion of a security level elavation from medium to
> high is indicated by a HCI Encryption Key Refresh complete event. The
> necessary behavior upon receiving this event is a mix of what's done for
> auth_complete and encryption_change, which is also where most of the
> event handling code has been copied from.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |    6 ++++++
>  net/bluetooth/hci_event.c   |   48 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)

This patch look ok to me, but if we want to get it into bluetooth.git we need
a rebased version here.

	Gustavo
