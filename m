Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Gowtham Anandha Babu' <gowtham.ab@samsung.com>,
	linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
References: <1414764241-2459-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1414764241-2459-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH 0/6] Add support for RFCOMM in btmon
Date: Fri, 31 Oct 2014 19:44:18 +0530
Message-id: <00a501cff515$0d93ebb0$28bbc310$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Friday, October 31, 2014 7:34 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
> cpgs@samsung.com; Gowtham Anandha Babu
> Subject: [PATCH 0/6] Add support for RFCOMM in btmon
> 
> Adds an initial implementation for RFCOMM in Bluetooth monitor.
> 
> Implementation for Decoding MSC, RPN, RLS, PN, NSC frames will  be covered
> in the next patch-set.
> 
> Bharat Panda (2):
>   monitor/rfcomm: Add handlers for mcc frame type
>   monitor/rfcomm: Add mcc type handlers code
> 
> Gowtham Anandha Babu (4):
>   monitor/rfcomm: Add RFCOMM support to btmon
>   monitor/rfcomm: Add support for RFCOMM commands
>   monitor/rfcomm: Add support for UIH frame decoding
>   monitor/rfcomm: Add support for mcc frame decoding
> 
>  Makefile.tools   |   1 +
>  monitor/l2cap.c  |   4 +
>  monitor/l2cap.h  |   1 +
>  monitor/rfcomm.c | 333
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 339 insertions(+)
>  create mode 100644 monitor/rfcomm.c
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

Please note that android/Android.mk needs to be updated if we change
anything on the build of btmon.

Regards,
Vikram

