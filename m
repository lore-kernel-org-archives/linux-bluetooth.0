Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 20:46:12 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@linux.intel.com>,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: Re: [PATCH] bluetooth: btmrvl: use native helpers
Message-ID: <20130423234612.GE1697@joana>
References: <1366710826-9779-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366710826-9779-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [2013-04-23 12:53:46 +0300]:

> Clean up the code by using native debugfs helpers:
> 	debugfs_create_u8()
> 	debugfs_create_x16()
> 	debugfs_remove_recursive()
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/bluetooth/btmrvl_debugfs.c | 266 +++----------------------------------
>  1 file changed, 22 insertions(+), 244 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
