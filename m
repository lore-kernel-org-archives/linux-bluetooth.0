Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/2] Bluetooth: Default to no security with L2CAP RAW sockets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389025622-13891-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 6 Jan 2014 09:28:20 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <87D02424-7FE7-4425-9029-109DECCDCCC5@holtmann.org>
References: <1389025622-13891-1-git-send-email-johan.hedberg@gmail.com> <1389025622-13891-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> L2CAP RAW sockets can be used for things which do not involve
> establishing actual connection oriented L2CAP channels. One example of
> such usage is the l2ping tool. The default security level for L2CAP
> sockets is LOW, which implies that for SSP based connection
> authentication is still requested (although with no MITM requirement),
> which is not what we want (or need) for things like l2ping. Therefore,
> default to one lower level, i.e. BT_SECURITY_SDP, for L2CAP RAW sockets
> in order not to trigger unwanted authentication requests.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

