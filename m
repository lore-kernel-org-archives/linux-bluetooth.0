Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v1] Bluetooth: fix MGMT_EV_NEW_LONG_TERM_KEY event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438809389-4230-1-git-send-email-jpawlowski@google.com>
Date: Thu, 6 Aug 2015 07:37:35 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8BB106E9-09C4-47D8-8F23-911106C9928C@holtmann.org>
References: <1438809389-4230-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch fixes how MGMT_EV_NEW_LONG_TERM_KEY event is build. Right now
> val vield is filled with only 1 byte, instead of whole value. This bug
> was introduced in
> commit 1fc62c526a57 ("Bluetooth: Fix exposing full value of shortened LTKs")
> 
> Before that patch, if you paired with device using bluetoothd using simple
> pairing, and then restarted bluetoothd, you would be able to re-connect,
> but device would fail to establish encryption and would terminate
> connection. After this patch connecting after bluetoothd restart works
> fine.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

