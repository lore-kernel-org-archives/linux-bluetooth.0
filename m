Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Feb 2012 15:10:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/4] GATT over LE reverse service discovery fixes
Message-ID: <20120216131034.GB16080@x220.ger.corp.intel.com>
References: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Feb 14, 2012, Anderson Lizardo wrote:
> This series fixes issues when doing reverse GATT service discovery over LE.
> 
> There is still one open issue: If BlueZ creates a device without bonding (i.e.
> CreateDevice() D-Bus method), but the remote requests SMP pairing with
> "Security Request", at the end of the pairing a reverse GATT service discovery
> is issued, *regardless* of BlueZ being the initiator or not. BlueZ should only
> do reverse discovery if it is the acceptor (see comments on the
> device_bonding_complete() function on src/device.c).
> 
> To fix this, I think we need to have a more robust way to check whether we are
> initiator or acceptor, instead of simply checking for an active bonding
> request. Currently, if BlueZ receives keys from kernel over mgmt,
> device_bonding_complete() is eventually called, and if there is no active
> bonding, BlueZ assumes to be an acceptor.
> 
> In any case, with these patches we make sure this spurious service discovery
> will not crash BlueZ or create leaks. It is also applicable for "normal"
> reverse service discovery as well.

All four patches have been applied. Thanks.

Johan
