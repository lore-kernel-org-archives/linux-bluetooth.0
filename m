Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH] Bluetooth: fix autoconnect for pending connect attempt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444258766-26899-1-git-send-email-jpawlowski@google.com>
Date: Thu, 8 Oct 2015 01:09:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <425A0962-867A-449A-9219-CCE71D64BB95@holtmann.org>
References: <1444258766-26899-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> When adding device to auto connect whitelist when there is pending
> connect attempt, there is no need to update scan, or to add it to
> pend_le_conns list.
> 
> When trying to connect to le device, it is added to pend_le_conns and
> background scan is updated. There's no need to repeat this operation when
> adding device to auto connect list. Only update of params->auto_connect
> value is required.
> 
> If both operations try to update background scan, and are quickly queued
> together when scan was disabled, second operation might improperly try to
> start, instead of restarting scan. This means that adding device to
> connect whitelist would report failure, even though it succeeded.
> 
> In order to reproduce this bug type in bluetoothctl:
> connect D9:00:00:00:00
> disconnect D9:00:00:00:00
> connect D9:00:00:00:00
> 
> and observe bluetoothd logs (error happens during second connect attempt):
> src/device.c:device_connect_le() Connection attempt to: D0:5F:B8:52:22:9F
> Failed to add device D0:5F:B8:52:22:9F (1): Busy (0x0a)
> ---
> net/bluetooth/mgmt.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ccaf5a4..1108281 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6122,7 +6122,12 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
> 		break;
> 	case HCI_AUTO_CONN_DIRECT:
> 	case HCI_AUTO_CONN_ALWAYS:
> -		if (!is_connected(hdev, addr, addr_type)) {
> +		/* If we are connected, don't add to whitelist. If we are
> +		 * connecting, we're already added to pend_le_conns and
> +		 * scanning.
> +		 */
> +		if (!is_connected(hdev, addr, addr_type) &&
> +		    !params->auto_connect == HCI_AUTO_CONN_EXPLICIT) {

we are not doing it like this. I think you are looking for != here.

Regards

Marcel

