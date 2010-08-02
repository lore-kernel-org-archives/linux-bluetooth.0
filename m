Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/8] Bluetooth:  Change default ERTM retransmit timeout
 to 2 seconds, as the spec requires.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-3-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:40:58 -0700
Message-ID: <1280778058.12579.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

I do expect some more details commit messages. The subject line is
suppose to around 50 chars and give an idea what the patch is about. The
actual commit message should have the full blown explanation why etc.

Regards

Marcel


