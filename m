Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 0/4] Bluetooth: hci_bcm: Add ACPI and PM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 7 Aug 2015 09:45:28 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A785406E-6D37-404C-B535-2CAD31496F0E@holtmann.org>
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> These patches move PM support from rfkill-gpio to hci_uart module.
> On, off, suspend and resume functions are supported.
> They also parse the ACPI entry to find initial UART baud rate.
> 
> v1->v2:
> - Add BCM2E67 device in acpi_device_id table
> - Add suspend/resume functions

looks pretty good. My only concern is the race between bcm_data and bcm_device. Is that a valid concern from my side or can that never happen? Meaning do we need to protect against removal / unbinding of the platform device while the line discipline is active.

Regards

Marcel

