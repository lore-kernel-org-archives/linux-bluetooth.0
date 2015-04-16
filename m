Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com
References: <1429018163-6124-1-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1429018163-6124-1-git-send-email-bharat.panda@samsung.com>
Subject: RE: [PATCH ] monitor: Add AVRCP GetFolderItems Support
Date: Thu, 16 Apr 2015 19:18:57 +0530
Message-id: <020c01d0784c$2949e2a0$7bdda7e0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Bharat Panda [mailto:bharat.panda@samsung.com]
> Sent: Tuesday, April 14, 2015 6:59 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: cpgs@samsung.com; Bharat Panda
> Subject: [PATCH ] monitor: Add AVRCP GetFolderItems Support
> 
> Support for decoding AVRCP GetFolderItems added in btmon.
> 
>       Channel: 65 len 20 ctrl 0x0000 [PSM 27 mode 3] {chan 1}
>       I-frame: Unsegmented TxSeq 0 ReqSeq 0
>       AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
>         AVRCP: GetFolderItems: len 0x000a
>           Scope: 0x01 (Media Player Virtual Filesystem)
>           StartItem: 0x00000000 (0)
>           EndItem: 0x0000000a (10)
>           AttributeCount: 0xff (255)
>           AttributeID: 0x0000326e (Reserved)
> ---
>  monitor/avctp.c | 113
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 2 deletions(-)
> 

Please ignore this patch, as a new patch set has been sent with few fixes
and enhancements.

Thanks
Best Regards,
Bharat



