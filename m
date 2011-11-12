Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/5] Bluetooth: Add support for MITM LE-SMP pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 Nov 2011 08:12:29 +0900
In-Reply-To: <1321057441-7921-6-git-send-email-bgix@codeaurora.org>
References: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
	 <1321057441-7921-6-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321139552.15441.436.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> Passkey entry and comparison only. Uses MGMT interface to request
> passkey and confirmation from user space.

can you please split this patch into smaller chunks. It looks like some
of them are just small bug fixes for error handling.

And I see a lot of code duplication here as well. I prefer we introduce
proper helpers for certain common patterns.

Regards

Marcel



