Return-Path: <cyrus@holtmann.org>
Message-ID: <1399382735.2316.3.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH 0/3] Bluetooth LE 6LoWPAN using CoC
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 06 May 2014 16:25:35 +0300
In-Reply-To: <1536F5A0-B421-41DE-90FA-1BB55F95A4B0@holtmann.org>
References: 
	<1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1536F5A0-B421-41DE-90FA-1BB55F95A4B0@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ma, 2014-05-05 at 19:22 -0700, Marcel Holtmann wrote:
> Hi Jukka,
> 
> > here is first version of BT LE 6LoWPAN functionality but using
> > connection oriented channels instead of fixed channel one.
> > 
> > At the moment, the initial configuration needs to be done manually.
> > So in the slave device say:
> > # echo node > /sys/kernel/debug/bluetooth/hci0/6lowpan_role
> > # echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan
> > # hciconfig hci0 leadv
> > 
> > And in the master device say:
> > # echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan
> > # hcitool lecc <slave-addr>
> 
> my current idea of providing an mgmt API for networking is to introduce HCI_CHANNEL_NETWORK and use a network specific mgmt API on that socket.
> 
> This is something to think about. We could extend it to BNEP/PAN as well where we handle the whole connection logic inside the kernel. That way you can easily enable/disable PAN or 6loWPAN. bluetoothd or even an external 6loWPAN daemon could deal with connection establishment and acceptance.
> 
> However more importantly this could be easily confined into bluetooth_network.ko at some point in the future and then automatically loaded via bt-chan-4 module aliases. Similar to how we load RFCOMM module via bt-proto-3 when accessing the socket.
> 
> Alternative we can create a mgmt subcommand API and then load modules via bt-mgmt-x type of handling once accessing subcommands.

Is this something for the future or should I implement this in this
patchset?


Cheers,
Jukka
