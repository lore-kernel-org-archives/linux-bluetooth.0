Return-Path: <james.cameron@hp.com>
Date: Mon, 28 Jun 2004 20:19:27 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040628101927.GC8871@hp.com>
References: <20040627133325.GA23996@hp.com> <1088366793.3774.70.camel@pegasus> <20040627233437.GD28828@hp.com> <1088408656.3774.136.camel@pegasus> <20040628085356.GA8871@hp.com> <1088413518.3774.167.camel@pegasus> <20040628095541.GB8871@hp.com> <1088417629.3774.177.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088417629.3774.177.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, Jun 28, 2004 at 12:13:49PM +0200, Marcel Holtmann wrote:
> > But dev-up is given the peer's Bluetooth device address.  net.agent is not
> > given this.  Can it be determined from just the interface name?  I could
> > do a "hcitool con" if I knew what the right hci device number was, but
> > it seems sensible to have the dev-up script provide the knowledge.
> 
> it is the same as the ethernet address of the bnep0 interfaces.

No, it isn't.  You're thinking of the local device address.  I'm talking
about the peer's address, which is passed to dev-up by pand.

While the bnep0 interface on the peer has the address, that doesn't
help the local host get it.

Here's output that demonstrates the difference:

# ifconfig bnep0
bnep0     Link encap:Ethernet  HWaddr 00:02:72:01:E5:FF  
          inet addr:10.2.0.1  Bcast:10.255.255.255  Mask:255.255.255.0
          inet6 addr: fe80::202:72ff:fe01:e5ff/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:11 errors:0 dropped:0 overruns:0 frame:0
          TX packets:17 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:761 (761.0 b)  TX bytes:1100 (1.0 KiB)

# hcitool dev
Devices:
        hci0    00:02:72:01:E5:FF
# hcitool con
Connections:
        > ACL 00:02:72:01:E5:F5 handle 42 state 1 lm SLAVE 
#  

-- 
James Cameron
