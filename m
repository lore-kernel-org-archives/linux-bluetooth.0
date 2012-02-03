Return-Path: <cyrus@holtmann.org>
Message-ID: <1328290855.2062.47.camel@aeonflux>
Subject: Re: [PATCH v4 5/6] Bluetooth: MGMT start discovery LE-Only support
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 09:40:55 -0800
In-Reply-To: <1328135692-24255-6-git-send-email-andre.guedes@openbossa.org>
References: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
	 <1328135692-24255-6-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds LE-Only discovery procedure support to MGMT Start
> Discovery command.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |   13 ++++++++++++-
>  net/bluetooth/mgmt.c      |   20 +++++++++++++++++++-
>  2 files changed, 31 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


