Return-Path: <james.cameron@hp.com>
Date: Mon, 28 Jun 2004 18:53:56 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040628085356.GA8871@hp.com>
References: <20040627133325.GA23996@hp.com> <1088366793.3774.70.camel@pegasus> <20040627233437.GD28828@hp.com> <1088408656.3774.136.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088408656.3774.136.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

Just a quick followup question, now that I've read the net.agent script
and the README.Debian in the hotplug package ... doesn't this only
address the creation of the bnep0 interface when a Bluetooth dongle is
plugged in?

In my situation, the dongle is always plugged in, but without a network
interface most of the time.

pand is running --listen --role NAP, and receives a call from one of my
other computers.  pand accepts the connection, and invokes dev-up which
brings up bnep0 with "ifup $1".

-- 
James Cameron
