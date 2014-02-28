Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix disconnecting connections in non-connected states
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393504512-21877-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 27 Feb 2014 23:35:20 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9EAE320F-F2C8-4377-B9E0-13AABD1A08FD@holtmann.org>
References: <1393504512-21877-1-git-send-email-johan.hedberg@gmail.com> <1393504512-21877-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When powering off and disconnecting devices we should also consider
> connections which have not yet reached the BT_CONNECTED state. They may
> not have a valid handle yet and simply sending a HCI_Disconnect will not
> work.
> 
> This patch updates the code to either disconnect, cancel connection
> creation or reject incoming connection creation based on the current
> conn->state value as well as the link type in question.
> 
> When the power off procedure results in canceling connection attempts
> instead of disconnecting connections we get a connection failed event
> instead of a disconnection event. Therefore, we also need to have extra
> code in the mgmt_connect_failed function to check if we should proceed
> with the power off or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 44 ++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 40 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

