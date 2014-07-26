Return-Path: <cyrus@holtmann.org>
Date: Sat, 26 Jul 2014 14:17:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v4 1/2] Bluetooth: Add support for using controller white
 list filtering
Message-ID: <20140726111703.GA7107@t440s.P-661HNU-F1>
References: <1406208058-15299-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406208058-15299-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 24, 2014, Marcel Holtmann wrote:
> The Bluetooth controller can use a white list filter when scanning
> to avoid waking up the host for devices that are of no interest.
> 
> Devices marked as reporting, direct connection (incoming) or general
> connection are now added to the controller white list. The update of
> the white list happens just before enabling passive scanning.
> 
> In case the white list is full and can not hold all devices, the
> white list is not used and the filter policy set to accept all
> advertisements.
> 
> Using the white list for scanning allows for power saving with
> controllers that do not handle the duplicate filtering correctly.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

Both of these patches have been applied to bluetooth-next. Thanks.

Johan
