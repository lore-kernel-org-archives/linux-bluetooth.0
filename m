Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Mar 2013 15:43:49 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH RESEND] bluetooth: btmrvl_sdio: look for sd8688 firmware
 in proper location
Message-ID: <20130315184349.GB20196@joana>
References: <1363172670-14596-1-git-send-email-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363172670-14596-1-git-send-email-lkundrak@v3.sk>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lubomir,

* Lubomir Rintel <lkundrak@v3.sk> [2013-03-13 12:04:30 +0100]:

> The firmware images are shared with libertas_sdio WiFi chip and used to be in
> libertas/ subtree in linux-firmware. As btmrvl_sdio used to look into the
> linux-firmware root, it ended up being unsuccessful. Since the firmware files
> are not specific to the libertas hardware, they're being moved into mrvl/ now.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> 
> Now that the relevant changes are in linux-firmware it makes sense to merge 
> this to make the driver look for correct firmware files.
> 
>  drivers/bluetooth/btmrvl_sdio.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
