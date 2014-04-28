Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/2] android/gatt: Refactor client connection handling
Date: Mon, 28 Apr 2014 13:44:24 +0200
Message-ID: <1426197.5BVOPJXRyG@uw000953>
In-Reply-To: <1398611091-4048-2-git-send-email-jakub.tyszkowski@tieto.com>
References: <1398611091-4048-1-git-send-email-jakub.tyszkowski@tieto.com> <1398611091-4048-2-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Sunday 27 of April 2014 17:04:50 Jakub Tyszkowski wrote:
> Multiple, connection specific device lists were replaced with one,
> while devices store their connection state instead. Client list in each
> device were replaced with single, global list, storing (connection_id,
> client*, device*) tuples. This seams to be more natural and easier to
> perform actions which are mostly triggered by specific clients on
> specific device or connection.
> 
> Connection id previously assigned to device now properly identifies
> client<->device and not the physical adapter<->device connection.
> ---
>  android/gatt.c | 1004 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 536 insertions(+), 468 deletions(-)

This patch is now upstream (with small changes we discussed offline). Thanks.

-- 
Best regards, 
Szymon Janc
