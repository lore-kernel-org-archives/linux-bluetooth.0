Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3] Bluetooth: Fix response on confirm_name
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393516048-10507-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 27 Feb 2014 08:42:50 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <35F30107-DA84-4EB9-8776-BD3BA68379A8@holtmann.org>
References: <1393516048-10507-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> According to mgmt-api.txt, in case of confirm name command,
> cmd_complete should be always use as a response. Not command status
> as it is now for failures.
> Using command complete on failure is actually better as client might
> be interested in device address for which confirm name failed.
> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> net/bluetooth/mgmt.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

