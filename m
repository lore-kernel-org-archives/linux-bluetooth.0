Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Feb 2010 22:55:01 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Poole <mdpoole@troilus.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid-magicmouse: Coding style and probe failure fixes.
Message-ID: <20100211065501.GD8252@core.coreip.homeip.net>
References: <87y6j2eeqv.fsf_-_@troilus.org>
 <87pr4eeemz.fsf_-_@troilus.org>
 <20100210182024.GA29610@core.coreip.homeip.net>
 <873a18e3qu.fsf_-_@troilus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <873a18e3qu.fsf_-_@troilus.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 11, 2010 at 12:32:57AM -0500, Michael Poole wrote:
> From 04b395dbbd1ad2b836188e6f125940ae8fac6925 Mon Sep 17 00:00:00 2001
> 
> As suggested by Dmitry Torokhov on 10 Feb: Use proper values
> to initialize bool configuration variables, tabs rather than
> spaces, no braces for one-line else clause, __set_bit() when
> the operation doesn't have to be atomic, input_set_abs_params()
> rather than writing the fields directly, and call hid_hw_stop()
> when appropriate to handle failures in the probe.
> 
> Signed-off-by: Michael Poole <mdpoole@troilus.org>
> ---
> Dmitry and Jiri,
> 
> I haven't had a chance to run-test these changes yet -- hid/for-next
> causes corrupt X display on my laptop, whereas v2.6.33-rc6 and -rc7 are
> fine; I'm still bisecting to figure out the cause -- but this patch is
> not complicated.  (It does compile.)
> 
> I left the buffers for hdev->hid_output_raw_report() on the stack
> because the Bluetooth HIDP code memcpy's the contents into a freshly
> allocated skb.
> 

Ah, OK, I missed the fact that itis BT only device.

The resul looks much better now, thank you for making the changes.

-- 
Dmitry
