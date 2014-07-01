Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC v3 1/4] Bluetooth: Connection Parameter Update Procedure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 1 Jul 2014 23:35:49 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F8B83648-F87F-4406-AAB6-2F43F3892D04@holtmann.org>
References: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds support for LE Connection Parameters Request Link
> Layer control procedure introduced in Core spec 4.1. This procedure
> allows a Peripheral or Central to update the Link Layer connection
> parameters of an established connection.
> 
> Regarding the acceptance of connection parameters, the LL procedure
> follows the same approach of L2CAP procedure (see l2cap_conn_param_
> update_req function). We accept any connection parameters values as
> long as they are within the valid range.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci.h | 28 +++++++++++++++++++++++++
> net/bluetooth/hci_event.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 78 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

