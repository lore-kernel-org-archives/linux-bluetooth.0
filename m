Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/5] Bluetooth: Cleanup blkcipher on SMP termination
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 12 Nov 2011 16:01:50 +0900
In-Reply-To: <1321057441-7921-5-git-send-email-bgix@codeaurora.org>
References: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
	 <1321057441-7921-5-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321081314.15441.432.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/smp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

But please get into the habit of having proper commit messages with
explanation.

I wanna be able to read the commit message and then compare that the
code does exactly what you claim it to be doing.

Regards

Marcel


