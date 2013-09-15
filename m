Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v3 1/8] Bluetooth: Remove unused event mask struct
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379179711-16436-2-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 14 Sep 2013 20:47:34 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <94C5EF40-1CA7-47C6-B1DC-D38CC78E6AF5@holtmann.org>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com> <1379179711-16436-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The struct for HCI_Set_Event_Mask is never used. Instead a local 8-byte
> array is used for sending this command. Therefore, remove the
> unnecessary struct definition.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h | 3 ---
> 1 file changed, 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

