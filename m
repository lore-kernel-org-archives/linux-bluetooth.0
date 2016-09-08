Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Fix reason code used for rejecting SCO connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1473328811-25338-1-git-send-email-frederic.dalleau@collabora.co.uk>
Date: Thu, 8 Sep 2016 16:57:21 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <50304465-7F98-4C72-95EE-71A33CA8D7CB@holtmann.org>
References: <1473328811-25338-1-git-send-email-frederic.dalleau@collabora.co.uk>
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Dalleau?=
        <frederic.dalleau@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> A comment in the code states that SCO connection should be rejected
> with the proper error value between 0xd-0xf. The code uses
> HCI_ERROR_REMOTE_LOW_RESOURCES which is 0x14.
> 
> This led to following error:
> < HCI Command: Reject Synchronous Co.. (0x01|0x002a) plen 7
>        Address: 34:51:C9:EF:02:CA (Apple, Inc.)
>        Reason: Remote Device Terminated due to Low Resources (0x14)
>> HCI Event: Command Status (0x0f) plen 4
>      Reject Synchronous Connection Request (0x01|0x002a) ncmd 1
>        Status: Invalid HCI Command Parameters (0x12)
> 
> Instead make use of HCI_ERROR_REJ_LIMITED_RESOURCES which is 0xd.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@collabora.co.uk>
> ---
> net/bluetooth/hci_request.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

