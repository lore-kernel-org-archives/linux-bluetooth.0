Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FCE4645F-A564-46FC-AA36-A265BB9CC35C@holtmann.org>
References: <1391639006-26311-1-git-send-email-andre.guedes@openbossa.org> <FCE4645F-A564-46FC-AA36-A265BB9CC35C@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Mon, 17 Feb 2014 17:23:50 -0300
Message-ID: <CACJA=fU_LDrVDBHxXB85x1ub9B6C4ZstVHYepE9YaSFfv4_ObA@mail.gmail.com>
Subject: Re: [RFC v8 01/10] Bluetooth: Create hci_stop_le_scan_req() helper
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, 2014-02-14 at 14:21 -0800, Marcel Holtmann wrote:
> Hi Andre,
>
> > This patch moves stop LE scanning duplicate code to one single
> > place and reuses it. This will avoid more duplicate code in
> > upcoming patches.
> >
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> > include/net/bluetooth/hci_core.h |  2 ++
> > net/bluetooth/hci_core.c         | 14 ++++++++++----
> > net/bluetooth/mgmt.c             |  6 +-----
> > 3 files changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 92fa75f..8aff7f9 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1212,4 +1212,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> > #define SCO_AIRMODE_CVSD       0x0000
> > #define SCO_AIRMODE_TRANSP     0x0003
> >
> > +void hci_stop_le_scan_req(struct hci_request *req);
> > +
>
> this should be close to hci_req_add definition.

I'll move it.

>
> > #endif /* __HCI_CORE_H */
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index e774669..6529f4a 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3058,7 +3058,6 @@ static void le_scan_disable_work(struct work_struct *work)
> > {
> > struct hci_dev *hdev = container_of(work, struct hci_dev,
> >    le_scan_disable.work);
> > - struct hci_cp_le_set_scan_enable cp;
> > struct hci_request req;
> > int err;
> >
> > @@ -3066,9 +3065,7 @@ static void le_scan_disable_work(struct work_struct *work)
> >
> > hci_req_init(&req, hdev);
> >
> > - memset(&cp, 0, sizeof(cp));
> > - cp.enable = LE_SCAN_DISABLE;
> > - hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> > + hci_stop_le_scan_req(&req);
> >
> > err = hci_req_run(&req, le_scan_disable_work_complete);
> > if (err)
> > @@ -4523,3 +4520,12 @@ static void hci_cmd_work(struct work_struct *work)
> > }
> > }
> > }
> > +
> > +void hci_stop_le_scan_req(struct hci_request *req)
> > +{
> > + struct hci_cp_le_set_scan_enable cp;
> > +
> > + memset(&cp, 0, sizeof(cp));
> > + cp.enable = LE_SCAN_DISABLE;
> > + hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> > +}
>
> Can we call this function hci_req_add_le_scan_disable. We should be explicit on what functions are doing. Helpers are just helpers.

I'll rename it.

BR,

Andre
