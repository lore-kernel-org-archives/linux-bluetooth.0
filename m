Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 0/2] Bluetooth: Make LE advertising interval configurable via debugfs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406375998-15288-1-git-send-email-georg@op-co.de>
Date: Sat, 26 Jul 2014 19:16:35 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <408E894F-908F-4E0C-B903-3BDB988982D2@holtmann.org>
References: <1406375998-15288-1-git-send-email-georg@op-co.de>
To: Georg Lukas <georg@op-co.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Georg,

> These patches move the default values for the LE advertising interval
> (minimum and maximum) into the controller defaults (where other LE
> parameters like the channel map and scan intervals already exist) and
> expose them via debugfs.
> 
> While the initial configuration of the LE advertising parameters is
> performed via btmgmt, the kernel resets the parameters whenever a BLE
> connection is closed. These patches allow a developer to tune the
> parameters for debugging timing issues in the central implementation
> communicating with the Linux device.

both patches have been applied to bluetooth-next tree.

Regards

Marcel

