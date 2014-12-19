Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Dec 2014 12:19:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Add hci_request parameter to
 hci_update_background_scan
Message-ID: <20141219101934.GC17821@t440s.lan>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com>
 <1418981017-10462-3-git-send-email-johan.hedberg@gmail.com>
 <3DBBCAB1-FDA2-4CE1-B8B7-3684F6548C04@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DBBCAB1-FDA2-4CE1-B8B7-3684F6548C04@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 19, 2014, Marcel Holtmann wrote:
> > Many places using hci_update_background_scan() try to synchronize
> > whatever they're doing with the help of hci_request callbacks. However,
> > since the hci_update_background_scan() function hasn't so far accepted a
> > hci_request pointer any commands triggered by it have been left out by
> > the synchronization. This patch an extra parameter to the function to
> > fix the issue. This there are also many places where there is no
> > existing hci_request context, the parameter is made optional, i.e. by
> > passing NULL hci_update_background_scan() uses its own request and a
> > dummy callback.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > include/net/bluetooth/hci_core.h |  2 +-
> > net/bluetooth/hci_conn.c         |  2 +-
> > net/bluetooth/hci_core.c         | 33 ++++++++++++++++++++-------------
> > net/bluetooth/hci_event.c        |  4 ++--
> > net/bluetooth/mgmt.c             | 19 +++++++++----------
> > 5 files changed, 33 insertions(+), 27 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 75aaae07037f..d89a359c83ea 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -940,7 +940,7 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
> > 						  bdaddr_t *addr,
> > 						  u8 addr_type);
> > 
> > -void hci_update_background_scan(struct hci_dev *hdev);
> > +void hci_update_background_scan(struct hci_dev *hdev, struct hci_request *req);
> 
> this goes a bit against what we done otherwise in the code base. We
> normally only give the hci_request pointer since that always provides
> the hci_dev as well.
> 
> I have the feeling that we might better split this into two functions.
> One just taking hci_dev and the other just taking hci_request. Or we
> have to make all callers create a hci_request context in the first
> place.

My change is consistent with hci_update_page_scan() so I suppose that
needs fixing too.

I still feel like this "optional parameter" approach isn't too
convoluted, but if you insist I think I'd rather split this into two
functions. Requiring all places to initialize a hci_request and do
hci_req_run would be quite a lot of duplicated boiler-plate code for
little benefit.

Johan
