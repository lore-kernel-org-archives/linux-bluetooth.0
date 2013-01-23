Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Jan 2013 02:12:09 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add support for reading LE supported
 states
Message-ID: <20130123041209.GC1632@joana>
References: <1358856121-1928-1-git-send-email-johan.hedberg@gmail.com>
 <1358856121-1928-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358856121-1928-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-01-22 14:02:01 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The LE supported states indicate the states and state combinations that
> the link layer supports. This is important information for knowing what
> operations are possible when dealing with multiple connected devices.
> This patch adds reading of the supported states to the HCI init
> sequence.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    6 ++++++
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
>  3 files changed, 27 insertions(+)

All 3 patches have been applied. Thanks.

	Gustavo
