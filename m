Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add HCIUARTSETFLAGS and HCIUARTGETFLAGS
 ioctls
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <1278945424-11047-1-git-send-email-johan.hedberg@gmail.com>
References: <1278945424-11047-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jul 2010 11:49:30 -0300
Message-ID: <1278946170.10421.196.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch introduces two new ioctls: HCIUARTSETFLAGS and
> HCIUARTGETFLAGS. The only flag available for now is HCI_UART_RAW_DEVICE
> which allows to initialize a UART device into RAW mode from userspace.
> This is particularly useful for experimenting with Bluetooth controllers
> that don't yet have proper support in BlueZ.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>

patch has been applied. Thanks.

Regards

Marcel


