Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Revert "Bluetooth: btmrvl: support sysfs initiated
 firmware coredump"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1522184620-1695-1-git-send-email-arend.vanspriel@broadcom.com>
Date: Wed, 28 Mar 2018 11:37:16 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <6DE6EDF0-488F-477D-A978-A19232594961@holtmann.org>
References: <1522184620-1695-1-git-send-email-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arend,

> This reverts commit 118c193d9699ffc1c897c38a1d314f38543c8e1c. A discussion
> about the driver callback ended with the idea to change the return type of
> the callback to void. That change would lead to build error in linux-next
> so let's remove this change and resubmit later according the new callback
> definition.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> Hi Marcel,
> 
> Still noticed the patch in bt-next/master so decided to sent this formal
> revert patch.

I rebased the tree now to take this patch out. Thanks for reminding me.

Regards

Marcel

