Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Montague, Jay" <jmontague@tycoint.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: bluez bluetooth problem
Date: Fri, 9 Sep 2016 15:14:49 +0000
Message-ID: <9F3DE92910DE1D4697DD7D6F2FB4FDDC25A15D91@003FCH1MPN5-071.003f.mgd2.msft.net>
References: <9F3DE92910DE1D4697DD7D6F2FB4FDDC25A15990@003FCH1MPN5-071.003f.mgd2.msft.net>
 <20160909104247.GA11006@t440s.lan>
In-Reply-To: <20160909104247.GA11006@t440s.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

When I manually enter the command "agent NoInputNoOutput" in bluetoothctl i=
t works and registers the agent to be used for when pairing to a Bluetooth =
device. But when I try the same command in code it doesn't register it like=
 I described originally, and it doesn't exit bluetoothctl either. It also d=
oesn't work with other commands like "discoverable on" etc.

But I guess ill look into using the API profile instead. You didn't attach =
any documents so I guess these are available on github or something.

Jay

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
Sent: 09 September 2016 11:43
To: Montague, Jay <jmontague@tycoint.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez bluetooth problem

Hi Jay,

On Wed, Sep 07, 2016, Montague, Jay wrote:
> I have tried to send commands using the Eclipse IDE but when I send the f=
ollowing:
>
> system("echo -e 'agent NoInputNoOutput\n | bluetoothctl");
>
> On the Edison it reports "No agent is registered" and the following messa=
ge:

bluetoothctl *is* the agent, and since I assume it exits after piping the c=
ommand to it, it's not really a surprise that bluetoothd says there is no a=
gent.

> #!/bin/sh
> rfkill unblock bluetooth
> sdptool add -channel=3D22 SP
> sleep 1
> bluetoothctl << EOF
> agent NoInputNoOutput
> EOF
> sleep 1
>
> Again it just report "No agent is registered".

As I said earlier, that's because bluetoothd presumably exited. It needs to=
 run in order for an agent to exist.

Regarding sdptool & rfcomm usage, you might want to look into using the pro=
file API instead (see doc/profile-api.txt and test/test-profile).
It'll take care of the SDP and RFCOMM details for you, and e.g.
completely skip TTYs in favor of RFCOMM sockets (I see you reported that yo=
u had some kernel issues with the TTYs).

Johan

________________________________

This e-mail contains privileged and confidential information intended for t=
he use of the addressees named above. If you are not the intended recipient=
 of this e-mail, you are hereby notified that you must not disseminate, cop=
y or take any action in respect of any information contained in it. If you =
have received this e-mail in error, please notify the sender immediately by=
 e-mail and immediately destroy this e-mail and its attachments.
