Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Nov 2013 14:26:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/7] android/hal-a2dp: Use conn_state instead of
 connection_state
Message-ID: <20131114122625.GA22596@x220.p-661hnu-f1>
References: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 14, 2013, Luiz Augusto von Dentz wrote:
> This is shorter and more consistent with other HAL such as HID.
> ---
>  android/hal-a2dp.c | 8 ++++----
>  android/hal-msg.h  | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

Applied with the couple of tweaks that we discussed offline. Thanks.

Johan
