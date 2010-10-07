Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 7 Oct 2010 13:36:20 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/7] Bluetooth: Add LE connect support
Message-ID: <20101007163619.GB4893@vigoh>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
 <1286390535-27462-3-git-send-email-ville.tervo@nokia.com>
 <1286449089.6145.91.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286449089.6145.91.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Marcel Holtmann <marcel@holtmann.org> [2010-10-07 12:58:09 +0200]:

> Hi Ville,
> 
> > Add logic to create LE connections.


Could you be more verbose on the commit message, that way people can
understand better what you are doing in the patch. ;) 

> > 
> > Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> > ---
> >  include/net/bluetooth/hci.h      |    1 +
> >  include/net/bluetooth/hci_core.h |    6 ++-
> >  net/bluetooth/hci_conn.c         |   38 ++++++++++++++-
> >  net/bluetooth/hci_event.c        |  100 +++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 141 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index b86aed5..b326240 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -162,6 +162,7 @@ enum {
> >  #define SCO_LINK	0x00
> >  #define ACL_LINK	0x01
> >  #define ESCO_LINK	0x02
> > +#define LE_LINK		0x03
> 
> this is not a value defined by the specification, while the others are.
> And some functions match these to HCI event. So if wanna do it like
> this, then using something like 0x80 is better.

A comment in the code saying that is also a good ideia.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
