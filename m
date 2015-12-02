Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 2 Dec 2015 10:36:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use continuous scanning when creating LE
 connections
Message-ID: <20151202083650.GA13305@t440s.lan>
References: <1448880520-12810-1-git-send-email-johan.hedberg@gmail.com>
 <A56C1B29-8433-42B7-80E5-580E28BBCB53@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A56C1B29-8433-42B7-80E5-580E28BBCB53@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 01, 2015, Marcel Holtmann wrote:
> > All LE connections are now triggered through a preceding passive scan
> > and waiting for a connectable advertising report. This means we've got
> > the best possible guarantee that the device is within range and should
> > be able to request the controller to perform continuous scanning. This
> > way we minimize the risk that we miss out on any advertising packets.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > net/bluetooth/hci_conn.c | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index e2600213cd50..f28741d78e0b 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -726,8 +726,12 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> > 	if (hci_update_random_address(req, false, &own_addr_type))
> > 		return;
> > 
> > +	/* Set interval and window to same value to enable continuous
> > +	 * scanning.
> > +	 */
> 
> I think we want to phrase this as using a scan window as large as the
> scan interval to trigger a full duty / continuous scan. Just to be a
> bit more clearer.

I was trying to follow the same phrasing as the specification uses:

"The LE_Scan_Window parameter shall always be set to a value smaller or
equal to the value set for the LE_Scan_Interval parameter. If they are
set to the same value scanning should be run continuously."

However I don't care too strongly about this, so if you still prefer "as
large as" I can change it.

> > 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> > -	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> > +	cp.scan_window = cp.scan_interval;
> > +
> 
> And I know you try to optimize the cpu_to_le16 out here, but honestly
> I would prefer this:
> 
> 	cp.scan_window = cpu_to_le16(hdev->le_scan_interval);

My initial reaction to this is "looks like a copy-paste bug where we
forgot to change to use the right variable" whereas the variant I went
with gives more of an impression of explicit intent. However here too I
wont insist - either way is fine with me.

Johan
