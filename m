Return-Path: <james.cameron@hp.com>
Date: Mon, 28 Jun 2004 19:55:41 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040628095541.GB8871@hp.com>
References: <20040627133325.GA23996@hp.com> <1088366793.3774.70.camel@pegasus> <20040627233437.GD28828@hp.com> <1088408656.3774.136.camel@pegasus> <20040628085356.GA8871@hp.com> <1088413518.3774.167.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088413518.3774.167.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, Jun 28, 2004 at 11:05:18AM +0200, Marcel Holtmann wrote:
> > Just a quick followup question, now that I've read the net.agent script
> > and the README.Debian in the hotplug package ... doesn't this only
> > address the creation of the bnep0 interface when a Bluetooth dongle is
> > plugged in? [...]
> 
> No. The bnep0 interface is only created when there is a PAN connection
> between two devices. No connection, no network interface.

What I didn't know and have now learned was that pand's creation of the
bnep0 interface is a hotplug event, despite there being no actual
physical action.

I've got it working using net.agent and not using dev-up.  Now the
Debian /etc/network/interfaces file looks like this;

mapping hotplug
	script echo

and I had to create a file so that it would take bnep0 down afterwards;

# touch /etc/hotplug/net.enable


But dev-up is given the peer's Bluetooth device address.  net.agent is not
given this.  Can it be determined from just the interface name?  I could
do a "hcitool con" if I knew what the right hci device number was, but
it seems sensible to have the dev-up script provide the knowledge.

-- 
James Cameron
