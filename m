Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 1/1] Bluetooth: Wait active mode to establish SCO channel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447759633-4344-1-git-send-email-chanyeol.park@samsung.com>
Date: Tue, 17 Nov 2015 12:36:36 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <51CA31C1-0F5B-4EF4-BE52-A16BFD34EA94@holtmann.org>
References: <1447759633-4344-1-git-send-email-chanyeol.park@samsung.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> Some of headset such as Samsung HS7000 randomly takes long time to
> exit Sniff Mode. So SCO connection request might be failed
> due to "Command Disallowed" and user space gets "EBUSY".
> 
> But it's not easy that user space expects when the connection
> becomes active mode. So if kernel call hci_sco_setup() by
> HCI_CONN_SCO_SETUP_PEND flag, overall SCO connection time could be
> reduced compared to user space's retrial way.
> 
> 2015-11-17 15:21:31.131227 > ACL data: handle 11 flags 0x02 dlen 19
>    L2CAP(d): cid 0x0040 len 15 [psm 0]
>      0000: 6b ff 15 03 41 54 2b 42  56 52 41 3d 31 0d f8     k...AT+BVRA=1..
> 2015-11-17 15:21:31.132436 < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
>    handle 11
> 2015-11-17 15:21:31.182614 < ACL data: handle 11 flags 0x00 dlen 14
>    L2CAP(d): cid 0x0043 len 10 [psm 0]
>      0000: 69 ef 0d 0d 0a 4f 4b 0d  0a 3e                    i....OK..>
> 2015-11-17 15:21:31.184210 > HCI Event: Command Status (0x0f) plen 4
>    Exit Sniff Mode (0x02|0x0004) status 0x0c ncmd 1
>    Error: Command Disallowed
> 2015-11-17 15:21:31.491043 < ACL data: handle 11 flags 0x00 dlen 20
>    L2CAP(d): cid 0x0043 len 16 [psm 0]
>      0000: 69 ef 19 0d 0a 2b 42 56  52 41 3a 20 31 0d 0a 3e  i....+BVRA: 1..>
> 2015-11-17 15:21:31.491502 < HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2
>    handle 11
> 2015-11-17 15:21:31.492683 > HCI Event: Command Status (0x0f) plen 4
>    Exit Sniff Mode (0x02|0x0004) status 0x0c ncmd 1
>    Error: Command Disallowed
> 2015-11-17 15:21:31.605469 < HCI Command: Write Voice Setting (0x03|0x0026) plen 2
>    voice setting 0x0060

this is not standard kernel. We never executed the write voice setting command. Where is this coming from.

With that in mind, I think it is more important to understand why the exit sniff mode command is not allowed at this point. That is a specific error code. So getting the accompanying LMP trace for this would be important.

Regards

Marcel

