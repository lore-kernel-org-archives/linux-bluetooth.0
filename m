Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/8] Bluetooth:  L2CAP updates for PSM validation and
 ERTM.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:50:49 -0700
Message-ID: <1280778649.12579.50.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> This is a collection of ERTM-related patches, including some L2CAP 
> configuration fixes and allowing partial-frame reads from L2CAP
> SOCK_STREAM sockets.  PSM validation is also included, although that
> is not restricted to ERTM.

so the merge window for 2.6.36 is basically closed and these patches
came in too late. If they fix a bug, I like you to explain that in
detail in the commit message so I can pick them out and include them for
submission to John.

Regards

Marcel


