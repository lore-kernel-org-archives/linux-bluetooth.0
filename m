Return-Path: <cyrus@holtmann.org>
Message-ID: <5488D75C.2010700@netcommwireless.com>
Date: Thu, 11 Dec 2014 10:29:32 +1100
From: Alan Au <alan.au@netcommwireless.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Unable to make subsequent BLE connections
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm connecting to a BLE oximeter device. The first couple of connects 
succeed. But after that the connection always fails. I have tried with 
both gatttool and with my own code. hcidump shows that the "LE Start 
Encryption" command fails with  "PIN or Key Missing". If I delete the 
pairing (that was created by the earlier successful connection) then 
subsequent connects will succeed for a few times again.

I analysed the hcidumps of successful and failed connects. In the failed 
case, it looks to me like bluez is not sending out an SMP PairingRequest 
in response to an SMP SecurityRequest from the slave. I can see in the 
kernel code that smp_cmd_security_req() does not send out the 
PairingRequest if it finds an LTK. But is that correct? Should it not 
try to pair anyway because the remote device is requesting it and may 
have deleted the earlier bonding.

I can provide the detailed hcidumps if anyone needs that.

Thanks.

Alan


______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________
