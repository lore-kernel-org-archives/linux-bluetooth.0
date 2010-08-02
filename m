Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/8] Bluetooth:  Don't modify remote_tx_win when
 receiving a config response. Only config requests should set remote_tx_win.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-6-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-6-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:42:46 -0700
Message-ID: <1280778166.12579.42.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

please write a proper commit message. Your subject is not meant to be
used for explaining what is wrong and what is right and how you did it.
It is called a SUBJECT.

Regards

Marcel


