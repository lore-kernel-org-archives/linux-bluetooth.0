Return-Path: <cyrus@holtmann.org>
Date: Sat, 15 Mar 2014 18:36:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Bluetooth: Add directed advertising support
 through connect()
Message-ID: <20140315163622.GA9647@localhost.P-661HNU-F1>
References: <1394817753-7430-1-git-send-email-johan.hedberg@gmail.com>
 <1394817753-7430-4-git-send-email-johan.hedberg@gmail.com>
 <6B7CE848-2DD5-465B-85DB-132F0ACA105F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6B7CE848-2DD5-465B-85DB-132F0ACA105F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 15, 2014, Marcel Holtmann wrote:
> > When we're in peripheral mode (HCI_ADVERTISING flag is set) the most
> > natural mapping of connect() is to perform directed advertising to the
> > peer device.
> > 
> > This patch does the necessary changes to enable directed advertising and
> > keeps the hci_conn state as BT_CONNECT in a similar way as is done for
> > central or BR/EDR connection initiation.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > include/net/bluetooth/hci.h |  1 +
> > net/bluetooth/hci_conn.c    | 75 ++++++++++++++++++++++++++++++++++++++++-----
> > net/bluetooth/hci_event.c   | 17 ++++++++--
> > 3 files changed, 83 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index be150cf8cd43..4261a67682c0 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -367,6 +367,7 @@ enum {
> > #define HCI_ERROR_REMOTE_POWER_OFF	0x15
> > #define HCI_ERROR_LOCAL_HOST_TERM	0x16
> > #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
> > +#define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
> > 
> > /* Flow control modes */
> > #define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 1a025b953f19..088ee49097bc 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -367,9 +367,18 @@ static void le_conn_timeout(struct work_struct *work)
> > {
> > 	struct hci_conn *conn = container_of(work, struct hci_conn,
> > 					     le_conn_timeout.work);
> > +	struct hci_dev *hdev = conn->hdev;
> > 
> > 	BT_DBG("");
> > 
> > +	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
> > +		u8 enable = 0x00;
> > +		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
> > +			     &enable);
> > +		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
> > +		return;
> 
> you need to add a comment why just disabling advertising is the right
> thing here. And that we later on will actually re-enable it using
> undirected advertising.

Sure, I can add a comment.

> Does it really need to be disabled first. The connection timeout error
> is not automatically disabling advertising anyway?

You're right that this callback will only get called if we have not
gotten any kind of indication from the controller that a connection
happened (or failed). This could be because of misbehaving hardware or
if we at some point start using low duty cycle directed advertising
which doesn't have the 1.28s timeout that normal directed advertising
has. I.e. I.e. this timeout is mostly for completeness sake since we
also have a timeout for HCI_LE_Create_Connection.

Johan
