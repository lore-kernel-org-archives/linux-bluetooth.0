Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 14 Mar 2018 23:16:03 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org, "Robert R. Howell" <rhowell@uwyo.edu>
Subject: Re: [PATCH 4.16 REGRESSION fix 1/2] Revert "Bluetooth: hci_bcm:
 Streamline runtime PM code"
Message-ID: <20180314221603.GB28738@wunner.de>
References: <20180314220603.7559-1-hdegoede@redhat.com>
 <20180314220603.7559-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314220603.7559-2-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:06:02PM +0100, Hans de Goede wrote:
> This reverts commit 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime
> PM code"). The commit msg for this commit states "No functional change
> intended.", but replacing:
> 
>  pm_runtime_get();
>  pm_runtime_mark_last_busy();
>  pm_runtime_put_autosuspend();
> 
> with:
> 
>  pm_request_resume();
> 
> Does result in a functional change, pm_request_resume() only calls
> pm_runtime_mark_last_busy() if the device was suspended before the call.

Yes, Robert Howell (cc) reported this a few days ago:
https://bugzilla.kernel.org/show_bug.cgi?id=198953

I've worked with him to develop a fix which is better IMHO than a revert,
namely he's replacing the pm_request_resume() in bcm_recv() with
pm_runtime_mark_last_busy(), and the pm_request_resume() in the interrupt
handler can stay.  He says that fixes the issue for him.

I hope he'll submit the patch shortly.

Thanks,

Lukas
