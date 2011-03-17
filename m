Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 15:30:13 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Add define for the maximum name length on
 HCI level
Message-ID: <20110317183013.GF2214@joana>
References: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
 <1300278577-23068-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300278577-23068-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-03-16 14:29:35 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> This patch adds a clear define for the maximum device name length in HCI
> messages and thereby avoids magic numbers in the code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  include/net/bluetooth/hci.h      |    8 +++++---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_event.c        |    4 ++--
>  net/bluetooth/hci_sysfs.c        |    6 +++---
>  4 files changed, 11 insertions(+), 9 deletions(-)

This one is also applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
