Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 0/4] Bluetooth: Associate connectable setting with adv type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 14 Oct 2013 20:24:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E37D9250-EE14-4B24-B3BA-C7C7AEC97123@holtmann.org>
References: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a rewritten patch set to allow associating the connectable
> setting with the advertising type. Unlike the first attempt this one
> doesn't introduce a new parameter to enable_advertising() but instead
> does a pending mgmt command lookup to help determine the right
> advertising type.
> 
> There's also a fourth patch to do similar refactoring for
> set_discoverable as we did for set_connectable wrt. splitting raw HCI
> sockets from mgmt control, but I didn't quite get around to tying that
> to the advertising data yet (the general discoverable flag).
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (4):
>      Bluetooth: Make Set Connectable also update the LE advertising type
>      Bluetooth: Move set_bredr_scan() to avoid forward declaration
>      Bluetooth: Fix updating scan mode in set_bredr()
>      Bluetooth: Convert Set Discoverable to use an asynchronous request
> 
> net/bluetooth/mgmt.c | 144 ++++++++++++++++++++++++++++++++++++++-------------
> 1 file changed, 109 insertions(+), 35 deletions(-)

all four patches have been applied to bluetooth-next tree.

Regards

Marcel

