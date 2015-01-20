Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
References: <1421229458-11207-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1421229458-11207-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH  0/3] Fix memory issue and trivial code cleaup
Date: Tue, 20 Jan 2015 15:04:38 +0530
Message-id: <001201d03494$5abd3d60$1037b820$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Wednesday, January 14, 2015 3:28 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
> Babu
> Subject: [PATCH 0/3] Fix memory issue and trivial code cleaup
> 
> In gatt-client and gatt-helpers, the variables are accessed even after it
is
> freed. Making the unref at appropriate places solved the issues.
> 
> In tools, removed dead code warnings.
> 
> Gowtham Anandha Babu (3):
>   shared/gatt-helpers: Fix usage of freed memory
>   shared/gatt-client: Fix usage of freed memory
>   tools/hciattach_ath3k: Remove dead code warnings
> 
>  src/shared/gatt-client.c  | 23 +++++++++++------------  src/shared/gatt-
> helpers.c | 25 ++++++++++++++++---------
>  tools/hciattach_ath3k.c   | 11 +----------
>  3 files changed, 28 insertions(+), 31 deletions(-)
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

