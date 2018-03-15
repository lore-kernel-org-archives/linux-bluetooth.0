Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 4.16 REGRESSION fix 1/2] Revert "Bluetooth: hci_bcm:
 Streamline runtime PM code"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180314220603.7559-2-hdegoede@redhat.com>
Date: Thu, 15 Mar 2018 19:40:19 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <7B7C3F12-A785-4E7F-8267-C6072EEEB433@holtmann.org>
References: <20180314220603.7559-1-hdegoede@redhat.com>
 <20180314220603.7559-2-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> This reverts commit 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime
> PM code"). The commit msg for this commit states "No functional change
> intended.", but replacing:
> 
> pm_runtime_get();
> pm_runtime_mark_last_busy();
> pm_runtime_put_autosuspend();
> 
> with:
> 
> pm_request_resume();
> 
> Does result in a functional change, pm_request_resume() only calls
> pm_runtime_mark_last_busy() if the device was suspended before the call.
> 
> This results in the following happening:
> 
> 1) Device is runtime suspended
> 2) Device drives host_wake IRQ logically high as it starts receiving data
> 3) bcm_host_wake() gets called, causes the device to runtime-resume,
>   current time gets marked as last_busy time
> 4) After 5 seconds the autosuspend timer expires and the dev autosuspends
>   as no one has been calling pm_runtime_mark_last_busy(), the device was
>   resumed during those 5 seconds, so all the pm_request_resume() calls
>   while receiving data and/or bcm_host_wake() calls were nops
> 5) If 4) happens while the device has (just received) data in its buffer to
>   be read by the host the IRQ line is *already* / still logically high
>   when we autosuspend and since we use an edge triggered IRQ, the IRQ
>   will never trigger, causing the device to get stuck in suspend
> 
> Therefor this commit has to be reverted, so that we avoid the device
> getting stuck in suspend.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

