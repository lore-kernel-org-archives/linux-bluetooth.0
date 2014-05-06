Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 0/3] Bluetooth LE 6LoWPAN using CoC
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1399382735.2316.3.camel@jrissane-mobl.ger.corp.intel.com>
Date: Tue, 6 May 2014 06:45:50 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D5C53048-F260-4521-94D5-42B6A9C26ADA@holtmann.org>
References: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com> <1536F5A0-B421-41DE-90FA-1BB55F95A4B0@holtmann.org> <1399382735.2316.3.camel@jrissane-mobl.ger.corp.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

>>> here is first version of BT LE 6LoWPAN functionality but using
>>> connection oriented channels instead of fixed channel one.
>>> 
>>> At the moment, the initial configuration needs to be done manually.
>>> So in the slave device say:
>>> # echo node > /sys/kernel/debug/bluetooth/hci0/6lowpan_role
>>> # echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan
>>> # hciconfig hci0 leadv
>>> 
>>> And in the master device say:
>>> # echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan
>>> # hcitool lecc <slave-addr>
>> 
>> my current idea of providing an mgmt API for networking is to introduce HCI_CHANNEL_NETWORK and use a network specific mgmt API on that socket.
>> 
>> This is something to think about. We could extend it to BNEP/PAN as well where we handle the whole connection logic inside the kernel. That way you can easily enable/disable PAN or 6loWPAN. bluetoothd or even an external 6loWPAN daemon could deal with connection establishment and acceptance.
>> 
>> However more importantly this could be easily confined into bluetooth_network.ko at some point in the future and then automatically loaded via bt-chan-4 module aliases. Similar to how we load RFCOMM module via bt-proto-3 when accessing the socket.
>> 
>> Alternative we can create a mgmt subcommand API and then load modules via bt-mgmt-x type of handling once accessing subcommands.
> 
> Is this something for the future or should I implement this in this
> patchset?

start with a debugfs API and having 6loWPAN support separated in its own module. The own module part is really the important thing. We want to keep this out of the core.

Regards

Marcel

