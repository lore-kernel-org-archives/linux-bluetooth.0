Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/6] Bluetooth: Add HCI_RSSI_INVALID for unknown RSSI value
Date: Thu, 04 Dec 2014 11:24:03 +0100
Message-ID: <14329907.Jd9mZKriik@uw000953>
In-Reply-To: <82B4FEE0-A5A7-4E7B-B526-F278C316DA76@holtmann.org>
References: <1417684441-103825-1-git-send-email-marcel@holtmann.org> <2879632.J5o8eFvCrV@uw000953> <82B4FEE0-A5A7-4E7B-B526-F278C316DA76@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thursday 04 of December 2014 11:13:08 Marcel Holtmann wrote:
> Hi Szymon,
> 
> >> The Bluetooth core specification defines the value 127 as invalid for
> >> RSSI values. So instead of hard coding it, lets add a constant for it.
> >> 
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >> ---
> >> include/net/bluetooth/hci.h | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >> index 569c077778b6..b6f7be1eb919 100644
> >> --- a/include/net/bluetooth/hci.h
> >> +++ b/include/net/bluetooth/hci.h
> >> @@ -412,6 +412,7 @@ enum {
> >> 
> >> /* The core spec defines 127 as the "not available" value */
> >> #define HCI_TX_POWER_INVALID	127
> >> +#define HCI_RSSI_INVALID	127
> > 
> > Isn't that value depending on command, event, link and controller type?
> 
> we use it for the mgmt side of things and there it is whatever we want it to be.

At least for inquiry result (no RSSI) 0 is passed to mgmt_device_found() and that seems
to be used by userspace as RSSI unavailable.

> 
> Regards
> 
> Marcel
> 

-- 
Best regards, 
Szymon Janc
