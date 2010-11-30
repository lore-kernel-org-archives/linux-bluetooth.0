Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Nov 2010 22:51:06 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btusb: Fix log spamming due to autosuspend
Message-ID: <20101130225106.438c535b@susi>
In-Reply-To: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
References: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 30 Nov 2010 21:49:08 +0100
stefan.seyfried@googlemail.com wrote:

> From: Stefan Seyfried <seife+kernel@b1-systems.com>
> 
> If a device is autosuspended an inability to resubmit URBs is
> to be expected. Check the error code and only log real errors.
> (Now that autosuspend is default enabled for btusb, those log
> messages were happening all the time e.g. with a BT mouse)
> 
> Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

As Greg has told me, this needs to go through the bluetooth Maintainer.
Personally, with 2.6.37 having autosuspend enabled by default I think this
is pretty urgent, as it spams the log continuously when using a Bluetooth
mouse. So please forward this if deemed acceptable.

Thanks
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
