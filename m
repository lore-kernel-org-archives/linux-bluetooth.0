Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix potential buffer overflow with Add Advertising
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457682993-18470-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 11 Mar 2016 07:30:41 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DE11794F-5F6C-480B-A410-5002A2962C9B@holtmann.org>
References: <1457682993-18470-1-git-send-email-johan.hedberg@gmail.com> <1457682993-18470-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Add Advertising command handler does the appropriate checks for
> the AD and Scan Response data, however fails to take into account the
> general length of the mgmt command itself, which could lead to
> potential buffer overflows. This patch adds the necessary check that
> the mgmt command length is consistent with the given ad and scan_rsp
> lengths.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

