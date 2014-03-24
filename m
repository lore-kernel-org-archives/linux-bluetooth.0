Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Mar 2014 16:52:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Bluetooth: Don't send device found events during
 passive scanning
Message-ID: <20140324145235.GA31526@t440s.lan>
References: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com>
 <1395650883-25577-2-git-send-email-johan.hedberg@gmail.com>
 <53304433.30507@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53304433.30507@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Mar 24, 2014, Andre Guedes wrote:
> On 03/24/2014 05:48 AM, johan.hedberg@gmail.com wrote:
> >From: Johan Hedberg <johan.hedberg@intel.com>
> >
> >Passive LE scanning is only used by the kernel-internal connection
> >establishment procedure. It makes therefore little sense to send device
> >found events to user space.
> 
> Not sure this patch is necessary. This feature is already garanteed
> by this patch 12602d0cc005354a519b3eba443d7912ab71313a .

First of all, I'm glad you're reviewing my patches :)

Secondly, yes I'm aware of that other patch and discovery check. I added
this extra one for clarity and for simplifying the logic of the
advertising report processing function (so it can assume that we're
doing active scanning once we've gone past this first if-statement).

> >diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >index 43872af20aa4..403c1d96331a 100644
> >--- a/net/bluetooth/hci_event.c
> >+++ b/net/bluetooth/hci_event.c
> >@@ -3944,8 +3944,12 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
> >  static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> >  			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
> >  {
> >-	if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> >-		check_pending_le_conn(hdev, bdaddr, bdaddr_type);
> >+	/* Passive scanning shouldn't trigger any device found events */
> >+	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
> >+		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> >+			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
> >+	    return;
> >+	}
> 
> Additionally, as a side effect of this change, automatic connection
> won't be establish while discovery is running anymore. So it can add
> even more delay to our reconnection procedure (10.24 seconds max).
> Did you considered this?

Yes, I've considered it, however no one seems to be 100% sure either way
what is the best policy. Either you abort the discovery procedure the
user has started in hopes of pairing/connecting a new device, or you
delay the connection to an existing device. For now, I decided to be
consistent with what the "old" user space based reconnection code is
doing, i.e. ignoring events while active discovery has been requested.

Johan
