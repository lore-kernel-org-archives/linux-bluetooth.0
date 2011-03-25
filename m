Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 18:49:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add local Extended Inquiry Response (EIR)
 support
Message-ID: <20110325164902.GA10252@jh-x301>
References: <1301059544-6200-1-git-send-email-johan.hedberg@gmail.com>
 <AANLkTinhC8-1fe0KYBb+Tz-x7RZSC3FtometdNw05xgX@mail.gmail.com>
 <20110325163549.GA9894@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20110325163549.GA9894@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 25, 2011, Johan Hedberg wrote:
> > > +       }
> > > +
> > > +       memcpy(&val, uuid128, 4);
> > > +
> > > +       val = be32_to_cpu(val);
> > 
> > I noticed just know the those UUID handling functions from management
> > API are assuming UUIDs in network order. We will need to change this,
> > or take extra care when reusing them for Advertising Data and GATT
> > uuids.
> 
> Right. This code is pretty much a copy of what user space already has
> (hciops.c), and that code is relying on SDP (i.e. network) byte order
> UUID-128s.

Actually now that I think about it, for consistency with everything else
in the management interface the byte order, at least in the management
protocol, should probably stay little endian (mimicing HCI). We *could*
store the UUIDs in hdev->uuids in host byte order, but then we'll need
to add all the byte-order dependent code that we've recently created for
user space with bt_uuid.

The really important part is the management protocol since that's what's
visible to user space. The internal storage of these UUIDs in the kernel
is secondary. Personally, I'd like to avoid any 128-bit byte order
conversions if possible but I can see how this can be argued in both
ways.

Johan
