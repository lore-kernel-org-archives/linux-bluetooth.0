Return-Path: <cyrus@holtmann.org>
Message-ID: <1359113410.8989.3.camel@aeonflux>
Subject: Re: [RFC BlueZ 0/6] LE Connection Establishment fixes
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Jan 2013 12:30:10 +0100
In-Reply-To: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> Sending this as a RFC because I don't know if this is what you guys
> had in mind.
> 
> Patches 1/6/ and 2/6 are simple enough fixes and should be considered
> for inclusion, perhaps 6/6 as well, but the improvement is
> non-functional.
> 
> The only problem with this aproach that I found while testing is the
> problem exposed on the message of commit 5/6: If the remote device is
> out of range during pairing any connection attempt will fail until the
> Connection Complete event comes (with an error). This is the reason
> that we put the devices in the connect list before pairing.
> 
> Is this reason enough to have the device put in the connect list
> during pairing?

such a reasoning is pretty much wrong on all levels. An out of range
device might never come back in range and you end up with a device on
the connect list forever. And if it ever comes back, we end up with some
unexpected connection attempt to that device.

The only sane approach would have been to add a timeout and just abort
the pairing attempt after it. Everything else is just trying to fix a
symptom and making it actually worse while doing so.

Regards

Marcel


