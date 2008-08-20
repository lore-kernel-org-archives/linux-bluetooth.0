Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Aug 2008 16:03:58 +0300
From: Felipe Balbi <felipe.balbi@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
        Stefan Seyfried <seife@suse.de>, linux-bluetooth@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [rfc/rft]power management for btusb
Message-ID: <20080820130358.GR23346@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
References: <200808201142.52620.oliver@neukum.org> <200808201405.19720.oliver@neukum.org> <1219235683.7591.326.camel@violet.holtmann.net> <200808201442.08208.oliver@neukum.org> <1219237250.7591.328.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1219237250.7591.328.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 20, 2008 at 03:00:50PM +0200, ext Marcel Holtmann wrote:
> I only seem to see power/wakeup entries. I don't have power/level. Am I
> missing some configuration option?

CONFIG_USB_SUSPEND

-- 
balbi
