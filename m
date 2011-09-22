Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix possible NULL pointer dereference
From: Marcel Holtmann <marcel@holtmann.org>
To: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date: Thu, 22 Sep 2011 12:58:41 +0200
In-Reply-To: <4E7B0DBF.7060406@tieto.com>
References: <20110921070804.GA5982@elgon.mountain>
		 <1316671092-4387-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	 <1316685104.1937.120.camel@aeonflux> <4E7B0DBF.7060406@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316689122.1937.124.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

> >>   	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,&ev->bdaddr);
> >> -	if (conn&&  conn->state == BT_CONNECTED) {
> >> -		hci_conn_hold(conn);
> >> -		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
> >> -		hci_conn_put(conn);
> >> -	}
> >> +	if (conn) {
> >
> > what is from with this:
> >
> > 	if (!conn)
> > 		goto unlock;
> >
> 
> Well, the file is mixed in style, thus I chose the style as for nearby 
> functions. Anyway, if this form is preferable let me know and will update.

for simple code pieces, I don't really mind, but this function is
getting more and more complicated. So less indentation is preferred.

Regards

Marcel


