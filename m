Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Nov 2011 10:59:30 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Define HCI reasons instead of magic number
Message-ID: <20111104085928.GB1313@aemeltch-MOBL1>
References: <1320221534-13765-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1320243430.15441.280.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320243430.15441.280.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 02, 2011 at 03:17:09PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Use HCI error reasons instead of magic numbers.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/hci.h      |    8 ++++++++
> >  include/net/bluetooth/hci_core.h |    2 +-
> >  net/bluetooth/hci_conn.c         |    2 +-
> >  net/bluetooth/hci_event.c        |    4 ++--
> >  net/bluetooth/l2cap_core.c       |    8 ++++----
> >  5 files changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index c5fcd13..b9b0ca9 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -288,6 +288,10 @@ struct hci_cp_create_conn {
> >  	__u8     role_switch;
> >  } __packed;
> >  
> > +#define HCI_REASON_DISC_AUTH_FAILURE	0x05
> > +#define HCI_REASON_DISC_REMOTE_USER	0x13
> > +#define HCI_REASON_DISC_LOCAL_HOST	0x16
> > +
> 
> actually these are HCI error/status codes that are well defined and go
> beyond just disconnect reason. Using REASON_DISC seems to be wrong here.
> Can you come up with better naming?

what about following:

+/* ---- HCI Error Codes ---- */
+#define HCI_ERROR_AUTH_FAILURE         0x05
+#define HCI_ERROR_REJ_BAD_ADDR         0x0f
+#define HCI_ERROR_REMOTE_USER_TERM     0x13
+#define HCI_ERROR_LOCAL_HOST_TERM      0x16
+#define HCI_ERROR_PAIRING_NOT_ALLOWED  0x18
+

Best regards 
Andrei Emeltchenko 
