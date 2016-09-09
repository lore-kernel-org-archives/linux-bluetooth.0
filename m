Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 9 Sep 2016 13:42:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Montague, Jay" <jmontague@tycoint.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez bluetooth problem
Message-ID: <20160909104247.GA11006@t440s.lan>
References: <9F3DE92910DE1D4697DD7D6F2FB4FDDC25A15990@003FCH1MPN5-071.003f.mgd2.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9F3DE92910DE1D4697DD7D6F2FB4FDDC25A15990@003FCH1MPN5-071.003f.mgd2.msft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay,

On Wed, Sep 07, 2016, Montague, Jay wrote:
> I have tried to send commands using the Eclipse IDE but when I send the following:
> 
> system("echo -e 'agent NoInputNoOutput\n | bluetoothctl");
> 
> On the Edison it reports "No agent is registered" and the following message:

bluetoothctl *is* the agent, and since I assume it exits after piping
the command to it, it's not really a surprise that bluetoothd says there
is no agent.

> #!/bin/sh
> rfkill unblock bluetooth
> sdptool add -channel=22 SP
> sleep 1
> bluetoothctl << EOF
> agent NoInputNoOutput
> EOF
> sleep 1
> 
> Again it just report "No agent is registered".

As I said earlier, that's because bluetoothd presumably exited. It needs
to run in order for an agent to exist.

Regarding sdptool & rfcomm usage, you might want to look into using the
profile API instead (see doc/profile-api.txt and test/test-profile).
It'll take care of the SDP and RFCOMM details for you, and e.g.
completely skip TTYs in favor of RFCOMM sockets (I see you reported that
you had some kernel issues with the TTYs).

Johan
