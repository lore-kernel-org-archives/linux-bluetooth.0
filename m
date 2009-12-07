Return-Path: <cyrus@holtmann.org>
Message-ID: <4B1D3714.9080003@marcansoft.com>
Date: Mon, 07 Dec 2009 18:10:44 +0100
From: Hector Martin <hector@marcansoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Bastien Nocera <hadess@hadess.net>,
 Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Wiimote pairing?
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry for the lack of proper thread headers. I subscribed to ask about
this very issue and it turns out it was asked two days ago in the
already, after I checked out the archives :)

Seeing as everything is done using strings everywhere, including the
storage (which is a text file), I think it might be easier to just
define a hex format. Something like $0011deadbeef for raw binary
pincodes expressed as hex. This will let all the existing tools handle a
raw PIN.

The Bluetooth spec talks about numeric and alphanumeric PIN codes, but I
haven't seen mention of special characters. I think the likelihood of
having issues with real PINs with a starting $ sign is fairly low (and
they could always be expressed as hex).

An alternative would be to use a more traditional backslash escape
sequence type format, but that's harder to parse.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
