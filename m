Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 11:50:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Keith Packard <keithp@keithp.com>, stern@rowland.harvard.edu,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Regression: Revert "Bluetooth: use buffer priority to
 mark URB_ISO_ASAP flag"
Message-ID: <20120202105059.GC1643@atrey.karlin.mff.cuni.cz>
References: <1327298281-2502-1-git-send-email-keithp@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327298281-2502-1-git-send-email-keithp@keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> This reverts commit b8aabfc92249b239c425da7e4ca85b7e4855e984.
> 
> URB_ISO_ASAP may only be used with iso end points, but this patch was
> attempting to use it with a bulk endpoint. When DEBUG is defined in
> the USB stack, it checks for invalid flags and returns -EINVAL instead
> of actually transmitting the data.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>

This patch fixes a regression, and it is not in 3.3.0-rc2.

(And for the record I also believe that #ifdef debug should not
introduce extra error returns. WARN_ON() should be enough. Don't break
systems for people who try to be nice and enable debugging.)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
