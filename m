Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Sanjay Chadha" <sanjay.chadha@safetylabs.org>
To: <linux-bluetooth@vger.kernel.org>
References: 
In-Reply-To: 
Subject: BLE LECC Connect - ERROR - LECC fails after failing once 
Date: Tue, 6 Dec 2016 16:51:17 -0500
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAMjpkborkEZIvbLN1sSIOe/CgAAAEAAAAF2sISkPZUNFhZCH+mJkrfUBAAAAAA==@safetylabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We and have found this bug in LECC: Once a central fails to connect =
using
LECC with a BLE peripheral the Central cannot connect to another =
peripheral,
unless until the failed peripheral advertises again. | Weird but true. =
More
details:

1. Consider: Two BLE peripheral devices BLE1 & BLE2.  BLE1 is OFF, =
=A0BLE2 is
advertising=20
2. central> hcitool lecc BLE1 fails since BLE is OFF =20
Example:
> hcitool lecc =A000:07:80:C0:68:C7
Could not create connection: Connection timed out

Now central does NOT connect to any BLE peripheral. This is a VERY BIG
issue.=20

4. central> hcitool lecc BLE2 fails
Example:
central> hcitool lecc 00:07:80:C0:70:24
Could not create connection: Connection timed out

When BLE1 advertises - central can LECC connect to any peripheral device =


5. hcitool lecc BLE2 connects
Example:
> hcitool lecc 00:07:80:C0:70:24
Connection handle 65

BLE central driver maintains a LECC failed connection and fails to LECC
Connect to a peripheral device until the failed peripheral advertises.
A weird and easy to reproduce error - takes 2 BLE devices and a few =
minutes.

Anybody came across this issue?

Regards,
=A0=A0=A0 Sanjay

