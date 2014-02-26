Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Feb 2014 22:26:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 03/17] Bluetooth: Stop scanning on LE connection
Message-ID: <20140226202649.GA30231@localhost.P-661HNU-F1>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
 <1393362104-12175-4-git-send-email-andre.guedes@openbossa.org>
 <C16121F0-C942-4E45-9D4A-089D22195D12@holtmann.org>
 <CACJA=fW8hNKv5i_uDMTGP258A9QDT0KFGZbDRZ0vxYqZNdKr_A@mail.gmail.com>
 <1D0457DC-259F-4680-A411-7D3060744C27@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1D0457DC-259F-4680-A411-7D3060744C27@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 26, 2014, Marcel Holtmann wrote:
> >>> +static void hci_req_add_le_create_conn(struct hci_request *req,
> >>> +                                    struct hci_conn *conn)
> >>> +{
> >>> +     struct hci_cp_le_create_conn cp;
> >>> +     struct hci_dev *hdev = conn->hdev;
> >>> +     u8 own_addr_type;
> >>> +
> >>> +     memset(&cp, 0, sizeof(cp));
> >>> +
> >>> +     /* Update random address, but set require_privacy to false so
> >>> +      * that we never connect with an unresolvable address.
> >>> +      */
> >>> +     if (hci_update_random_address(req, false, &own_addr_type))
> >>> +             return;
> >>> +
> >>> +     conn->src_type = own_addr_type;
> >>> +
> >>> +     cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> >>> +     cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> >>> +     bacpy(&cp.peer_addr, &conn->dst);
> >>> +     cp.peer_addr_type = conn->dst_type;
> >>> +     cp.own_address_type = conn->src_type;
> >> 
> >> the reason why you get the own_addr_type when setting the random
> >> address is to actually use it here.
> >> 
> >> This is important since in cases where LE Privacy is enabled and we
> >> are using RPA, we want the random address used.
> > 
> > Year, I'm aware of it. 'own_addr_type' is assigned to
> > 'conn->src_type'. Then, 'conn->src_type' is used in
> > 'cp.own_address_type'.
> > 
> > IOW:
> >        conn->src_type = own_addr_type;
> >        ...
> >        cp.own_address_type = conn->src_type;
> > 
> > Or am I missing something?
> 
> the own_addr_type refers to the identity address.

No, it refers to whatever we want to pass to the HCI command.

> That is either the public address or a static random address. Based on
> which one it is the identity address type aka own_addr_type is either
> 0x00 or 0x01.

What's a bit confusing here is that in all other places we assign the
returned value directly to cp.own_addr_type and the hci_create_le_conn
function always takes care of updating the conn->src_type value. Now
that the hci_create_le_conn function gets removed in the patch set
however this new function becomes responsible for updating
conn->src_type. Nevertheless, I'd keep the original style from
hci_create_le_conn which assigns the same own_addr_type variable to both
conn->src_type as well as cp.own_addr_type.

In general what would help a lot in avoiding this kind of confusion is
to have proper code comments explaining what we're doing and more
importantly why we're doing it. The essential part here is that we track
the type used for HCI_LE_Create_Connection as long as the connection
attempt is in progress and update it to match the Identity Address as
soon as the connection is successful.

Johan
