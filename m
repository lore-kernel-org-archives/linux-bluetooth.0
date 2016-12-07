Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 7 Dec 2016 10:11:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sanjay Chadha <sanjay.chadha@safetylabs.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BLE LECC Connect - ERROR - LECC fails after failing once
Message-ID: <20161207081131.GA16551@x1c.lan>
References: <!&!AAAAAAAAAAAYAAAAAAAAAMjpkborkEZIvbLN1sSIOe/CgAAAEAAAAF2sISkPZUNFhZCH+mJkrfUBAAAAAA==@safetylabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAMjpkborkEZIvbLN1sSIOe/CgAAAEAAAAF2sISkPZUNFhZCH+mJkrfUBAAAAAA==@safetylabs.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sanjay,

On Tue, Dec 06, 2016, Sanjay Chadha wrote:
> We and have found this bug in LECC: Once a central fails to connect using
> LECC with a BLE peripheral the Central cannot connect to another peripheral,
> unless until the failed peripheral advertises again. | Weird but true. More
> details:
> 
> 1. Consider: Two BLE peripheral devices BLE1 & BLE2.  BLE1 is OFF,  BLE2 is
> advertising 
> 2. central> hcitool lecc BLE1 fails since BLE is OFF  
> Example:
> > hcitool lecc  00:07:80:C0:68:C7
> Could not create connection: Connection timed out
> 
> Now central does NOT connect to any BLE peripheral. This is a VERY BIG
> issue. 
> 
> 4. central> hcitool lecc BLE2 fails
> Example:
> central> hcitool lecc 00:07:80:C0:70:24
> Could not create connection: Connection timed out
> 
> When BLE1 advertises - central can LECC connect to any peripheral device 
> 
> 5. hcitool lecc BLE2 connects
> Example:
> > hcitool lecc 00:07:80:C0:70:24
> Connection handle 65
> 
> BLE central driver maintains a LECC failed connection and fails to LECC
> Connect to a peripheral device until the failed peripheral advertises.
> A weird and easy to reproduce error - takes 2 BLE devices and a few minutes.
> 
> Anybody came across this issue?

Pretty much all bets are off if you go accessing raw HCI through hcitool
like that. Do you see the same issue if you use the higher level
interfaces? (L2CAP sockets, mgmt, or even better, bluetoothd using e.g.
bluetoothctl)

If you're still seeing the issue with the higher level interfaces it'd
help to know what's happening on the HCI level. btmon should be able to
help out with that.

Johan
