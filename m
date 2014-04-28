Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/7] android/gatt: Further connection handling refactor
Date: Mon, 28 Apr 2014 18:01:55 +0200
Message-ID: <2084723.AkAhCBvf1U@uw000953>
In-Reply-To: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398691926-1777-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Monday 28 of April 2014 15:31:59 Jakub Tyszkowski wrote:
> This patch set unifies how client and server connections are handled.
> 
> Last patch adds the actual server connection handling, which mostly use common
> code.
> 
> Jakub Tyszkowski (7):
>   android/gatt: Use common struct for client and server applications
>   android/gatt: Store client and server apps on a single list
>   android/gatt: Rename connection list
>   android/gatt: Rename connection struct
>   android/gatt: Fix some whitespace issues
>   ndroid/gatt: Extract common code from client_connect
>   android/gatt: Handle Server apps connections
> 
>  android/gatt.c | 488 +++++++++++++++++++++++++++++----------------------------
>  1 file changed, 248 insertions(+), 240 deletions(-)

All patches applied. Thanks.
(3 and 5 where squashed, also some other minor changes we discussed are present)


-- 
Best regards, 
Szymon Janc
