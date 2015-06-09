Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jun 2015 08:54:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix encryption key size handling for LTKs
Message-ID: <20150609055436.GA13005@t440s.P-661HNU-F1>
References: <1433776479-20712-1-git-send-email-johan.hedberg@gmail.com>
 <CC159BEB-80C3-4ED9-BD3A-64D5C5E78669@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CC159BEB-80C3-4ED9-BD3A-64D5C5E78669@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jun 09, 2015, Marcel Holtmann wrote:
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4955,7 +4955,8 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > 			goto not_found;
> > 	}
> > 
> > -	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
> > +	memcpy(cp.ltk, ltk->val, ltk->enc_size);
> > +	memset(cp.ltk + ltk->enc_size, 0, sizeof(cp.ltk) - ltk->enc_size);
> > 	cp.handle = cpu_to_le16(conn->handle);
> 
> you did test that a size of 16 - 16 = 0 is not causing memset to go
> bezerk and crash?

I'd say it's a severely broken memset implementation that would break
because of passing 0. At least all the pure C based ones I could find in
the kernel tree are correctly implemented in this regard. I did test
this in practice too but that only covers the arch that I use.

Johan
