Return-Path: <cyrus@holtmann.org>
Message-ID: <1329467627.28848.125.camel@aeonflux>
Subject: Re: [PATCH 3/4] Bluetooth: mgmt: Implement Set SSP command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:33:47 +0100
In-Reply-To: <1329434578-5928-3-git-send-email-johan.hedberg@gmail.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
	 <1329434578-5928-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Set SSP mgmt command can be used for enabling and disabling Secure
> Simple Pairing support for controllers that support it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    6 ++-
>  net/bluetooth/mgmt.c             |   79 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


