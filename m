Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>
To: Kropf Johannes <Johannes.Kropf@ait.ac.at>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: bluez 5.40 - RegisterApplication as Client
Date: Wed, 13 Jul 2016 12:51:15 +0000
Message-ID: <ba85090038504a8d8fb05d57589926c7@FE-MBX1011.de.bosch.com>
References: <E92610C73D6DE84EB154DC52F5ECCE541D743728@S0MSMAIL111.arc.local>,<cd0204e760b642a1bfb1f25586ed87be@FE-MBX1011.de.bosch.com>
 <E92610C73D6DE84EB154DC52F5ECCE541D743784@S0MSMAIL111.arc.local>
 <dfc116e86d434a64808bf7e5aafd37b0@FE-MBX1011.de.bosch.com>
 <E92610C73D6DE84EB154DC52F5ECCE541D744B32@S0MSMAIL111.arc.local>
In-Reply-To: <E92610C73D6DE84EB154DC52F5ECCE541D744B32@S0MSMAIL111.arc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

--snip
--snap

> > We seem to have another problem here. Could you try to explain in more
> > detail what goes wrong?
> > 1. What do you expect to happen?
> > 2. What happens?
> 
> 1. I expect that when I register an Application as a client with GattProfile1 objects
> and lists of services that bluetoothd accepts connections only form devices
> providing this profiles/services.
> That makes sense since otherwise data are sent but not handled by an application
> and therefor the data get lost.
> 
> 2. What happens is that as soon as I register my Application with an arbitrary
> GattProfile1 all connections from paired devices are accepted. E.g.  I registered a
> Weight Scale service but also a connection from a blood pressure device gets
> accepted even no service is registerted and no application is existing which is able
> to handle this data.
> 
> Does that make it more clear

I think this might be the problem. Registering only affects the auto-connect behavior (according to code and doku). The BLE central role (your client) completely defines the BLE communication by issuing commands (connect, read characteristic, write characteristic, subscribe to notifications..). The only way for a peripheral to send data to a client without the central actively asking is via notifications. But also in this case a client would need to subscribe to the notifications first. Unhandled data is thus not an issue.
Assuming an implementation following the blocking behavior you described/expected: This would lead to severe problems as soon as you have multiple applications talking to bluez and registering different profiles, wouldn't it?
--> The RegisterProfile behavior is simply not what you expected it to be.
Cheers,
Markus

