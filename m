Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 12:12:24 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 14/20] Bluetooth: AMP: Add AMP key calculation
Message-ID: <20120725091217.GA2056@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724212944.GH20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724212944.GH20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 24, 2012 at 06:29:44PM -0300, Gustavo Padovan wrote:
> > +
> > +	hexdump(keybuf, HCI_AMP_LINK_KEY_SIZE);
> 
> Is these hex prints worthwhile? Seems kind expensive, right?

Yes, I will remove this print.

> > +	result = hmac_sha256(keybuf, HCI_AMP_LINK_KEY_SIZE, "gamp", 4,
> > +			     gamp_key);
> > +	hexdump(gamp_key, HCI_AMP_LINK_KEY_SIZE);
> > +
> > +	if (result)
> > +		goto done;
> > +
> > +	if (conn->key_type == 3) {
> > +		BT_DBG("gamp_key");
> > +		hexdump(gamp_key, HCI_AMP_LINK_KEY_SIZE);
> > +		memcpy(data, gamp_key, HCI_AMP_LINK_KEY_SIZE);
> > +		goto done;
> > +	}
> > +
> > +	result = hmac_sha256(gamp_key, HCI_AMP_LINK_KEY_SIZE, "802b", 4,
> > +			     b802_key);
> 
> Can't you pass data directly here, instead of b802_key? This could avoid an
> extra memcpy.

Yes, will do this way.

Best regards 
Andrei Emeltchenko 

