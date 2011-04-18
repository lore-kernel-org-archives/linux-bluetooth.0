Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4DAA27C8.7060800@gmail.com>
References: <BANLkTi=LvyZ+7BHfVL849pztfvsYaVM4SQ@mail.gmail.com>
 <4DA9CB83.4050000@gmail.com> <BANLkTi=avo9yvpQ0VRPRv1uroF3ZnJzfAg@mail.gmail.com>
 <4DAA27C8.7060800@gmail.com>
From: Gottfried Haider <gottfried.haider@gmail.com>
Date: Mon, 18 Apr 2011 09:34:24 +0200
Message-ID: <BANLkTikihzxtp9ep3dE1zpPGKUGm1gij8Q@mail.gmail.com>
Subject: Re: [Regression] Bluetooth pairing does not work anymore in
 2.6.39-rc3 (works in 2.6.38.3)
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> I checked: I have this commit in -rc3, so it must be something else here.
> hmm... seems to be working over here with the latest Mainline. one thing  I
> have notice though is the daemon is not starting during boot(systemd),
> manually starting bluetoothd gets me to connect.(system is fedora 15).

It was my fault after all:

I had based my kernel config on 2.6.39-rc2 from Ubuntu's
mainline-kernel PPA, and this doesn't have BT_L2CAP..

Case closed.


I am just wondering: is it possible to make BT_L2CAP (and SCO?)
default to yes when BT is compiled in or build as a module?

>From commit 6427451: "The L2CAP layer is needed by almost all
Bluetooth protocols and profiles. There isn't any real use case
without having L2CAP loaded." Yet when I am doing oldconfig from a
config that had L2CAP build as a module, I am getting these easily
overlooked lines:

L2CAP protocol support (BT_L2CAP) [N/y/?] (NEW)
SCO links support (BT_SCO) [N/y/?] (NEW)


cheers,
gohai
