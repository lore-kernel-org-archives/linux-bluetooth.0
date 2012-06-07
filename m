Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 10:25:52 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add support for encryption key refresh
Message-ID: <20120607072550.GE32366@aemeltch-MOBL1>
References: <1339052318-11423-1-git-send-email-johan.hedberg@gmail.com>
 <1339052318-11423-3-git-send-email-johan.hedberg@gmail.com>
 <20120607070720.GC32366@aemeltch-MOBL1>
 <20120607071414.GA12091@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120607071414.GA12091@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jun 07, 2012 at 03:14:14PM +0800, Johan Hedberg wrote:
> On Thu, Jun 07, 2012, Andrei Emeltchenko wrote:
> > > +	if (conn->state == BT_CONFIG) {
> > > +		if (!ev->status)
> > > +			conn->state = BT_CONNECTED;
> > > +
> > > +		hci_proto_connect_cfm(conn, ev->status);
> > > +		hci_conn_put(conn);
> > > +	} else {
> > > +		hci_auth_cfm(conn, ev->status);
> > > +
> > > +		hci_conn_hold(conn);
> > 
> > If you want to keep extra hold(conn) you may just not put. Is this typo?
> > 
> > > +		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> > > +		hci_conn_put(conn);
> > > +	}
> 
> This is just copy-paste from hci_auth_complete_evt(). I think the
> intention of the hold+put is to restart or remove the disconnect timer
> with the new disc_timeout value or something similar. If the code above
> needs fixing then so does the code in hci_auth_complete_evt().

OK. Got it. Seems that cancel_delayed_work(&conn->disc_work); is enough
here.

Best regards 
Andrei Emeltchenko 

