Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com
References: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1435137092-19300-1-git-send-email-bharat.panda@samsung.com>
Subject: RE: [PATCH  0/3] Add Support for GetTotalNumOfItems
Date: Wed, 01 Jul 2015 10:57:27 +0530
Message-id: <002e01d0b3be$a2386f30$e6a94d90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Bharat Panda
> Sent: Wednesday, June 24, 2015 2:41 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: cpgs@samsung.com; Bharat Panda
> Subject: [PATCH 0/3] Add Support for GetTotalNumOfItems
> 
> Support added for AVRCP GetTotalNumOfItems browsing command.
> 
> It is used to retrieve the number of items in a folder prior to calling
> GetFolderItems to retrieve a listing of the contents of a folder. The
purpose
> of the command is to provide both scaling information, and total item
count
> for devices that may not be able to store or display an entire folder
content
> listing.
> 
> Bharat Panda (3):
>   audio/avrcp: Add AVRCP GetTotalNumOfItems support
>   audio/player: Add TotalNumberOfItems DBUS method
>   tools: Add total-items command for GetTotalNumOfItems
> 
>  profiles/audio/avrcp.c   | 77
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/player.c  | 53 +++++++++++++++++++++++++++++++++
> profiles/audio/player.h  |  4 +++  tools/bluetooth-player.c | 40
> +++++++++++++++++++++++++
>  4 files changed, 174 insertions(+)
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

