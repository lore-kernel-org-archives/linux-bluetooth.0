Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 May 2012 16:51:46 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: mgmt: Fix device_connected sending order
Message-ID: <20120504195145.GB11510@joana>
References: <1336127870-5930-1-git-send-email-johan.hedberg@gmail.com>
 <1336128329-6650-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336128329-6650-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-05-04 13:45:29 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The mgmt_ev_device_connected signal must be sent before any event
> indications happen for sockets associated with the connection. Otherwise
> e.g. device authorization for the sockets will fail with ENOTCONN as
> user space things that there is no baseband link.
> 
> This patch fixes the issue by ensuring that the device_connected event
> if sent (if it hasn't been so already) as soon as the first ACL data
> packet arrives from the remote device.

This patch fixes the ENOTCONN issue for me. Let's see if Marcel or
someone else wants comment on it before we go ahead and apply it.
> 
	Gustavo
