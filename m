Return-Path: <cyrus@holtmann.org>
Message-ID: <1327960842.1955.182.camel@aeonflux>
Subject: Re: [PATCH 4/4] Bluetooth: Use proper datatypes in release-callbacks
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Date: Mon, 30 Jan 2012 14:00:42 -0800
In-Reply-To: <1327679246-2667-5-git-send-email-dh.herrmann@googlemail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	 <1327679246-2667-5-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This enhances code readability a lot and avoids using void* even though
> we know the type of the variable.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  net/bluetooth/hci_sysfs.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


