Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 May 2011 14:27:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siva kumar <sivakumar@ethicstech.in>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to implement just works type ssp pairing in bluez
Message-ID: <20110527112746.GB15238@dell.amr.corp.intel.com>
References: <4DDA4FC9.3090302@ethicstech.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DDA4FC9.3090302@ethicstech.in>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siva,

On Mon, May 23, 2011, Siva kumar wrote:
>             I have two android phones, when i connect two phones
> using bluetooth it generates passkey and displays it for our
> conformation, once we conform, pairing takes place , i was able to
> transmit and receive data via bluetooth. i want to change the
> pairing process to "just works" of SSP. so that the phones connect
> automatically without MITM protection. how to change the pairing
> mode of SSP from numerical comparison

There are two ways how to do this:

1. Make sure neither side requires MITM by setting the security level
for each socket to low.

2. Set NoInputNoOutput as the IO capability for the agent on one or both
sides (you can override the Android agents capability e.g. by doing your
own CreatePairedDevice D-Bus method call).

Johan
