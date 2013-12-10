Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v7 1/5] 6lowpan: Moving generic compression code into 6lowpan_iphc.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386675457-26024-2-git-send-email-jukka.rissanen@linux.intel.com>
Date: Tue, 10 Dec 2013 13:08:49 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <13069B4D-C476-4B0A-96ED-7078B2577233@holtmann.org>
References: <1386675457-26024-1-git-send-email-jukka.rissanen@linux.intel.com> <1386675457-26024-2-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Because the IEEE 802154 and Bluetooth share the IP header compression
> and uncompression code, the common code is moved to 6lowpan_iphc.c
> file.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/ieee802154/6lowpan.c      | 753 ++-------------------------------------
> net/ieee802154/6lowpan.h      |  32 ++
> net/ieee802154/6lowpan_iphc.c | 807 ++++++++++++++++++++++++++++++++++++++++++
> net/ieee802154/Makefile       |   2 +-
> 4 files changed, 875 insertions(+), 719 deletions(-)
> create mode 100644 net/ieee802154/6lowpan_iphc.c

what are we doing with this patch. Are we taking this through the bluetooth-next tree as well?

Regards

Marcel

