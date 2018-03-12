Return-Path: <linux-crypto-owner@vger.kernel.org>
Subject: Re: [tpmdd-devel] in-kernel user of ecdsa
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Howells <dhowells@redhat.com>, dwmw2@infradead.org,
        keyrings@vger.kernel.org
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        keyrings@vger.kernel.org
Date: Mon, 12 Mar 2018 11:09:18 -0700
In-Reply-To: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com>
References: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520878158.4522.31.camel@linux.vnet.ibm.com>
Sender: linux-crypto-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2018-03-12 at 19:07 +0200, Tudor Ambarus wrote:
> Hi,
> 
> Would you consider using ECDSA in the kernel module signing facility?
> When compared with RSA, ECDSA has shorter keys, the key generation
> process is faster, the sign operation is faster, but the verify
> operation is slower than with RSA.

You missed the keyrings list, which is where the module signing utility
is discussed.

First question is, have you actually tried?  It looks like sign-file
doesn't do anything RSA specific so if you give it an EC X.509
certificate it will produce an ECDSA signature.

I think our kernel internal x509 parsers don't have the EC OIDs, so
signature verification will fail; but, especially since we have the
rest of the EC machinery in the crypto subsystem, that looks to be
simply fixable.

James
