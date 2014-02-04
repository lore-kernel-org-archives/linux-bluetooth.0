Return-Path: <cyrus@holtmann.org>
Message-ID: <1391538792.26488.40.camel@bali>
Subject: Re: [RFC v7 08/11] Bluetooth: Temporarily stop background scanning
 on discovery
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Tue, 04 Feb 2014 15:33:12 -0300
In-Reply-To: <9BB5F5F9-6828-491B-B918-B0909BCA2408@holtmann.org>
References: <1391446588-18729-1-git-send-email-andre.guedes@openbossa.org>
	 <1391446588-18729-8-git-send-email-andre.guedes@openbossa.org>
	 <9BB5F5F9-6828-491B-B918-B0909BCA2408@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

On Mon, 2014-02-03 at 20:25 -0800, Marcel Holtmann wrote:
> Hi Andre,
> 
> > If the user sends a mgmt start discovery command while the background
> > scanning is running, we should temporarily stop it. Once the discovery
> > finishes, we start the background scanning again.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> > net/bluetooth/hci_core.c |  2 ++
> > net/bluetooth/mgmt.c     | 12 ++++++++----
> > 2 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 388a453..222bd07 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1609,6 +1609,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
> > 
> > 	switch (state) {
> > 	case DISCOVERY_STOPPED:
> > +		hci_update_background_scan(hdev);
> > +
> > 		if (hdev->discovery.state != DISCOVERY_STARTING)
> > 			mgmt_discovering(hdev, 0);
> > 		break;
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index ce7ef33..83af8de 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3319,11 +3319,15 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
> > 			goto failed;
> > 		}
> > 
> > +		/* If controller is scanning, it means the background scanning
> > +		 * is running. Thus, we should temporarily stop it in order to
> > +		 * set the discovery scanning parameters.
> > +		 */
> > 		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
> > -			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
> > -					 MGMT_STATUS_BUSY);
> > -			mgmt_pending_remove(cmd);
> > -			goto failed;
> > +			memset(&enable_cp, 0, sizeof(enable_cp));
> > +			enable_cp.enable = LE_SCAN_DISABLE;
> > +			hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE,
> > +				    sizeof(enable_cp), &enable_cp);
> > 		}
> 
> is the start_discovery protected enough by itself so that we do not accidentally stop some discovery that got triggered which is actually not a background scan.

A few lines above (the diff doesn't show it), we check the discovery
state, ensuring the discovery is not running at this point.

BR,

Andre
