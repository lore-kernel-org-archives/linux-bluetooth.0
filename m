Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Reply-To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/2] Bluetooth: Remove magic bluetooth version numbers
References: 
	 <1322138190-21593-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322138190-21593-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	  <1322222621.29909.21.camel@aeonflux>
In-Reply-To: <1322222621.29909.21.camel@aeonflux>
Content-Type: text/plain; charset=utf-8
Date: Fri, 25 Nov 2011 23:53:52 +0400
Message-Id: <1322250832.21980.2.camel@Nokia-N900>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

----- 
> Hi Andrei,
> 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> > include/net/bluetooth/bluetooth.h |       5 +++++
> > net/bluetooth/hci_conn.c                   |       2 +-
> > net/bluetooth/hci_event.c                 |       6 +++---
> > 3 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/bluetooth.h
> > b/include/net/bluetooth/bluetooth.h index 38cd3da..97264fc 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -36,6 +36,11 @@
> > #define PF_BLUETOOTH    AF_BLUETOOTH
> > #endif
> > 
> > +/* Bluetooth versions */
> > +#define BLUETOOTH_VER_1_1    1
> > +#define BLUETOOTH_VER_1_2    2
> > +#define BLUETOOTH_VER_2_0    3
> > +
> > /* Reserv for core and drivers use */
> > #define BT_SKB_RESERVE    8
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index de0b93e..b328ac6 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -123,7 +123,7 @@ static void hci_acl_connect_cancel(struct hci_conn
> > *conn)
> > 
> >     BT_DBG("%p", conn);
> > 
> > -    if (conn->hdev->hci_ver < 2)
> > +    if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
> >         return;
> > 
> >     bacpy(&cp.bdaddr, &conn->dst);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 7da7ef6..60651fa 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -498,7 +498,7 @@ static void hci_setup_event_mask(struct hci_dev
> > *hdev)
> > 
> >     /* CSR 1.1 dongles does not accept any bitfield so don't try to set
> >      * any event mask for pre 1.2 devices */
> > -    if (hdev->lmp_ver <= 1)
> > +    if (hdev->lmp_ver <= BLUETOOTH_VER_1_1)
> >         return;
> 
> maybe in an extra patch we change this to < BLUETOOTH_VER_1_2 to match
> it exactly what the comment says about pre 1.2.

Do you want it to be a separate patch?

-- Regards, Andrei
