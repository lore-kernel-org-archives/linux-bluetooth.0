Return-Path: <cyrus@holtmann.org>
Message-ID: <1326967432.1955.5.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: Add a convenience function to check for
 SSP enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Jan 2012 11:03:52 +0100
In-Reply-To: <1326966173-20105-4-git-send-email-johan.hedberg@gmail.com>
References: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
	 <1326966173-20105-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's a very common test to see if both the local and the remote device
> have SSP enabled. By creating a simple function to test this we can
> shorten many if-statements in the code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    7 +++++++
>  net/bluetooth/hci_conn.c         |    8 ++------
>  net/bluetooth/hci_event.c        |   12 ++++--------
>  3 files changed, 13 insertions(+), 14 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


