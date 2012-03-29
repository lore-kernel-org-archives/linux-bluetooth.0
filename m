Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 23:28:39 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Keith Packard <keithp@keithp.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: Re: [PATCH] Revert "Bluetooth: Always enable management interface"
Message-ID: <20120329022839.GA26111@joana>
References: <1332983958-2734-1-git-send-email-keithp@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332983958-2734-1-git-send-email-keithp@keithp.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

* Keith Packard <keithp@keithp.com> [2012-03-28 18:19:18 -0700]:

> This reverts commit 4b95a24ce12c4545fd7d2e3075841dc3119d1d71.
> 
> My USB bluetooth device does not show up with this patch in place.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
> 
> This patch seems so innocuous, but when added to the kernel, it keeps
> my USB bluetooth device from appearing to user mode at all. With the
> mgmt interface enabled:

It is because it changes the way the userspace <-> kernel interface. We added a
new interface and that flag was preventing the code to use it by default, but
now that we finished to implement the new interface it will be enabled by default.

A consequence is that you'll need to use newer version of bluez, at least 4.99.
Or call the bluetooth daemon (from a pre 4.99 version) with a parameter to
disable the new interface:

$ bluetoothd -P mgmtops

Then your bluetooth will be back.

	Gustavo
