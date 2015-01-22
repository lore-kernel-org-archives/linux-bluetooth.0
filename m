Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix reporting invalid RSSI for LE devices
Date: Thu, 22 Jan 2015 17:29:03 +0100
Message-ID: <3446521.fKAX8Rj7db@uw000953>
In-Reply-To: <6DD4C007-3855-45A4-917C-323C2E814463@holtmann.org>
References: <1421942225-6787-1-git-send-email-szymon.janc@tieto.com> <6DD4C007-3855-45A4-917C-323C2E814463@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thursday 22 of January 2015 08:06:09 Marcel Holtmann wrote:
> Hi Szymon,
> 
> > Start Discovery was reporting 0 RSSI for invalid RSSI only for
> > BR/EDR devices. LE devices were reported with RSSI 127.
> > 
> > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > ---
> > net/bluetooth/mgmt.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index f5c4d2e..a619d98 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -7238,7 +7238,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> > 	 * However when using service discovery, the value 127 will be
> > 	 * returned when the RSSI is not available.
> > 	 */
> > -	if (rssi == HCI_RSSI_INVALID && !hdev->discovery.report_invalid_rssi)
> > +	if (rssi == HCI_RSSI_INVALID && !hdev->discovery.report_invalid_rssi &&
> > +	    link_type == ACL_LINK)
> > 		rssi = 0;
> 
> good catch actually. Which is the first kernel affected by this? Is this 3.18 or 3.19?

3.18 is not affected.


-- 
Best regards, 
Szymon Janc
