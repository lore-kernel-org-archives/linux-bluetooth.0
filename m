Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Oct 2013 09:47:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix HCI init for 1st generation BlueFRITZ!
 devices
Message-ID: <20131012064726.GB30228@x220.p-661hnu-f1>
References: <1381534927-27310-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381534927-27310-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 11, 2013, Marcel Holtmann wrote:
> The 1st generation of BlueFRITZ! devices from AVM Berlin pretend
> to be HCI version 1.2 controllers, but they are not. They are simple
> Bluetooth 1.1 devices.
> 
> Since this company never created any newer controllers, it is safe
> to use the manufacturer ID instead of an USB quirk.
> 
> < HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0
> > HCI Event: Command Complete (0x0e) plen 8
>       Read Page Scan Activity (0x03|0x001b) ncmd 1
>         Status: Success (0x00)
>         Interval: 1280.000 msec (0x0800)
>         Window: 21.250 msec (0x0022)
> < HCI Command: Read Page Scan Type (0x03|0x0046) plen 0
> > HCI Event: Command Status (0x0f) plen 4
>       Read Page Scan Type (0x03|0x0046) ncmd 1
>         Status: Unknown HCI Command (0x01)
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
