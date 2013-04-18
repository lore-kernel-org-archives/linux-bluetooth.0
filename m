Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Apr 2013 00:27:22 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add reading of all local feature pages
Message-ID: <20130418032722.GB22245@joana>
References: <1366200052-13196-1-git-send-email-johan.hedberg@gmail.com>
 <1366200052-13196-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366200052-13196-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-04-17 15:00:52 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> With the introduction of CSA4 there is now also a features page number 2
> available. This patch increments the maximum supported page number to 2
> and adds code for reading all available pages (as long as we have
> support for them - indicated by HCI_MAX_PAGES).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    3 ++-
>  net/bluetooth/hci_core.c         |   10 ++++++++++
>  net/bluetooth/hci_event.c        |    2 ++
>  3 files changed, 14 insertions(+), 1 deletion(-)

Both patches have been applied to bluetooth-next. Thanks.

	Gustavo
