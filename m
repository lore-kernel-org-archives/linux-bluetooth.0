Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 17 Aug 2011 14:37:55 +0200
Subject: RFC: bluez  traffic managment
Message-ID: <AC090B9732AB2B4DB7FF476E907FE6600131E1C760@dnce02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

First of all,
the description of 2 qos problems that we experience (there may exist more
of course):

1. Piconet ACL coexistence:
HeadSet <--- ACL/A2DP/AVRCP ---> Master <---- ACL/OBEX ----> Slave B
In this scenario user audio experience is unacceptable, since transport 
services do not provide the requested throughput, because the radio is 
shared with Slave B. The solution may be to notify the link manager
with the required bandwidth for the A2DP stream.

2. L2CAP coexistence:
CarKit <---ACL/A2DP/AVRCP/PBAP---> Phone
In this scenario user audio experience is also unsatisfying, but not
due to the link manager, but due to the l2cap. Thus, solution
that work in (1) won`t help here. The need for traffic management
in l2cap is obvious.

So, academically speaking, we have 2 levels of output queues that need to be
managed accordingly to required qos. I propose the following hi-level design 
(that draws on network stack scheduler):

l2cap_1------> l2cap_qsched----------> baseband_qsched
l2cap_2-----^        ^                         ^      
			   |                         |
		Flow classifications     HCI_FLOW_SPEC commands
			   ^
			   |                         |
			   |                         |
	       BT traffic manager ----------------
                     ^
			   |
			   |
		User space control


l2cap_qsched - manages outgoing queues according to flow classifications db.

baseband_qsched - implemented on the controller, controlled with HCI_FLOW_SPEC
commands.

Flow classifications - db that contains flow classifications and qos specs.

BT traffic manager - manages the db, sends HCI_FLOW_SPEC commands, ensures
coherency of qos settings on both levels. E.g.: l2cap_1 is A2DP stream,
requests X KB/s throughput, l2cap_2 is AVRCP, requests 100ms delay.
Both are over the same ACL link, thus, the BT traffic manager should
be able to calculate the baseband_qsched requirements for that particular ACL
correctly. The manager also needs to "sense" the termination of l2cap flows
in order to update the baseband_qsched settings accordingly.
OPEN ISSUE: How to handle l2cap qos negotiation procedures.

User space control - API for controlling BT traffic management. Probably
commands like "Add/Remove classifications". Probably, extensions to
the current management interface or another form of user-space access.
User space control app may look like this:
"bt_tc add -p A2DP -b 160" - request 160KB/s throughput for A2DP

The main question here - is there a chance that something like this
will be accepted in the stack or this is completely off the target? -
We are in need to provide solution for (1) and (2) to our customers,
obviously we want it to be aligned with bluez architecture.
Regards,

Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009

