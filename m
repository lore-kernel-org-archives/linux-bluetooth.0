Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <keithp@keithp.com>, <johan.hedberg@gmail.com>
CC: <padovan@profusion.mobi>, <marcel@holtmann.org>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Thu, 9 Jun 2011 20:11:21 +0300
Subject: RE: Regression caused by "Bluetooth: Map sec_level to link key
 requirements"
Message-ID: <99B09243E1A5DA4898CDD8B700111448175AA2DE98@EXMB04.eu.tieto.com>
References: <yunboy7a2so.fsf@aiko.keithp.com>
 <99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
 <20110609083345.GA2894@dell.ccr.corp.intel.com>
 <yuny61b3pnm.fsf@aiko.keithp.com>
In-Reply-To: <yuny61b3pnm.fsf@aiko.keithp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,=20

>I re-pair'ed using a manually entered a 16 digit pin, but now=20
>DUN setup doesn't succeed at all.

Did you try to remove all stored link keys and start again?
If you already have a pincode which is insecure you have to remove it manua=
lly.

Try 'hciconfig hciX noauth noencrypt ' before.

Check syslog and switch debug on in the kernel first.


Waldek
