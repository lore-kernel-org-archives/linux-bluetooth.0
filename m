Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Dec 2009 19:04:18 +0000 (GMT)
To: Germa Pedrosa <german.pedrosa@fundacionctic.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pairing with several Bluetooth dongles
In-Reply-To: <1259154332.20954.1.camel@german-desktop>
References: <09700B613C4DD84FA9F2FEA52188281903083937@ayalga.fundacionctic.org> <1259154332.20954.1.camel@german-desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1260558258.467003.9352.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 25 Nov 2009, Germa Pedrosa wrote:

I apologise this was a while ago I didn't have anything to say at the time
but it came back to me while I was thinking about something else..

> What I want to achieve is that each device is *paired exactly once*
> against the system despite the dongle D2-DN that finally treats the
> operation.

I think you will get trouble with this approach. As you have found,
pairing is between two dongles and depends on the bdaddr at each end.

> The solution I thought of was using bdaddr tool for assigning the same
> MAC address to all D2 ... DN dongles, in that way that every one uses
> the same linkeys to save paired devices.

Perhaps it will work and perhaps not but I think there will be long term
problems in overlapping areas of coverage using devices with the same
bdaddr. The frequency hopping in the piconet depends also on the master
device clock so at least the devices are likely to be out of sync but
collisions may occur causing intermittent problems, I don't really know.

I think you would probably be better to have the security aspect on a
separate level. ie, you create a token that the higher level stack can
present to authenticate itself upon connecting to the service, leaving the
baseband connection to be unauthenticated.

for example, the OBEX specification contains a means for a device to
authenticate (this is designed so that just plugging in a cable is not
enough to access contents on a device) though I don't think that openobex
supports this so none of the open source OBEX applications would handle
it. Also, higher layer authentication is discussed in the PAN profile
document, like running a VPN over an open wireless point.

regards,
iain


