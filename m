Return-Path: <cyrus@holtmann.org>
Subject: Re: Getting link quality or RSSI
From: Marcel Holtmann <marcel@holtmann.org>
To: Davide Pesavento <davidepesa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimA4dnDeoZVX1N4c=2sR1JkgAFWb4d0-0K+8S1C@mail.gmail.com>
References: <AANLkTimA4dnDeoZVX1N4c=2sR1JkgAFWb4d0-0K+8S1C@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 08:56:35 -0700
Message-ID: <1280764595.12579.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Davide,

> I'm writing an application to retrieve the current link quality (or
> RSSI) between my laptop's Bluetooth adapter and a specific remote
> device (my mobile phone). In order to do that I'm of course using the
> latest version of BlueZ, but I've encountered several issues so far.
> 
> The dbus API exposed by bluetoothd doesn't have any GetRSSI or
> GetLinkQuality methods. Would it be possible to export these methods
> in the public API?

the link quality is vendor specific according to the specification and
the RSSI of an existing connection is rather useless. So we don't bother
to export those.

> Then I looked at the bluetooth HCI library that comes with bluez.
> First of all, is there any reasons why it's totally undocumented?
> Anyway, I noticed hci_read_link_quality() and hci_read_rssi() in
> hci_lib.h and tried using them. Since they seem to require an
> established connection, I also used hci_create_connection(). However I
> soon discovered that creating a connection requires root privileges,
> is that right or did I do something wrong?
> 
> Furthermore, even when running the program as root, the connection
> gets established only for a few seconds and then it disconnects from
> the remote device. Is this behaviour intended? How can I specify to
> keep the connection alive indefinitely?

If you don't have an active connection that is used, the kernel will
terminate any idle ones. So using hcitool for this is rather pointless
unless you have a profile already using that connection.

Regards

Marcel


