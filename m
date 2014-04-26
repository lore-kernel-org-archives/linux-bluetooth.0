Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/4] gatt: Add new characteristic functionality
Date: Sat, 26 Apr 2014 18:16:30 +0200
Message-ID: <1954668.vWOP6SXplt@leonov>
In-Reply-To: <1398428924-6304-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398428924-6304-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 25 of April 2014 14:28:41 Marcin Kraglak wrote:
> It will attach characteristic declaration and value, and return value
> handle. It is needed to pass service handle to which this characteristic
> will be added. If there is not enough free handles in service, 0 will be
> returned.
> ---
>  src/shared/gatt-db.c | 101
> +++++++++++++++++++++++++++++++++++++++++++++++++++ src/shared/gatt-db.h | 
> 15 ++++++++
>  2 files changed, 116 insertions(+)

All patches applied, thanks.

Yet, I had to fix some quite severe bugs. Also some other changes (including 
API) we discussed with Łukasz are present. Please make sure to rebase before
sending further patches.

-- 
BR
Szymon Janc
