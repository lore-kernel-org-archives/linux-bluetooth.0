Return-Path: <cyrus@holtmann.org>
Subject: Re: [Bluez-devel] forcing SCO connection patch
From: Guillaume Bedot <littletux@zarb.org>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <47C555E5.2000903@mizi.com>
References: <47666E1F.2000902@mizi.com>
	 <a8e1da0802242330l765b8b1ava62b857baf8a5568@mail.gmail.com>
	 <47C28A33.4070102@mizi.com>
	 <a8e1da0802250155u1b7af481va203849f68d9106b@mail.gmail.com>
	 <47C2A7FA.2060902@mizi.com>
	 <70692DDF-93B7-447E-ABEE-3CDBD94F15F1@holtmann.org>
	 <47C38D40.3040809@mizi.com>
	 <B96BD3FE-F490-4AD5-9315-ECD42CE9C728@holtmann.org>
	 <47C4C3D4.8010902@mizi.com>
	 <2A7EF87C-1340-45D7-B457-F81799674B1E@holtmann.org>
	 <47C555E5.2000903@mizi.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Feb 2008 14:04:42 +0100
Message-Id: <1204117482.6889.37.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Re,

Le mercredi 27 février 2008 à 21:21 +0900, Louis JANG a écrit :
>  	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
> -	if (!conn)
> -		goto unlock;
> +	if (!conn) {
> +		__u8 link_type = (ev->link_type == ESCO_LINK) ? SCO_LINK : ESCO_LINK;
> +
> +		conn = hci_conn_hash_lookup_ba(hdev, link_type, &ev->bdaddr);
> +		if (!conn)
> +			goto unlock;

Does your patch handle re-negotiation of the SCO link back to an eSCO
one ? Great.

And the style in your patch is better according to Marcel rules.

I vote for yours.

Best regards,

Guillaume B.

