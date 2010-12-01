Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] btusb: Fix log spamming due to autosuspend
From: Marcel Holtmann <marcel@holtmann.org>
To: stefan.seyfried@googlemail.com
Cc: gregkh@suse.de, linux-bluetooth@vger.kernel.org,
	Stefan Seyfried <seife+kernel@b1-systems.com>,
	Oliver Neukum <oneukum@suse.de>
In-Reply-To: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
References: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Dec 2010 11:42:20 +0100
Message-ID: <1291200140.4795.91.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> If a device is autosuspended an inability to resubmit URBs is
> to be expected. Check the error code and only log real errors.
> (Now that autosuspend is default enabled for btusb, those log
> messages were happening all the time e.g. with a BT mouse)
> 
> Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

we had a similar one some time ago, but I am fine with this one as well.
Actually this one might be a bit better since it still keeps some
errors.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


