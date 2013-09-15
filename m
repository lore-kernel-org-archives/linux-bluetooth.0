Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v3 6/8] Bluetooth: Fix sending responses to identified L2CAP response packets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379179711-16436-7-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 14 Sep 2013 20:54:01 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <88AF7463-5CC0-4C65-BCCA-C7CC542FFCC7@holtmann.org>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com> <1379179711-16436-7-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When L2CAP packets return a non-zero error and the value is passed
> onwards by l2cap_bredr_sig_cmd this will trigger a command reject packet
> to be sent. However, the core specification (page 1416 in core 4.0) says
> the following: "Command Reject packets should not be sent in response to
> an identified Response packet.".
> 
> This patch ensures that a command reject packet is not sent for any
> identified response packet by ignoring the error return value from the
> response handler functions.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

