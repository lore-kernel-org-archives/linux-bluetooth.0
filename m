Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 0/2] Bluetooth: hci_bcm: Add wake-up and PM runtime support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440772279-9015-1-git-send-email-frederic.danis@linux.intel.com>
Date: Sun, 30 Aug 2015 14:07:53 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C990BE69-A134-47F9-9468-71AB9240987D@holtmann.org>
References: <1440772279-9015-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add wake-up capabilities by retrieveing interruption used by BCM device in ACPI
> table.
> 
> Replace spinlock by mutex to be able to use pm_runtime_...() functions.

if we can replace the spinlock with a mutex, then please send a patch that does just that first. I makes it a lot easier to review the whole series.

Regards

Marcel

