Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/2] Bluetooth: Remove incorrect check for BDADDR_BREDR address type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422000639-4918-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 23 Jan 2015 10:07:11 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2DC6CBC6-850C-460C-AC64-295D3ABD6C02@holtmann.org>
References: <1422000639-4918-1-git-send-email-johan.hedberg@gmail.com> <1422000639-4918-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Add Remote OOB Data mgmt command should allow data to be passed for
> LE as well. This patch removes a left-over check for BDADDR_BREDR that
> should not be there anymore.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 8 --------
> 1 file changed, 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

