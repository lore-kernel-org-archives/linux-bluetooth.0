Return-Path: <cyrus@holtmann.org>
Message-ID: <1326967469.1955.6.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: Merge boolean members of struct hci_conn
 into flags
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Jan 2012 11:04:29 +0100
In-Reply-To: <1326966173-20105-2-git-send-email-johan.hedberg@gmail.com>
References: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
	 <1326966173-20105-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that the flags member of struct hci_conn is supposed to accommodate
> any boolean type values we can easily merge all boolean members into it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    6 +++---
>  net/bluetooth/hci_conn.c         |   15 +++++++++------
>  net/bluetooth/hci_event.c        |   21 +++++++++++++--------
>  3 files changed, 25 insertions(+), 17 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


