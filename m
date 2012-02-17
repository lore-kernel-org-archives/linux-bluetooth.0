Return-Path: <cyrus@holtmann.org>
Message-ID: <1329467636.28848.127.camel@aeonflux>
Subject: Re: [PATCH 2/4] Bluetooth: mgmt: Add support for Set Link Security
 command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:33:56 +0100
In-Reply-To: <1329434578-5928-2-git-send-email-johan.hedberg@gmail.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
	 <1329434578-5928-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Set Link Security mgmt command is used to enable or disable link
> level security, also known as Security Mode 3. This is rarely enabled in
> modern systems but the command needs to be available for completeness,
> qualification purposes and those few systems that actually want to
> enable it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    3 +
>  net/bluetooth/mgmt.c             |   81 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


