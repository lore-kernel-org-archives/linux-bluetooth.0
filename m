Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Dec 2013 11:32:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] core: Fix not replying to DisconnectProfile
Message-ID: <20131210093253.GA10836@x220.p-661hnu-f1>
References: <1386664877-10137-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386664877-10137-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 10, 2013, Luiz Augusto von Dentz wrote:
> btd_service_disconnect may cause a service to disconnect before returning
> which cause dev->disconnect to be set after device_profile_disconnected.
> ---
>  src/device.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Both patches have been applied. Thanks.

Johan
