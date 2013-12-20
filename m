Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 09:28:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] android/AVDTP: Add avdtp_add_disconnect_cb and
 avdtp_remove_disconnect_cb
Message-ID: <20131220072807.GA18981@x220.p-661hnu-f1>
References: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 19, 2013, Luiz Augusto von Dentz wrote:
> With these functions the user application can detect when the AVDTP has
> been disconnected and cleanup properly.
> ---
>  android/avdtp.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  android/avdtp.h |  6 ++++++
>  2 files changed, 64 insertions(+), 3 deletions(-)

All four patches have been applied. Thanks.

Johan
