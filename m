Return-Path: <cyrus@holtmann.org>
Message-ID: <54BBE71F.7050509@cschramm.eu>
Date: Sun, 18 Jan 2015 18:02:23 +0100
From: Christopher Schramm <blueman@cschramm.eu>
MIME-Version: 1.0
To: Jakub Sitnicki <jsitnicki@gmail.com>
CC: linux-bluetooth@vger.kernel.org, blueman@ml.mate-desktop.org
References: <54A956DC.2050100@cschramm.eu> <87k30kgyxg.fsf@frog.home>
In-Reply-To: <87k30kgyxg.fsf@frog.home>
Content-Type: text/plain; charset=iso-8859-15
Subject: Re: Services connected in BlueZ 5
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Also, in case you haven't already seen it, I think you might find
> interesting a part of the discussion of this patchset from some time ago
> (regarding the need to show in UI which services are connected):
> 
> http://thread.gmane.org/gmane.linux.bluez.kernel/36507

thanks for pointing me at this. Unfortunately to me Marcel confirms that
ConnectProfile / DisconnectProfile isn't of any use for management UIs
and even says that this is by design. That leaves me with
Device1.Connect as the only option to connect services and no way to
check which services have actually been connected.

It also seems to mean that connecting a device with a network service
and something else, e.g. and audio service, (say a common Android device
with tethering) results in total confusion for the user. If I'm not
totaling seeing or doing things wrong, we e.g. have the following case:

* Provide user with ways to connect to a) the NAP (Network1) and b) the
"other" services (Device1).

* User requests to connect to NAP -> Call Network1.Connect.

* Device1 changes Connected property to 1 -> Do not provide the way to
connect to the "other" services anymore, since at least some are connected.

This leaves the user with no way to connect to the other services if the
NAP is already connected. Pretty unsatisfactory situation... :/
