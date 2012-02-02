Return-Path: <cyrus@holtmann.org>
Message-ID: <1328141557.2054.0.camel@aeonflux>
Subject: Re: [PATCH v3] Bluetooth: Fix l2cap conn failures for ssp devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 01 Feb 2012 16:12:37 -0800
In-Reply-To: <1312921615.2261.1.camel@THOR>
References: <1312921615.2261.1.camel@THOR>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> Commit 330605423c fixed l2cap conn establishment for non-ssp remote
> devices by not setting HCI_CONN_ENCRYPT_PEND every time conn security
> is tested (which was always returning failure on any subsequent
> security checks).
> 
> However, this broke l2cap conn establishment for ssp remote devices
> when an ACL link was already established at SDP-level security. This
> fix ensures that encryption must be pending whenever authentication
> is also pending.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> 
> v2: Avoids possible race condition between hci_conn_security and
> hci_conn_complete_evt
> v3: Actually compiles :)
> 
>  net/bluetooth/hci_conn.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


