Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2009 10:04:04 -0700
Message-ID: <8c237ea80907131004o6fd32ad3ia33e6acc5a952679@mail.gmail.com>
Subject: Simplest Host-To-Host Network Config?
From: Hibiki Kanzaki <hibikikanzaki@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to configure the most basic point-to-point
Bluetooth IP network.  I have two computers with the
same model of USB Bluetooth (2.0, EDR, etc) dongle
attached to them.  I am running Ubuntu Jaunty on both
computers.  I do not have GUI (desktop) applications
installed on them.  Ubuntu Jaunty comes with bluez
4.32.  All I want is the most simple possible
configuration... the minimal amount of configuration
necessary to be able to have applications one the
computers interact using TCP/UDP/IP via Linux network
devices.  I do not care about forwarding packets to
other hosts, or about encryption or authentication,
etc; I am trying to start with the equivalent of
connecting two ethernet cards.

When I connect the Bluetooth dongle, I get a
"pan0" linux network device on which I can perform
commands like "ip link set ...", "ip addr add ...",
etc.  They all succeed and I can ping the local
device address.  Each computer can do this local
interaction with the pan0 network device.  I can
also do "hcitool scan" to see the remote Bluetooth
devices, and I can do "hcitool info", "l2ping", etc.
The device advertises "PAN", "GN", etc, services,
so I do not think it is a limitation of devices.

So on each side I can see and interact with the
local pan0 network device, and I can use the
"hciconfig" and "hcitool" to get some degree of
interaction between the two computers.  But if I
configure the pan0 devices as I would a regular
network device, including adding ARP entries which
have the layer2 address of the remote pan0, I cannot
seem to get the IP layer of the Linux kernel to
actually talk to the remote Bluetooth device using
the Linux kernel network facilities.  If I run
"hcidump", I do not see anything happening if I try
to ping the remote Bluetooth interface.

Am I missing something simple?  I am not having any
luck finding how to do what seems like it should be
trivial... plugin a Bluetooth dongle on each side
and be able to send IP packets from one to the other
using the Linux network devices.  I am clueless
about the details of Bluetooth protocols.  If I
cannot get the networking working this way, I would
be willing to have the devices connected to each
other as a serial port, and then just run ppp over
that, although I have no idea how to do that, since
I have never tried or looked into it.
