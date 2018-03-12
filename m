Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Stephan Mueller <smueller@chronox.de>
To: James Bottomley <jejb@linux.vnet.ibm.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Howells <dhowells@redhat.com>, dwmw2@infradead.org,
        keyrings@vger.kernel.org,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [tpmdd-devel] in-kernel user of ecdsa
Date: Mon, 12 Mar 2018 22:57:28 +0100
Message-ID: <4913167.EB42K91l1O@tauon.chronox.de>
In-Reply-To: <1520891735.4522.45.camel@linux.vnet.ibm.com>
References: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com> <31045526.HZb3ddfbbg@tauon.chronox.de> <1520891735.4522.45.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag, 12. M=E4rz 2018, 22:55:35 CET schrieb James Bottomley:

Hi James,

> > ECDSA is not implemented currently in the kernel crypto API.
>=20
> an ECDSA signature is produced as a ECDH operation using the DSA
> algorithm instead of KDFe, so it's trivial with what we have; signature
> verification involves a separate point addition but we have all the
> primitives for this in crypto/ecc.c so adding it isn't really
> difficult, is it?

No, it is not. There even was a patch posted about a year ago to add ECDSA.=
=20
But it was rejected due to missing in-kernel users. I guess that patch coul=
d=20
be reactivated.

Ciao
Stephan


