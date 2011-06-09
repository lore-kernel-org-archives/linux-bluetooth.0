Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <keithp@keithp.com>, <padovan@profusion.mobi>
CC: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Date: Thu, 9 Jun 2011 10:59:32 +0300
Subject: RE: Regression caused by "Bluetooth: Map sec_level to link key
 requirements"
Message-ID: <99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
References: <yunboy7a2so.fsf@aiko.keithp.com>
In-Reply-To: <yunboy7a2so.fsf@aiko.keithp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,=20

>Patch 13d39315c22b128f4796fc008b04914a7c32bb1a is causing a=20
>regression From 2.6.39. I cannot communicate with my Nokia=20
>N900 using either the SyncML or DUN RFCOMM services.  I get a=20
>connection reset error shortly after startup.
>
>I've reverted this patch on top of something past -rc2 (to be=20
>precise, I'm branching from ef2398019b305827ea7130ebaf7bf521b444530e).
>With the following fix-up to make things build again, my=20
>bluetooth works again.

Logs from kernel and bluez would be much appreciated to see what happend.
As I remember this was pretty well tested with BITE test by Johan.

Thanks,
Waldek
