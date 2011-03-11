Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 11 Mar 2011 21:30:09 +0000
Message-ID: <AANLkTimP_XBFy58dMDZa69RQ9UKeZmh++jeuH073doLr@mail.gmail.com>
Subject: [RFC] Auto Connections
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Ville Tervo <Ville.Tervo@nokia.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

It is time to get opinions from some gurus!

We need to implement automatic connections to implement the Profiles.
At the moment BlueZ supports only dual mode adapters, as consequence
BlueZ needs to start the LE connection. IMHO, it is better to leave
the responsibility to the controller, implementing "selective"
connections will only introduce more code without concrete benefits.
Configuring the controller to autonomously establish connections seems
to be the right approach to proceed.

This topic is NOT about StartDiscovery() + CreateDevice.
StartDiscovery uses active scanning and CreateDevice uses direct
connection establishment. We need a mechanism to automatically connect
to "trusted" devices or devices flagged as "AutoConnect".


My initial idea is: change the LE server socket to report
outgoing(host initiated) connections through the server socket.
Awkward?
To achieve that we need to manage the LE Create Connection(using
whitelist) in the kernel, extend the management interface to control
devices in the whitelist, change the LE Connection Complete Event
handling to get the Role properly.
Pros:
- Controller manage connections
- Flexible to support  connections to "trusted" resolvable address and
passive scanning
- Only one "flow" for the connections: LE server socket
- Maybe we could hide resolvable address from the userspace, mapping
it directly to public or static random
Cons:
- Risky
- Less control of the connection establishment process


Another approach can be to manage the LE connections(using whitelist)
from the userspace. BDADDR_ANY in the destination field(sockaddr_l2)
can be used to define LE connections using white list.
Pros:
- It will not be necessary to extend the management interface now,
address can be added directly to the controller's white list
- Doesn't require changes in the LE server socket
Cons:
- BDADDR_ANY in the destination field has no meaning for Basic Rate
- Needs to expose the resolvable address to the userspace
- Different "flows" for incoming/outgoing connections


Open issue(s):
* How to handle timeouts when sending LE Create Connection
* Passive scanning management


Cheers,
Claudio
