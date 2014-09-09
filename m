Return-Path: <cyrus@holtmann.org>
From: "Caleb Reinhold" <creinhold@lampreynetworks.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <001301cfc950$ecd06240$c67126c0$@lampreynetworks.com> <3A0E8851-3F10-40A4-A5E8-43BCC727D053@holtmann.org>
In-Reply-To: <3A0E8851-3F10-40A4-A5E8-43BCC727D053@holtmann.org>
Subject: RE: BLE Delayed encryption change using 
Date: Tue, 9 Sep 2014 18:29:41 -0400
Message-ID: <002a01cfcc7d$8d290dd0$a77b2970$@lampreynetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

>> I am attempting to reconnect to a BLE glucometer with gatttool after 
>> pairing with bluetoothctl. A quick connection update seems to cause a 
>> large delay (around a minute) in the transmission of the LL_ENC_REQ.
>> 
>> Description:
>> Attempting to connect to an agent which after connecting immediately 
>> sends an L2CAP update connection parameters request with minimum 
>> connection interval set to 20 ms, and maximum connection interval set to
40 ms.
>> Increasing both values by 100 ms causes the problem to stop being
generated.
>> 
>> The problem happens only if the dongle using the Broadcom BCM20702 
>> chipset is used, using a CSR8510 A10 dongle I cannot generate this 
>> issue. I am using BlueZ 5.22, using Linux kernel 3.10.17. The hardware
platform is a Utilite.
>
>try using a 3.17-rc3 kernel. We added storing of the connection parameters.
New connections 
>will then use the previously requested connection parameters when
establishing the connection. 
>Which means the peripheral does not have to request connection updates on
every connection.

According to the HCI dump I am not using the saved parameters. I see the
updated parameters getting saved, but the outgoing connection appears to not
be using them.

Regards

Caleb Reinhold
