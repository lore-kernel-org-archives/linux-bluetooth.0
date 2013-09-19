Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Sep 2013 10:22:35 -0500
From: Gustavo Padovan <gustavo@padovan.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add event mask page 2 setting support
Message-ID: <20130919152235.GF4006@joana>
References: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com>
 <1379061602-8290-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379061602-8290-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2013-09-13 johan.hedberg@gmail.com <johan.hedberg@gmail.com>:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> For those controller that support the HCI_Set_Event_Mask_Page_2 command
> we should include it in the init sequence. This patch implements sending
> of the command and enables the events in it based on supported features
> (currently only CSB is checked).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |  2 ++
>  net/bluetooth/hci_core.c    | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
