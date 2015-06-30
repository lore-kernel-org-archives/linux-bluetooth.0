Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Reinitialize the list after deletion for session user list
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150630114340.260dca22@tedd-fedora-vm>
Date: Tue, 30 Jun 2015 21:48:18 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	=?utf-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Message-Id: <ECF72DD2-A24C-433A-9B18-B0D7FAA04442@holtmann.org>
References: <20150630114340.260dca22@tedd-fedora-vm>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> If the user->list is deleted with list_del(), it doesn't initialize the
> entry which can cause the issue with list_empty(). According to the
> comment from the list.h, list_empty() returns false even if the list is
> empty and put the entry in an undefined state.
> 
> /**
> * list_del - deletes entry from list.
> * @entry: the element to delete from the list.
> * Note: list_empty() on entry does not return true after this, the entry is
> * in an undefined state.
> */
> 
> Because of this behavior, list_empty() returns false even if list is empty
> when the device is reconnected.
> 
> So, user->list needs to be re-initialized after list_del(). list.h already
> have a macro list_del_init() which deletes the entry and initailze it again.
> 
> Tested-by: Jörg Otte <jrg.otte@gmail.com>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

