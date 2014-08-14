Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2] Bluetooth: Fix ERTM L2CAP resend packet
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408001734-23910-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 14 Aug 2014 00:48:27 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <04FA0725-27F7-4EC6-80FE-49F77BFCBFA4@holtmann.org>
References: <1408001734-23910-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> I-Frame which is going to be resend already has FCS field added and set
> (if it was required). Adding additional FCS field calculated from data +
> old FCS in resend function is incorrect.
> 
> This patch fix that.
> 
> Issue has been found during PTS testing.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> net/bluetooth/l2cap_core.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

