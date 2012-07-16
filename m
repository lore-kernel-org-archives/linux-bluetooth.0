Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jul 2012 11:02:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: Override status if local user rejects
 pairing
Message-ID: <20120716080242.GA25645@x220>
References: <1342188522-27623-1-git-send-email-jaganath.k@samsung.com>
 <20120715150231.GA1932@x220.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120715150231.GA1932@x220.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Sun, Jul 15, 2012, Johan Hedberg wrote:
> On Fri, Jul 13, 2012, Jaganath Kanakkassery wrote:
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -42,6 +42,7 @@
> >  #define MGMT_STATUS_NOT_POWERED		0x0f
> >  #define MGMT_STATUS_CANCELLED		0x10
> >  #define MGMT_STATUS_INVALID_INDEX	0x11
> > +#define MGMT_STATUS_AUTH_REJECTED	0x12
> 
> Why this? You didn't have it in v3. The existing STATUS_REJECTED should
> be enough, right?
> 
> > @@ -2659,6 +2659,8 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  		else
> >  			secure = 0;
> >  
> > +		conn->auth_rejected = false;
> > +
> >  		mgmt_pin_code_request(hdev, &ev->bdaddr, secure);
> >  	}
> >  
> 
> I think it would be cleaner to set this to false immediately after the
> conn lookup in this function. Also, when HCI_PAIRABLE is not set you
> should set auth_rejected to true since that's also a local rejection
> (even though it's an automatic one).
> 
> > @@ -3139,6 +3141,8 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  		else
> >  			cp.oob_data = 0x00;
> >  
> > +		conn->auth_rejected = false;
> > +
> >  		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_REPLY,
> >  			     sizeof(cp), &cp);
> >  	} else {
> 
> Same here.

A couple more things:

You should also clear the variable in the link key request handler. If
we respond with a positive link key response but the remote side
responds with a negative one with SSP you will get a "PIN or Key
Missing" HCI error which must not be overwritten by the flag (wrongly)
being set.

Since we already have conn->flags let's add another one there instead of
adding a completely new bool struct member. I'd propose
HCI_CONN_AUTH_REJECTED.

Johan
