Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Mar 2011 10:49:19 -0500
From: Greg KH <greg@kroah.com>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [2.6.38-rc6, patch] fix hci_dev_list locking...
Message-ID: <20110301154919.GB27312@kroah.com>
References: <AANLkTi=_gAQiAqKsYa2=Haq0ceJwK3n7OafDk6Lb7MZE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=_gAQiAqKsYa2=Haq0ceJwK3n7OafDk6Lb7MZE@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 01, 2011 at 11:41:38PM +0800, Daniel J Blueman wrote:
> Release acquired lock on error path, fixing potential hang up.
> 
> Signed-off-by: Daniel J Blueman <daniel.blueman@gmail.com>
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index f827fd9..ace8726 100644

Please go read Documentation/stable_kernel_rules.txt for how to properly
submit patches to the stable kernel tree (hint, this way was not
correct...)

thanks,

greg k-h
