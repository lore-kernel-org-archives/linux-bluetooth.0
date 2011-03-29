Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Mar 2011 17:17:01 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add local Extended Inquiry Response (EIR)
 support
Message-ID: <20110329201701.GB8336@joana>
References: <1301310443-13197-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301310443-13197-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-03-28 14:07:23 +0300]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> This patch adds automated creation of the local EIR data based on what
> 16-bit UUIDs are registered and what the device name is. This should
> cover the majority use cases, however things like 32/128-bit UUIDs, TX
> power and Device ID will need to be added later to be on par with what
> bluetoothd is capable of doing (without the Management interface).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
> v2: Updated to assume that the UUIDs are in little endian byte order
> like like all other data types in the management interface.
> 
>  include/net/bluetooth/hci.h      |    8 ++
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/mgmt.c             |  163 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+), 0 deletions(-)

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
