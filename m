Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 2/4] Bluetooth: Initialize hci_conn fields in hci_connect_le
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380835547-3640-3-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 4 Oct 2013 08:09:15 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <61EED6D5-290A-422D-B92F-E8B4A58DD75E@holtmann.org>
References: <1380835547-3640-1-git-send-email-andre.guedes@openbossa.org> <1380835547-3640-3-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch moves some hci_conn fields initialization from hci_le_
> create_connection() to hci_connect_le(). It makes more sense to
> initialize these fields within the function that creates the hci_
> conn object.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

