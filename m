Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 14:08:52 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>,
	padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 5/7] Bluetooth: Double check sec req for pre 2.1
 device
Message-ID: <20110428210852.GA25436@jh-x301>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303985279-3944-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110428181117.GA11610@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110428181117.GA11610@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 28, 2011, Johan Hedberg wrote:
> On Thu, Apr 28, 2011, Waldemar Rymarkiewicz wrote:
> > +static int rfcomm_accept_secure(struct hci_conn *conn, struct rfcomm_dlc *d)
> > +{
> > +	BT_DBG("");
> > +
> > +	if (d->sec_level != BT_SECURITY_HIGH)
> > +		return 1; /* Accept */
> > +
> > +	if (conn->key_type == HCI_LK_AUTH_COMBINATION ||
> > +			(conn->key_type == HCI_LK_COMBINATION &&
> > +			conn->pin_length == 16))
> > +		return 1;
> > +
> > +	return 0; /* Reject */
> > +}
> 
> If conn->key_type and conn->pin_length are like you want them to be in
> the second if-statement, shouldn't conn->sec_level already be
> BT_SECURITY_HIGH? And if that's the case I guess you don't need a
> separate function at all: just check for conn->sec_level. Btw, what
> purpose does d->sec_level serve when we already have conn->sec_level?

Never mind. d->sec_level is obviously the security requirement for the
RFCOMM link which could be different from the current ACL security
level. Nevertheless, I think instead of doing the complicated
if-statement on the key_type & pin_length you can simply check the value
of conn->sec_level.

Johan
