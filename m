Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Clearly distinguish mgmt LTK type from authenticated property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400840393-21232-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 23 May 2014 11:28:05 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1570363A-CFC1-484D-8661-E05AE12D1D3B@holtmann.org>
References: <1400840393-21232-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> On the mgmt level we have a key type parameter which currently accepts
> two possible values: 0x00 for unauthenticated and 0x01 for
> authenticated. However, in the internal struct smp_ltk representation we
> have an explicit "authenticated" boolean value.
> 
> To make this distinction clear, add defines for the possible mgmt values
> and do conversion to and from the internal authenticated value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/mgmt.h |  3 +++
> net/bluetooth/mgmt.c         | 19 ++++++++++++++++---
> 2 files changed, 19 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

