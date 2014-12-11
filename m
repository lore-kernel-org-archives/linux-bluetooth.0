Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Dec 2014 09:36:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alan Au <alan.au@netcommwireless.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Unable to make subsequent BLE connections
Message-ID: <20141211073659.GA14258@t440s.P-661HNU-F1>
References: <5488D75C.2010700@netcommwireless.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5488D75C.2010700@netcommwireless.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

On Thu, Dec 11, 2014, Alan Au wrote:
> I'm connecting to a BLE oximeter device. The first couple of connects
> succeed. But after that the connection always fails. I have tried with both
> gatttool and with my own code. hcidump shows that the "LE Start Encryption"
> command fails with  "PIN or Key Missing". If I delete the pairing (that was
> created by the earlier successful connection) then subsequent connects will
> succeed for a few times again.
> 
> I analysed the hcidumps of successful and failed connects. In the failed
> case, it looks to me like bluez is not sending out an SMP PairingRequest in
> response to an SMP SecurityRequest from the slave. I can see in the kernel
> code that smp_cmd_security_req() does not send out the PairingRequest if it
> finds an LTK. But is that correct? Should it not try to pair anyway because
> the remote device is requesting it and may have deleted the earlier bonding.

According to the SMP specification "The Security Request command is used
by the slave to request that the master initiates security with the
requested security properties". That doesn't talk about always sending a
Pairing Request but initiating security, which makes sense since there'd
otherwise be no other way for the slave to request the connection to be
encrypted with a shared LTK.

So sounds like your device is for whatever reason (maybe it's broken)
loosing its pairing information after some time. Even though our
behavior with the Security Request should be correct we could consider
the reaction to the "PIN or Key Missing" error. There's a table in
section 2.4.4.2 of the SMP specification (page 2321 of core spec 4.2)
that explains the allowed behavior in this scenario. However, if bonding
was performed (which I suspect it was) the table only gives the option
of notifying the user of the failure (which is what we do right now).

> I can provide the detailed hcidumps if anyone needs that.

Sure, but preferably with btmon instead of hcidump. Please include the
original pairing procedure in addition to the failure so that we can see
whether bonding was performed or not (otoh since you say that you had at
least a second successful connection it sounds like you must have done
bonding).

Johan
