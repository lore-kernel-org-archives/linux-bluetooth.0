Return-Path: <SRS0+437cfc2f3365271d2af9+412+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Bluez-devel] tcsendbreak and flow control on hciattach (csr
	chip)
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1097229854.4893.4.camel@pegasus>
References: <39417DF3286A66428FA558987839F44F152D99@SINTEFXCH01.sintef.no>
	 <1097229854.4893.4.camel@pegasus>
Content-Type: text/plain
Date: Sat, 09 Oct 2004 10:30:02 +0100
Message-Id: <1097314202.14679.28.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-10-08 at 12:04 +0200, Marcel Holtmann wrote:
> maybe this is CSR specific, I don't know. Actually I wasn't aware of
> that the -b option is really used. However if the 0.5 seconds sleep is
> needed then send me a patch for it and I will apply it.

IIRC the CSR units ship with the 'reset on break' PS key turned off so
it doesn't have any effect anyway. It's very useful if you change the
UART speed on attach though, when you want to get the thing back into a
known state.

-- 
dwmw2
