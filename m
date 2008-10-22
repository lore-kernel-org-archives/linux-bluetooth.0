Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Oct 2008 15:03:08 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Jiri Slaby <jirislaby@gmail.com>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
    Steven Noonan <steven@uplinklabs.net>,
    Justin Mattock <justinmattock@gmail.com>, Sven Anders <anders@anduras.de>,
    Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] HID: fix appletouch regression
In-Reply-To: <1224624363-16471-2-git-send-email-jirislaby@gmail.com>
Message-ID: <alpine.LNX.1.10.0810221502440.27479@jikos.suse.cz>
References: <1224624363-16471-1-git-send-email-jirislaby@gmail.com> <1224624363-16471-2-git-send-email-jirislaby@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 21 Oct 2008, Jiri Slaby wrote:

> The appletouch mouse devices are grabbed by the hid bus and not
> released even if apple driver says ENODEV (as expected).
> Move the ignoration one level upper to deny the hid layer to grab
> the device and return error to the usb hid which, as a result,
> releases the device.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
