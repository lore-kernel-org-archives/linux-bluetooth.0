Return-Path: <cyrus@holtmann.org>
Message-ID: <1335102475.16897.351.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: Move device initialization to
 hci_alloc_dev()
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Sun, 22 Apr 2012 15:47:55 +0200
In-Reply-To: <1335098400-24571-2-git-send-email-dh.herrmann@googlemail.com>
References: <1335098400-24571-1-git-send-email-dh.herrmann@googlemail.com>
	 <1335098400-24571-2-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> We currently initialize locks, lists, works, etc. in hci_register_dev()
> (hci_alloc_dev() was added later) which is bogus because an hdev is in an
> invalid state if it is not registered.
> This patch moves all memory initialization to hci_alloc_dev(). Device
> registering and registration of sub-modules is still left in
> hci_register_dev() as it belongs there.
> 
> The benefit is (despite cleaning up the code-base) we can now always be
> sure that an hdev is a valid object and can be locked and worked on even
> though it may not be registered.
> 
> This patch also reorders the initialization to be easier to understand.
> First the memory is initialized, then all generic structures and as last
> step the sub-init functions are called. This guarantees that all
> dependencies are initialized in the right order and makes it also easier
> to find a specific line. We previously initialized it in the same order as
> the "struct hci_dev" is declared which seems pretty random.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> Sorry for reordering the calls, it makes reviewing very hard. However, I think
> it improves readability a _lot_. I can resend without reordering if you want.

I am fine with this. And I could not spot any issue here. So I went
ahead and applied all 3 patches to bluetooth-next tree.

Regards

Marcel


