Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/8] Bluetooth:  Do endianness conversion on MPS
 configuration value before doing comparisons.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-5-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-5-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:41:46 -0700
Message-ID: <1280778106.12579.41.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)

same for subject line vs commit message. And please explain why and if
this fixes a bug.

Regards

Marcel


