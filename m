Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v4 2/3] Bluetooth: Add new debugfs parameter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395950121-12263-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 28 Mar 2014 00:12:04 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C228771B-A193-4BA5-9F72-299F536B6DFB@holtmann.org>
References: <1395950121-12263-1-git-send-email-lukasz.rymanowski@tieto.com> <1395950121-12263-2-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> With this patch it is possible to control discovery interleaved
> timeout value from debugfs.
> 
> It is for fine tuning of this timeout.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 4 ++++
> net/bluetooth/mgmt.c             | 2 +-
> 3 files changed, 6 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

