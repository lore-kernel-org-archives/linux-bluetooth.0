Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Sep 2011 15:20:44 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hidp: Add support for NO_INIT_REPORTS quirk
Message-ID: <20110902182044.GG12684@joana>
References: <1314358032-23513-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314358032-23513-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-08-26 13:27:12 +0200]:

> During setup the host initializes all HID reports. Some devices do not
> support this. If this quirk is set, we skip the initialization.
> See also usbhid_init_reports() for this quirk.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  net/bluetooth/hidp/core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied, Thanks.

	Gustavo
