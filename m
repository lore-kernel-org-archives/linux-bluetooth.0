Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 1/4] Bluetooth: Rename hci_conn variable in hci_connect_le()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380835547-3640-2-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 4 Oct 2013 08:08:48 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <01A7124C-8B1F-4525-9316-ABF2849964C5@holtmann.org>
References: <1380835547-3640-1-git-send-email-andre.guedes@openbossa.org> <1380835547-3640-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch simply rename the hci_conn variable "le" to "conn"
> since it is a better name.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 26 +++++++++++++-------------
> 1 file changed, 13 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

