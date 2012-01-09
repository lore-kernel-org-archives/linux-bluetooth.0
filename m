Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138457.6454.158.camel@aeonflux>
Subject: Re: [PATCH 1/5] Bluetooth: Make l2cap_clear_timer return if timer
 was running or not
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Mon, 09 Jan 2012 11:47:37 -0800
In-Reply-To: <1326122391-8438-2-git-send-email-szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
	 <1326122391-8438-2-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>

so I am enforcing this now. No more empty commit message bodies!

Explain your patch and why do you need it. This is the perfect example
where you mention ahead of time why you want this.

> ---
>  include/net/bluetooth/l2cap.h |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)

Regards

Marcel


