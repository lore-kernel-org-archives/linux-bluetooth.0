Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Feb 2015 13:26:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: fix service discovery behaviour for empty
 uuids filter
Message-ID: <20150219112608.GA7616@t440s.lan>
References: <1423848389-30900-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1423848389-30900-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Feb 13, 2015, Jakub Pawlowski wrote:
> @@ -4081,6 +4080,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
>  	 */
>  	hci_discovery_filter_clear(hdev);
>  
> +	hdev->discovery.service_scan = true;

How much have you actually tested this patch considering that it doesn't even
compile? The above should be 'service_discovery' rather than 'service_scan'.

I think there's also some mismatch of {} somewhere since I also get the
following compile errors:

net/bluetooth/mgmt.c: In function ‘mgmt_device_found’:
net/bluetooth/mgmt.c:7391:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 ^
net/bluetooth/mgmt.c:7427:13: error: invalid storage class for function ‘adv_enable_complete’
 static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
             ^
net/bluetooth/mgmt.c:7442:1: error: expected declaration or statement at end of input
 }
 ^
net/bluetooth/mgmt.c:7442:1: error: expected declaration or statement at end of input
net/bluetooth/mgmt.c:7283:7: warning: unused variable ‘match’ [-Wunused-variable]
  bool match;
       ^

Johan
