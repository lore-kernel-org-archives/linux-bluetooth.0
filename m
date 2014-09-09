Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: BLE Delayed encryption change using 
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <002a01cfcc7d$8d290dd0$a77b2970$@lampreynetworks.com>
Date: Tue, 9 Sep 2014 15:44:02 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ACE92FC1-A8DE-4A23-A72E-AD78C158C2E9@holtmann.org>
References: <001301cfc950$ecd06240$c67126c0$@lampreynetworks.com> <3A0E8851-3F10-40A4-A5E8-43BCC727D053@holtmann.org> <002a01cfcc7d$8d290dd0$a77b2970$@lampreynetworks.com>
To: Caleb Reinhold <creinhold@lampreynetworks.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Caleb,

>>> I am attempting to reconnect to a BLE glucometer with gatttool after 
>>> pairing with bluetoothctl. A quick connection update seems to cause a 
>>> large delay (around a minute) in the transmission of the LL_ENC_REQ.
>>> 
>>> Description:
>>> Attempting to connect to an agent which after connecting immediately 
>>> sends an L2CAP update connection parameters request with minimum 
>>> connection interval set to 20 ms, and maximum connection interval set to
> 40 ms.
>>> Increasing both values by 100 ms causes the problem to stop being
> generated.
>>> 
>>> The problem happens only if the dongle using the Broadcom BCM20702 
>>> chipset is used, using a CSR8510 A10 dongle I cannot generate this 
>>> issue. I am using BlueZ 5.22, using Linux kernel 3.10.17. The hardware
> platform is a Utilite.
>> 
>> try using a 3.17-rc3 kernel. We added storing of the connection parameters.
> New connections 
>> will then use the previously requested connection parameters when
> establishing the connection. 
>> Which means the peripheral does not have to request connection updates on
> every connection.
> 
> According to the HCI dump I am not using the saved parameters. I see the
> updated parameters getting saved, but the outgoing connection appears to not
> be using them.

if you run btmon, do you see a mgmt command that indicates that the parameters are actually send to userspace. I think at the moment, we only really store the parameters for devices that are a) in our device list or b) we have paired with.

Regards

Marcel

